import { readTextFile, readDir, type Post, type PostMeta } from "./lib.ts";

const META_REGEX = /#let\s+meta\s*=\s*\(/s;

// Subpasta → tipo
const TYPE_MAP: Record<string, string> = {
  aulas: "aula",
  exercicios: "exercicio",
  solucoes: "solucao",
  trabalhos: "trabalho",
};

// Prioridade do tipo dentro de um grupo
const TYPE_PRIORITY: Record<string, number> = {
  aula: 0,
  exercicio: 1,
  solucao: 2,
  trabalho: 3,
};

function parseValue(text: string, start: number): { value: unknown; end: number } | null {
  let i = start;
  while (i < text.length && /\s/.test(text[i])) i++;
  if (i >= text.length) return null;

  const c = text[i];

  if (c === '"') {
    i++;
    let str = "";
    while (i < text.length && text[i] !== '"') {
      if (text[i] === "\\" && i + 1 < text.length) {
        str += text[i + 1];
        i += 2;
      } else {
        str += text[i];
        i++;
      }
    }
    i++;
    return { value: str, end: i };
  }

  if (c === "'") {
    i++;
    let str = "";
    while (i < text.length && text[i] !== "'") {
      str += text[i];
      i++;
    }
    i++;
    return { value: str, end: i };
  }

  if (c === "(") {
    i++;
    const items: unknown[] = [];
    while (i < text.length) {
      while (i < text.length && /\s/.test(text[i])) i++;
      if (i < text.length && text[i] === ")") {
        i++;
        break;
      }
      const item = parseValue(text, i);
      if (!item) break;
      items.push(item.value);
      i = item.end;
      while (i < text.length && /\s/.test(text[i])) i++;
      if (i < text.length && text[i] === ",") i++;
    }
    return { value: items, end: i };
  }

  let raw = "";
  while (i < text.length && !/[\s,\)\n]/.test(text[i])) {
    raw += text[i];
    i++;
  }

  if (raw === "true") return { value: true, end: i };
  if (raw === "false") return { value: false, end: i };
  if (raw === "none") return { value: null, end: i };
  if (!isNaN(Number(raw)) && raw !== "") return { value: Number(raw), end: i };

  return { value: raw, end: i };
}

function parseMeta(content: string): { meta: Record<string, unknown>; body: string } | null {
  const match = content.match(META_REGEX);
  if (!match) return null;

  const startIdx = match.index!;
  let depth = 1;
  let endIdx = startIdx + match[0].length;

  while (depth > 0 && endIdx < content.length) {
    const char = content[endIdx];
    if (char === "(") depth++;
    else if (char === ")") depth--;
    endIdx++;
  }

  if (depth !== 0) return null;

  const metaBlock = content.slice(startIdx, endIdx);
  const body = content.slice(endIdx).trim();

  const meta: Record<string, unknown> = {};

  let i = metaBlock.indexOf("(") + 1;
  while (i < metaBlock.length - 1) {
    while (i < metaBlock.length && /\s/.test(metaBlock[i])) i++;
    if (i >= metaBlock.length - 1) break;

    let key = "";
    while (i < metaBlock.length && /\w/.test(metaBlock[i])) {
      key += metaBlock[i];
      i++;
    }
    if (!key) {
      i++;
      continue;
    }

    while (i < metaBlock.length && /\s/.test(metaBlock[i])) i++;
    if (i >= metaBlock.length || metaBlock[i] !== ":") {
      i++;
      continue;
    }
    i++;

    const parsed = parseValue(metaBlock, i);
    if (!parsed) {
      i++;
      continue;
    }

    meta[key] = parsed.value;
    i = parsed.end;

    while (i < metaBlock.length && /\s/.test(metaBlock[i])) i++;
    if (i < metaBlock.length && metaBlock[i] === ",") i++;
  }

  if (!meta.title || !meta.date) return null;

  return { meta, body };
}

// Extrai { group, number } do nome do arquivo (ex.: "aula-01-exer-01" → group "aula-01", number 1)
function parseName(base: string): { group: string; number?: number } {
  const tokens = base.split("-");
  if (tokens.length < 2) return { group: base };
  const group = tokens[0] + "-" + tokens[1];
  const last = tokens[tokens.length - 1];
  const number = /^\d+$/.test(last) ? Number(last) : undefined;
  return { group, number };
}

