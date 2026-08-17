import { writeTextFile, ensureDir, runCommand, exists, removeDir, type Post } from "./lib.ts";

const SVG_ROOT = ".svg";
const DIST_SVG = "dist/posts";

// Gera um wrapper .typ por post que define a página contínua (height: auto),
// os contadores sequenciais (sec-N / fig-N) e os `#show` que emitem as âncoras,
// e então inclui o post (corpo paged). Compila cada wrapper para
// `dist/posts/<slug>.svg`.
export async function generateSvgs(posts: Post[]): Promise<void> {
  if (await exists(SVG_ROOT)) await removeDir(SVG_ROOT);
  await ensureDir(SVG_ROOT);
  await ensureDir(DIST_SVG);

  for (const p of posts) {
    const wrapper = buildWrapper(p);
    const srcPath = `${SVG_ROOT}/${p.meta.slug}.typ`;
    await writeTextFile(srcPath, wrapper);
    const result = await runCommand("typst", [
      "compile",
      "--root", ".",
      "--input", "svg=true",
      "--format", "svg",
      srcPath,
      `${DIST_SVG}/${p.meta.slug}.svg`,
    ]);
    if (!result.success) {
      console.error(`❌ Erro ao compilar SVG de ${p.meta.slug}:`);
      console.error(result.stderr);
      throw new Error(`Falha ao gerar SVG do post ${p.meta.slug}`);
    }
  }

  await removeDir(SVG_ROOT);
}

// Monta o wrapper .typ que renderiza o post como SVG contínuo com âncoras.
function buildWrapper(post: Post): string {
  const lines: string[] = [];
  lines.push("// Gerado automaticamente — não edite à mão.");
  lines.push("#set page(height: auto, margin: 10pt)");
  lines.push("#let toc-seq = counter(\"toc-seq\")");
  lines.push("#let fig-seq = counter(\"fig-seq\")");
  lines.push("#show heading: it => {");
  lines.push("  toc-seq.step()");
  lines.push("  let n = toc-seq.get().first()");
  lines.push('  link("#sec-" + str(n))[#it]');
  lines.push("}");
  lines.push("#show figure: it => {");
  lines.push("  fig-seq.step()");
  lines.push("  let n = fig-seq.get().first()");
  lines.push('  link("#fig-" + str(n))[#it]');
  lines.push("}");
  lines.push("#show link: it => {");
  lines.push("  let d = it.dest");
  lines.push("  if type(d) == label {");
  lines.push('    link("#" + str(d))[#it.body]');
  lines.push("  } else {");
  lines.push("    it");
  lines.push("  }");
  lines.push("}");
  lines.push(`#include "../posts/${post.filename}"`);
  return lines.join("\n");
}