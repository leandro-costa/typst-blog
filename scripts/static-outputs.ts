import { writeTextFile, type Post } from "./lib.ts";
import { toIsoDateTime } from "./typst-helpers.ts";

function xmlEscape(s: string): string {
  return s
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;");
}

// Emite dist/search-index.json para a busca client-side.
export async function writeSearchIndex(distDir: string, posts: Post[]): Promise<void> {
  const index = posts.map((p) => ({
    title: p.meta.title,
    slug: p.meta.slug,
    date: p.meta.date,
    tags: p.meta.tags ?? [],
    excerpt: p.meta.excerpt ?? "",
    url: `/posts/${p.meta.slug}.html`,
  }));
  await writeTextFile(`${distDir}/search-index.json`, JSON.stringify(index, null, 2));
}

// Emite dist/rss.xml (Atom) a partir dos metadados, ordenado por data desc.
export async function writeRss(
  distDir: string,
  posts: Post[],
  siteTitle: string,
  baseUrl: string
): Promise<void> {
  const sorted = [...posts].sort(
    (a, b) => new Date(toIsoDateTime(b.meta.date)).getTime() - new Date(toIsoDateTime(a.meta.date)).getTime()
  );
  const now = new Date().toISOString();

  const entries = sorted
    .map((p) => {
      const link = `${baseUrl}/posts/${p.meta.slug}.html`;
      const id = `${baseUrl}/posts/${p.meta.slug}.html`;
      const title = xmlEscape(p.meta.title);
      const excerpt = xmlEscape(p.meta.excerpt ?? "");
      const date = new Date(toIsoDateTime(p.meta.date)).toISOString();
      return [
        "  <entry>",
        `    <title>${title}</title>`,
        `    <link href="${link}"/>`,
        `    <id>${id}</id>`,
        `    <updated>${date}</updated>`,
        `    <published>${date}</published>`,
        `    <summary>${excerpt}</summary>`,
        "  </entry>",
      ].join("\n");
    })
    .join("\n");

  const xml = [
    '<?xml version="1.0" encoding="utf-8"?>',
    '<feed xmlns="http://www.w3.org/2005/Atom">',
    `  <title>${xmlEscape(siteTitle)}</title>`,
    `  <id>${baseUrl}/</id>`,
    `  <link href="${baseUrl}/rss.xml" rel="self"/>`,
    `  <updated>${now}</updated>`,
    entries,
    "</feed>",
    "",
  ].join("\n");

  await writeTextFile(`${distDir}/rss.xml`, xml);
}