// Strip de markup Typst → palavras → minutos (wpm = 200)
function estimateReadingTime(body: string): number {
  const text = body
    .replace(/```[\s\S]*?```/g, " ")
    .replace(/`[^`]*`/g, " ")
    .replace(/\$[^$]*\$/g, " ")
    .replace(/#[^\s\[\]]*/g, " ")
    .replace(/[*_=<>~\[\]()#]/g, " ")
    .replace(/[\/\\|]/g, " ");
  const words = text
    .split(/\s+/)
    .filter((w) => /[a-zA-Z0-9á-úÁ-ÚçÇã-õÃ-Õ]/.test(w)).length;
  return Math.max(1, Math.round(words / 200));
}

function validateFiguresAndCaptions(body: string, relPath: string): void {
  const bodyLines = body.split("\n");
  let inCodeBlock = false;
  
  for (let idx = 0; idx < bodyLines.length; idx++) {
    const line = bodyLines[idx].trim();
    if (line.startsWith("```")) {
      if (!inCodeBlock) {
        inCodeBlock = true;
        let hasFigure = false;
        for (let j = Math.max(0, idx - 2); j <= idx; j++) {
          if (bodyLines[j].includes("#figure")) {
            hasFigure = true;
            break;
          }
        }
        if (!hasFigure) {
          console.warn(`⚠️  [Validação de Post] ${relPath}:${idx + 1}: Bloco de código detectado sem encapsulamento de #figure ou sem legenda (caption).`);
        }
      } else {
        inCodeBlock = false;
      }
    }
    
    if (line.includes("table(") && !line.includes("#figure")) {
      let hasFigure = false;
      for (let j = Math.max(0, idx - 2); j <= idx; j++) {
        if (bodyLines[j].includes("#figure")) {
          hasFigure = true;
          break;
        }
      }
      if (!hasFigure) {
        console.warn(`⚠️  [Validação de Post] ${relPath}:${idx + 1}: Tabela detectada sem encapsulamento de #figure ou sem legenda (caption).`);
      }
    }
    
    if (line.includes("image(") && !line.includes("#figure")) {
      let hasFigure = false;
      for (let j = Math.max(0, idx - 2); j <= idx; j++) {
        if (bodyLines[j].includes("#figure")) {
          hasFigure = true;
          break;
        }
      }
      if (!hasFigure) {
        console.warn(`⚠️  [Validação de Post] ${relPath}:${idx + 1}: Imagem detectada sem encapsulamento de #figure ou sem legenda (caption).`);
      }
    }
  }
}

export async function loadPosts(postsDir: string): Promise<Post[]> {
  const posts: Post[] = [];

  async function processFile(subdir: string, type: string, filename: string): Promise<void> {
    const relPath = subdir ? `${subdir}/${filename}` : filename;
    const content = await readTextFile(`${postsDir}/${relPath}`);
    const parsed = parseMeta(content);
    if (!parsed) {
      console.warn(`⚠️  Ignorando ${relPath}: metadados inválidos`);
      return;
    }

    validateFiguresAndCaptions(parsed.body, relPath);

    const base = filename.replace(/\.typ$/, "");
    const { group, number } = parseName(base);
    const slug = String(parsed.meta.slug ?? base);

    const postMeta: PostMeta = {
      title: String(parsed.meta.title),
      date: String(parsed.meta.date),
      slug,
      author: parsed.meta.author ? String(parsed.meta.author) : undefined,
      tags: Array.isArray(parsed.meta.tags) ? parsed.meta.tags.map(String) : undefined,
      excerpt: parsed.meta.excerpt ? String(parsed.meta.excerpt) : undefined,
      type,
      group,
      number,
      readingTime: estimateReadingTime(parsed.body),
    };

    posts.push({ meta: postMeta, body: parsed.body, filename: relPath });
  }

  for await (const entry of readDir(postsDir)) {
    if (entry.isDirectory) {
      const type = TYPE_MAP[entry.name];
      if (!type) {
        console.warn(`⚠️  Ignorando subpasta ${entry.name}: tipo desconhecido`);
        continue;
      }
      for await (const f of readDir(`${postsDir}/${entry.name}`)) {
        if (!f.isFile || !f.name.endsWith(".typ")) continue;
        await processFile(entry.name, type, f.name);
      }
    } else if (entry.isFile && entry.name.endsWith(".typ")) {
      await processFile("", "aula", entry.name);
    }
  }

  posts.sort((a, b) => {
    const d = b.meta.date.localeCompare(a.meta.date);
    if (d !== 0) return d;
    if (a.meta.group !== b.meta.group) return a.meta.group.localeCompare(b.meta.group);
    const pa = TYPE_PRIORITY[a.meta.type] ?? 9;
    const pb = TYPE_PRIORITY[b.meta.type] ?? 9;
    if (pa !== pb) return pa - pb;
    return (a.meta.number ?? 0) - (b.meta.number ?? 0);
  });

  return posts;
}