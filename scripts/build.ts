// Build: gera site.typ (bundle HTML) + book.typ (PDF A4) a partir de posts/.
// ORDEM: livro primeiro não é necessário aqui; cada artefato compila em paralelo.

import {
  ensureDir,
  removeDir,
  runCommand,
  exists,
  readFileBytes,
  writeFileBytes,
  loadConfig,
  deriveBasePath,
  readDir,
  exit,
} from "./lib.ts";
import { loadPosts } from "./parse-posts.ts";
import { generateSite } from "./generate-site.ts";
import { generateBook } from "./generate-book.ts";
import { writeSearchIndex, writeRss } from "./static-outputs.ts";

const POSTS_DIR = "posts";
const DIST_DIR = "dist";
const SITE_FILE = "site.typ";
const BOOK_FILE = "book.typ";
const CONFIG_FILE = "typst.dev.toml";

async function build(): Promise<void> {
  console.log("🚀 Typst Blog — Builder");
  console.log("===========================\n");

  // 0. Carrega configuração do typst.toml
  console.log(`⚙️  Lendo configuração de ${CONFIG_FILE}...`);
  const config = await loadConfig(CONFIG_FILE);
  console.log(`   ✓ site: ${config.site.title}`);
  console.log(`   ✓ book: ${config.book.title} (${config.book.author})\n`);

  if (config.site.url === "https://example.org" || config.site.url === "") {
    throw new Error("site.url em typst.toml é o placeholder (https://example.org). Defina a URL real do site para gerar o base path.");
  }

  // Base path: derive de site.url; SITE_BASE (env) tem prioridade (ex.: "" para preview local na raiz).
  const base = process.env.SITE_BASE ?? deriveBasePath(config.site.url);
  console.log(`   ✓ base path: "${base}"\n`);

  // 1. Carrega posts
  console.log("📂 Carregando posts...");
  const posts = await loadPosts(POSTS_DIR);
  if (posts.length === 0) {
    throw new Error("Nenhum post válido encontrado em posts/ (aulas|exercicios|solucoes|trabalhos/<grupo>-<seq>-<slug>.typ)");
  }
  console.log(`   ✓ ${posts.length} post(s) encontrado(s)`);
  for (const p of posts) {
    console.log(`     · ${p.meta.title} (${p.meta.date})`);
  }
  console.log();

  // 2. Limpa e recria dist/
  console.log("🧹 Limpando dist/...");
  if (await exists(DIST_DIR)) await removeDir(DIST_DIR);
  await ensureDir(DIST_DIR);
  await ensureDir(`${DIST_DIR}/posts`);
  console.log("   ✓ dist/ limpo\n");

  // 3. Gera site.typ
  console.log("📝 Gerando site.typ...");
  await generateSite(posts, SITE_FILE, {
    title: config.site.title,
    subtitle: config.site.subtitle,
    author: config.site.author,
  }, base);
  console.log("   ✓ site.typ gerado\n");

  // 4. Compila o SITE (bundle HTML)
  console.log("🌐 Compilando site (bundle HTML)...");
  const siteResult = await runCommand("typst", [
    "compile",
    "--input", `base=${base}`,
    "--features", "bundle,html",
    "--format", "bundle",
    SITE_FILE,
    `${DIST_DIR}/`,
  ]);
  if (!siteResult.success) {
    console.error("❌ Erro na compilação do site:");
    console.error(siteResult.stderr);
    throw new Error("Falha ao compilar o site");
  }
  console.log("   ✓ Site compilado\n");

  // 5. Gera book.typ
  console.log("📝 Gerando book.typ...");
  await generateBook(posts, BOOK_FILE, {
    title: config.book.title,
    subtitle: config.book.subtitle,
    author: config.book.author,
    date: new Date().toISOString().split("T")[0],
  });
  console.log("   ✓ book.typ gerado\n");

  // 6. Compila o LIVRO (PDF A4)
  console.log("📄 Compilando livro PDF...");
  const bookResult = await runCommand("typst", [
    "compile",
    BOOK_FILE,
    `${DIST_DIR}/book.pdf`,
  ]);
  if (!bookResult.success) {
    console.error("❌ Erro na compilação do livro:");
    console.error(bookResult.stderr);
    throw new Error("Falha ao compilar o livro");
  }
  console.log("   ✓ Livro compilado: dist/book.pdf\n");

  // 7. Copia assets
  console.log("📦 Copiando assets...");
  await copyAssets("assets", `${DIST_DIR}/assets`);
  console.log("   ✓ Assets copiados\n");

  // 8. Gera saídas estáticas (busca + RSS)
  console.log("🔍 Gerando search-index.json e rss.xml...");
  await writeSearchIndex(DIST_DIR, posts, base);
  await writeRss(DIST_DIR, posts, config.site.title, config.site.url);
  console.log("   ✓ search-index.json e rss.xml\n");

  console.log("✅ Build completo!");
  console.log("");
  console.log("📁 Arquivos gerados:");
  console.log("   · dist/index.html");
  console.log("   · dist/posts/*.html");
  console.log("   · dist/book.pdf  ← 📖 Download do livro");
  console.log("   · dist/assets/");
  console.log("");
  console.log("🌐 Preview local: bun run serve");
}

async function copyAssets(src: string, dst: string): Promise<void> {
  await ensureDir(dst);
  for await (const entry of readDir(src)) {
    const srcPath = `${src}/${entry.name}`;
    const dstPath = `${dst}/${entry.name}`;
    if (entry.isDirectory) {
      await copyAssets(srcPath, dstPath);
    } else {
      const data = await readFileBytes(srcPath);
      await writeFileBytes(dstPath, data);
    }
  }
}

export { build };

if (import.meta.main) {
  build().catch((err) => {
    console.error("❌ Erro fatal:", err);
    exit(1);
  });
}