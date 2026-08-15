// Utilitários para Bun (usa APIs nativas do Bun + built-ins do Node)

export function exit(code = 0): never {
  process.exit(code);
}

export async function readTextFile(path: string): Promise<string> {
  return Bun.file(path).text();
}

export async function writeTextFile(path: string, data: string): Promise<void> {
  const fs = await import("node:fs/promises");
  const parent = path.split(/[\\/]/).slice(0, -1).join("/");
  if (parent !== "") await fs.mkdir(parent, { recursive: true });
  await fs.writeFile(path, data, "utf-8");
}

export async function readFileBytes(path: string): Promise<Uint8Array> {
  return new Uint8Array(await Bun.file(path).arrayBuffer());
}

export async function writeFileBytes(path: string, data: Uint8Array): Promise<void> {
  const fs = await import("node:fs/promises");
  const parent = path.split(/[\\/]/).slice(0, -1).join("/");
  if (parent !== "") await fs.mkdir(parent, { recursive: true });
  await fs.writeFile(path, data);
}

export async function ensureDir(path: string): Promise<void> {
  const fs = await import("node:fs/promises");
  await fs.mkdir(path, { recursive: true });
}

export async function removeDir(path: string): Promise<void> {
  const fs = await import("node:fs/promises");
  await fs.rm(path, { recursive: true, force: true });
}

export async function* readDir(path: string): AsyncGenerator<{ name: string; isDirectory: boolean; isFile: boolean }> {
  const fs = await import("node:fs/promises");
  const entries = await fs.readdir(path, { withFileTypes: true });
  for (const entry of entries) {
    yield { name: entry.name, isDirectory: entry.isDirectory(), isFile: entry.isFile() };
  }
}

export async function exists(path: string): Promise<boolean> {
  const fs = await import("node:fs/promises");
  try {
    await fs.access(path);
    return true;
  } catch {
    return false;
  }
}

export interface BlogConfig {
  site: { title: string; subtitle: string; author: string; url: string };
  book: { title: string; subtitle: string; author: string };
}

// Deriva o base path (caminho) de uma URL de site. Raiz/domínio → "".
// Ex.: "https://host/typst-blog" → "/typst-blog"; "https://host" → "".
export function deriveBasePath(url: string): string {
  try {
    const p = new URL(url).pathname;
    return p.replace(/\/+$/, "");
  } catch {
    return "";
  }
}

// Junta um base path a um caminho de raiz, evitando "/" duplo.
// Ex.: joinBasePath("", "/index.html") → "/index.html";
//      joinBasePath("/typst-blog", "/index.html") → "/typst-blog/index.html".
export function joinBasePath(base: string, path: string): string {
  return (base + "/" + path).replace(/\/{2,}/g, "/");
}

// Parser TOML mínimo (seções `[x]`, `key = "string"`, `key = [ "a", "b" ]`,
// comentários `#`). Suficiente para um typst.toml de config do blog.
export type TomlValue = string | string[] | TomlObject;
export interface TomlObject {
  [key: string]: TomlValue | undefined;
}

// Carrega a config do blog exclusivamente de um arquivo TOML (padrão Typst),
// com valores padrão quando a chave não existir. Sem variáveis de ambiente.
export async function loadConfig(path: string): Promise<BlogConfig> {
  const toml: TomlObject = (await exists(path))
    ? parseToml(await readTextFile(path))
    : {};
  const site = (toml.site ?? {}) as TomlObject;
  const book = (toml.book ?? {}) as TomlObject;

  const pick = (section: TomlObject, key: string, fallback: string): string => {
    const v = section[key];
    return typeof v === "string" ? v : fallback;
  };

  // Fonte única de autor: o book.author também define o site.author (mesmo autor).
  const siteAuthor = pick(book, "author", "Autor");

  return {
    site: {
      title: pick(site, "title", "Typst Blog"),
      subtitle: pick(site, "subtitle", "Blog + livro, tudo em Typst"),
      author: siteAuthor,
      url: pick(site, "url", "https://example.org"),
    },
    book: {
      title: pick(book, "title", "Posts em Livro"),
      subtitle: pick(book, "subtitle", "Coletânea de posts"),
      author: siteAuthor,
    },
  };
}

export function parseToml(text: string): TomlObject {
  const root: TomlObject = {};
  let section: TomlObject | null = null;
  for (const rawLine of text.split(/\r?\n/)) {
    const line = rawLine.replace(/^\s+|\s+$/g, "").replace(/\s*#.*$/, "").trim();
    if (line === "") continue;
    if (line.startsWith("[")) {
      const name = line.replace(/^\[|\]$/g, "").trim();
      section = root[name] as TomlObject | undefined ?? {};
      root[name] = section;
      continue;
    }
    const eq = line.indexOf("=");
    if (eq === -1) continue;
    const key = line.slice(0, eq).trim();
    const raw = line.slice(eq + 1).trim();
    let value: TomlValue;
    if (raw.startsWith("[")) {
      value = [...raw.slice(1, raw.lastIndexOf("]")).matchAll(/"([^"]*)"/g)].map((m) => m[1]);
    } else {
      value = raw.match(/^"((?:[^"\\]|\\.)*)"$/)?.[1] ?? raw;
    }
    (section ?? root)[key] = value;
  }
  return root;
}

export async function runCommand(
  cmd: string,
  args: string[],
  options?: { cwd?: string; env?: Record<string, string> }
): Promise<{ stdout: string; stderr: string; success: boolean; code: number }> {
  const { spawn } = await import("node:child_process");
  return new Promise((resolve, reject) => {
    const proc = spawn(cmd, args, {
      cwd: options?.cwd,
      env: { ...process.env, ...options?.env },
      stdio: ["pipe", "pipe", "pipe"],
    });
    let stdout = "";
    let stderr = "";
    proc.stdout?.on("data", (d) => (stdout += d));
    proc.stderr?.on("data", (d) => (stderr += d));
    proc.on("close", (code) =>
      resolve({ stdout, stderr, success: code === 0, code: code ?? 0 })
    );
    proc.on("error", reject);
  });
}

export interface PostMeta {
  title: string;
  date: string;
  slug: string;
  author?: string;
  tags?: string[];
  excerpt?: string;
  type: string; // aula | exercicio | solucao | trabalho (derivado da subpasta)
  group: string; // ex.: "aula-01" (prefixo do nome)
  number?: number;
  readingTime?: number; // minutos estimados
}

export interface Post {
  meta: PostMeta;
  body: string; // conteúdo typst sem os metadados
  filename: string;
}