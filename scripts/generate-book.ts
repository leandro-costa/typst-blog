import { writeTextFile, type Post } from "./lib.ts";
import { escapeTypstString, identFromSlug, metaToTypstTuple } from "./typst-helpers.ts";

export interface BookOptions {
  title: string;
  subtitle: string;
  author: string;
  date: string;
}

export async function generateBook(
  posts: Post[],
  outputPath: string,
  options: BookOptions
): Promise<void> {
  const lines: string[] = [];
  // Livro em ordem cronológica: aulas mais antigas primeiro (inverso do site).
  const ordered = [...posts].reverse();

  lines.push("// Gerado automaticamente — não edite à mão.");
  lines.push('#import "templates/book.typ": book-template');
  lines.push("");

  for (const p of ordered) {
    lines.push(`#import "posts/${p.filename}" as ${identFromSlug(p.meta.slug)}`);
  }
  lines.push("");

  // Array de metadados para o sumário
  lines.push("#let posts-meta = (");
  for (const p of ordered) {
    lines.push("  " + metaToTypstTuple(p) + ",");
  }
  lines.push(")");
  lines.push("");

  // Template do livro
  lines.push("#book-template(");
  lines.push(`  title: "${escapeTypstString(options.title)}",`);
  lines.push(`  subtitle: "${escapeTypstString(options.subtitle)}",`);
  lines.push(`  author: "${escapeTypstString(options.author)}",`);
  lines.push(`  date: "${escapeTypstString(options.date)}",`);
  lines.push("  posts: posts-meta,");
  lines.push(")[");
  lines.push("");

  // Cada post como capítulo
  for (const p of ordered) {
    lines.push(`  #pagebreak()`);
    lines.push(`  #${identFromSlug(p.meta.slug)}`);
    lines.push("");
  }

  lines.push("]");

  await writeTextFile(outputPath, lines.join("\n"));
}