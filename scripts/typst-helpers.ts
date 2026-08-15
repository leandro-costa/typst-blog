import type { Post } from "./lib.ts";

export function escapeTypstString(s: string): string {
  return s
    .replace(/\\/g, "\\\\")
    .replace(/"/g, '\\"')
    .replace(/\n/g, "\\n");
}

// Converte "YYYY-MM-DD[ HH:MM[:SS]]" → "DD/MM/YYYY[ HH:MM]" (padrão brasileiro).
// Ex.: "2026-08-14" → "14/08/2026"; "2026-08-14 15:30:00" → "14/08/2026 15:30".
export function formatDateBR(iso: string): string {
  const m = iso.match(/^(\d{4})-(\d{2})-(\d{2})(?:[T ](\d{2}):(\d{2})(?::(\d{2}))?)?/);
  if (!m) return iso;
  let s = `${m[3]}/${m[2]}/${m[1]}`;
  if (m[4]) s += ` ${m[4]}:${m[5]}`;
  return s;
}

// Normaliza "YYYY-MM-DD[ HH:MM[:SS]]" para ISO UTC (para `new Date()`/ordenação).
export function toIsoDateTime(iso: string): string {
  const m = iso.match(/^(\d{4})-(\d{2})-(\d{2})[T ](\d{2}):(\d{2})(?::(\d{2}))?/);
  if (m) {
    return `${m[1]}-${m[2]}-${m[3]}T${m[4]}:${m[5]}:${m[6] ?? "00"}Z`;
  }
  return `${iso}T00:00:00Z`;
}

export function identFromSlug(slug: string): string {
  let ident = slug.replace(/[^a-zA-Z0-9_]/g, "_");
  if (ident && /^\d/.test(ident)) ident = "p_" + ident;
  return "post_" + ident;
}

// Serializa a meta de um post como uma tupla/dict Typst (para lists/arrays).
// `defaultAuthor` (autor do blog) é usado quando o post não define autor.
export function metaToTypstTuple(post: Post, defaultAuthor?: string): string {
  const m = post.meta;
  const author = m.author ?? defaultAuthor;
  const parts: string[] = [];
  parts.push(`title: "${escapeTypstString(m.title)}"`);
  parts.push(`date: "${escapeTypstString(m.date)}"`);
  parts.push(`date-pt: "${escapeTypstString(formatDateBR(m.date))}"`);
  parts.push(`slug: "${escapeTypstString(m.slug)}"`);
  parts.push(`type: "${escapeTypstString(m.type)}"`);
  parts.push(`group: "${escapeTypstString(m.group)}"`);
  if (author) parts.push(`author: "${escapeTypstString(author)}"`);
  if (m.excerpt) parts.push(`excerpt: "${escapeTypstString(m.excerpt)}"`);
  if (m.readingTime != null) parts.push(`reading-time: ${m.readingTime}`);
  if (m.tags && m.tags.length > 0) {
    parts.push(`tags: ("${m.tags.map(escapeTypstString).join('", "')}",)`);
  }
  return "(" + parts.join(", ") + ")";
}