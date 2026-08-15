import { writeTextFile, joinBasePath, type Post } from "./lib.ts";
import { escapeTypstString, identFromSlug, metaToTypstTuple, toIsoDateTime } from "./typst-helpers.ts";

export interface SiteOptions {
  title: string;
  subtitle: string;
  author: string;
}

function uniqueTags(posts: Post[]): string[] {
  const set = new Set<string>();
  for (const p of posts) for (const t of p.meta.tags ?? []) set.add(t);
  return [...set].sort((a, b) => a.localeCompare(b));
}

function recentPosts(posts: Post[], n: number): Post[] {
  return [...posts]
    .sort((a, b) => new Date(toIsoDateTime(b.meta.date)).getTime() - new Date(toIsoDateTime(a.meta.date)).getTime())
    .slice(0, n);
}

// Extrai headings reais (`=`, `==`, ...) do corpo de um post, ignorando blocos
// de código (fenced code blocks). Retorna nível e texto limpo para o TOC.
function parseToc(body: string): { level: number; text: string }[] {
  const out: { level: number; text: string }[] = [];
  let inFence = false;
  for (const line of body.split("\n")) {
    const t = line.trim();
    if (t.startsWith("```")) {
      inFence = !inFence;
      continue;
    }
    if (inFence) continue;
    const m = t.match(/^(=+)\s+(.*)$/);
    if (m) {
      let text = m[2]
        .replace(/\$[^$]*\$/g, "")
        .replace(/`[^`]*`/g, "")
        .replace(/\*([^*]*)\*/g, "$1")
        .replace(/_([^_]*)_/g, "$1")
        .trim();
      out.push({ level: m[1].length, text });
    }
  }
  return out;
}

export async function generateSite(
  posts: Post[],
  outputPath: string,
  options: SiteOptions,
  base: string
): Promise<void> {
  const lines: string[] = [];
  const siteTitle = options.title;
  const siteSubtitle = options.subtitle;
  const siteAuthor = options.author;

  lines.push("// Gerado automaticamente — não edite à mão.");
  lines.push('#import "templates/site.typ": site-layout, hero, post-list, post-list-filtered, post-list-by-type, post-nav');
  lines.push('#import "templates/post.typ": post-layout');
  lines.push("");
  lines.push(`#let base = "${escapeTypstString(base)}"`);
  lines.push("");

  // Importa cada post como módulo
  for (const p of posts) {
    lines.push(`#import "posts/${p.filename}" as ${identFromSlug(p.meta.slug)}`);
  }
  lines.push("");

  // Metadados de todos os posts (cards da home)
  lines.push("#let posts-meta = (");
  for (const p of posts) {
    lines.push("  " + metaToTypstTuple(p, siteAuthor) + ",");
  }
  lines.push(")");
  lines.push("");

  // Guard de preview (paged): página tipografada sem elementos HTML-only.
  lines.push('#let is-preview = "x-preview" in sys.inputs');
  lines.push("");
  lines.push("#if is-preview [");
  lines.push(`  #site-layout(title: [${escapeTypstString(siteTitle)}])[`);
  lines.push("    #hero(title: [" + escapeTypstString(siteTitle) + "], subtitle: [" + escapeTypstString(siteSubtitle) + "])");
  lines.push("    #post-list(posts-meta)");
  lines.push("    #v(1.5em)");
  lines.push("    #pagebreak()");
  for (const p of posts) {
    lines.push(`    #post-layout(${identFromSlug(p.meta.slug)}.meta, ${identFromSlug(p.meta.slug)}.body, default-author: "${escapeTypstString(siteAuthor)}")`);
    lines.push("    #pagebreak()");
  }
  lines.push("  ]");
  lines.push("] else [");
  lines.push("");

  // Dados HTML-only (usados apenas no bundle): tags, recentes, sidebar, categorias
  const tags = uniqueTags(posts);
  const recent = recentPosts(posts, 5);
  const TYPE_ORDER = ["aula", "exercicio", "solucao", "trabalho"];
  const categories = TYPE_ORDER.filter((t) => posts.some((p) => p.meta.type === t));

  lines.push("  #let tags-meta = (" + tags.map((t) => `"${escapeTypstString(t)}"`).join(", ") + ")");
  lines.push("  #let categories-meta = (" + categories.map((c) => `"${escapeTypstString(c)}"`).join(", ") + ")");
  lines.push("  #let recent-meta = (");
  for (const p of recent) {
    lines.push(`    (title: "${escapeTypstString(p.meta.title)}", slug: "${escapeTypstString(p.meta.slug)}"),`);
  }
  lines.push("  )");
  lines.push("");
lines.push("  #let sidebar-sections = [");
  lines.push('    #html.elem("div", attrs: (class: "sidebar-section"))[');
  lines.push('      #html.elem("h4")[Tags]');
  lines.push('      #for tag in tags-meta [');
  lines.push('        #html.elem("a", attrs: (href: base + "/tags/" + tag + ".html", class: "tag-link"))[#tag]');
  lines.push("      ]");
  lines.push("    ]");
  lines.push('    #html.elem("div", attrs: (class: "sidebar-section"))[');
  lines.push('      #html.elem("h4")[Recentes]');
  lines.push('      #for post in recent-meta [');
  lines.push('        #html.elem("a", attrs: (href: base + "/posts/" + post.slug + ".html"))[#post.title]');
  lines.push("      ]");
  lines.push("    ]");
  lines.push('    #html.elem("div", attrs: (class: "sidebar-section"))[');
  lines.push('      #html.elem("a", attrs: (href: base + "/book.pdf", class: "btn-primary"))[📖 Baixar Livro em PDF]');
  lines.push("    ]");
  lines.push("  ]");
  lines.push("  #let site-sidebar = [");
  lines.push('    #html.elem("aside", attrs: (class: "sidebar"))[#sidebar-sections]');
  lines.push("  ]");
  lines.push("");

  // Home
  lines.push(`  #document("index.html", title: [${escapeTypstString(siteTitle)}])[`);
  lines.push(`    #site-layout(title: [${escapeTypstString(siteTitle)}], brand: [${escapeTypstString(siteTitle)}], sidebar: site-sidebar, categories: categories-meta)[`);
  lines.push("      #hero(title: [" + escapeTypstString(siteTitle) + "], subtitle: [" + escapeTypstString(siteSubtitle) + "])");
  lines.push("      #post-list(posts-meta)");
  lines.push("    ]");
  lines.push("  ]");
  lines.push("");

  // Uma página por post (com prev/next). TOC escopado ao post (ids #loc-N do próprio documento).
  for (let i = 0; i < posts.length; i++) {
    const p = posts[i];
    const ident = identFromSlug(p.meta.slug);
    const prev = i > 0 ? posts[i - 1] : null;
    const next = i < posts.length - 1 ? posts[i + 1] : null;
    const toc = parseToc(p.body);

    lines.push("  #let post-sidebar = [");
    lines.push('    #html.elem("aside", attrs: (class: "sidebar"))[');
    lines.push('      #html.elem("div", attrs: (class: "sidebar-section toc"))[');
    lines.push('        #html.elem("div", attrs: (class: "toc-header"))[');
    lines.push('          #html.elem("h4")[Neste post]');
    lines.push('          #html.elem("button", attrs: (id: "toggle-sidebar", class: "icon-btn icon-btn-sm", type: "button", title: "Mostrar/ocultar sumário", "aria-label": "Mostrar/ocultar sumário"))[☰]');
    lines.push('        ]');
    if (toc.length > 0) {
      lines.push('        #html.elem("ol", attrs: (class: "toc-list"))[');
      toc.forEach((item, idx) => {
        lines.push(`          #html.elem("li", attrs: (class: "toc-l${item.level}"))[`);
        lines.push(`            #html.elem("a", attrs: (href: "#toc-item-${idx}"))[#text("${escapeTypstString(item.text)}")]`);
        lines.push("          ]");
      });
      lines.push("        ]");
    } else {
      lines.push('        #html.elem("p", attrs: (class: "toc-empty"))[Sem tópicos]');
    }
    lines.push("      ]");
    lines.push("    ]");
    lines.push("  ]");
    lines.push("");

    lines.push(`  #document("posts/${p.meta.slug}.html", title: [#${ident}.meta.title])[`);
    lines.push(`    #site-layout(title: [#${ident}.meta.title], brand: [${escapeTypstString(siteTitle)}], sidebar: post-sidebar, sidebar-left: true, categories: categories-meta)[`);
    lines.push(`      #post-layout(${ident}.meta, ${ident}.body, default-author: "${escapeTypstString(siteAuthor)}")`);
    lines.push(`      #post-nav(prev: ${prev ? metaToTypstTuple(prev, siteAuthor) : "none"}, next: ${next ? metaToTypstTuple(next, siteAuthor) : "none"})`);
    lines.push("    ]");
    lines.push("  ]");
    lines.push("");
  }

  // Uma página por tag
  for (const tag of tags) {
    lines.push(`  #document("tags/${tag}.html", title: [Posts com a tag ${tag}])[`);
    lines.push(`    #site-layout(title: [Posts: ${tag}], brand: [${escapeTypstString(siteTitle)}], sidebar: site-sidebar, categories: categories-meta)[`);
    lines.push(`      #post-list-filtered(posts-meta, "${escapeTypstString(tag)}")`);
    lines.push("    ]");
lines.push("  ]");
    lines.push("");
  }

  // Uma página por categoria (tipo: aula, exercicio, solucao, trabalho)
  for (const cat of categories) {
    lines.push(`  #document("categorias/${cat}.html", title: [Categoria: ${cat}])[`);
    lines.push(`    #site-layout(title: [Categoria: ${cat}], brand: [${escapeTypstString(siteTitle)}], sidebar: site-sidebar, categories: categories-meta)[`);
    lines.push(`      #post-list-by-type(posts-meta, "${cat}")`);
    lines.push("    ]");
    lines.push("  ]");
    lines.push("");
  }

  // Página de Referências (nativo #bibliography)
  lines.push('  #document("referencias.html", title: [Referências])[');
  lines.push(`    #site-layout(title: [Referências], brand: [${escapeTypstString(siteTitle)}], sidebar: site-sidebar, categories: categories-meta)[`);
  lines.push('      #bibliography("refs.bib", title: "Referências", full: true)');
  lines.push("    ]");
  lines.push("  ]");
  lines.push("");

  lines.push("]");

  await writeTextFile(outputPath, lines.join("\n"));
}

