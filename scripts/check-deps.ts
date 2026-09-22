// Verificação do toolchain antes do build: typst, bun, java, graphviz,
// callisto (versão pinada) e notebooks .ipynb referenciados.
// Falha com mensagem clara indicando o que instalar + exit(1) no build.

import { runCommand, exists, readTextFile } from "./lib.ts";

const MIN_TYPST = "0.15.1";
const MIN_BUN = "1.0.0";

function cmpVersion(a: string, b: string): number {
  const pa = a.split(".").map(Number);
  const pb = b.split(".").map(Number);
  for (let i = 0; i < Math.max(pa.length, pb.length); i++) {
    const d = (pa[i] ?? 0) - (pb[i] ?? 0);
    if (d !== 0) return d;
  }
  return 0;
}

/** Roda `cmd args` e retorna stdout+stderr; null se o binário não existe. */
async function tryRun(cmd: string, args: string[]): Promise<string | null> {
  try {
    const r = await runCommand(cmd, args);
    return `${r.stdout}\n${r.stderr}`;
  } catch {
    return null;
  }
}

/** Coleta todos os arquivos .typ relevantes (posts + raiz + templates). */
async function listTypFiles(dirs: string[]): Promise<string[]> {
  const { readdir } = await import("node:fs/promises");
  const out: string[] = [];
  async function walk(dir: string): Promise<void> {
    let entries;
    try {
      entries = await readdir(dir, { withFileTypes: true });
    } catch {
      return;
    }
    for (const e of entries) {
      const p = `${dir}/${e.name}`;
      if (e.isDirectory()) await walk(p);
      else if (e.isFile() && e.name.endsWith(".typ")) out.push(p);
    }
  }
  for (const d of dirs) {
    if (await exists(d)) {
      // arquivos soltos na raiz (documento.typ) + diretórios
      try {
        const st = await (await import("node:fs/promises")).stat(d);
        if (st.isFile() && d.endsWith(".typ")) out.push(d);
        else await walk(d);
      } catch {
        /* ignora */
      }
    }
  }
  return out;
}

interface NotebookUse {
  path: string; // caminho do .ipynb resolvido
  hasPlantUml: boolean;
  needsGraphviz: boolean;
}

// Tipos de diagrama PlantUML que exigem o executável do Graphviz.
// Sequência (padrão) funciona 100% offline só com a biblioteca.
const GRAPHVIZ_KEYWORDS = [
  "class ",
  "component",
  "@startuml\nclass",
  "activity",
  "state ",
  "object ",
  "deployment",
  "usecase",
  "mindmap",
  "wbs",
  "gantt",
];

function cellNeedsGraphviz(source: string): boolean {
  const lower = source.toLowerCase();
  return GRAPHVIZ_KEYWORDS.some((k) => lower.includes(k));
}

async function inspectNotebook(ipynbPath: string): Promise<NotebookUse> {
  const raw = await readTextFile(ipynbPath);
  let nb: any;
  try {
    nb = JSON.parse(raw);
  } catch {
    throw new Error(
      `Notebook inválido (JSON malformado): ${ipynbPath}.\n` +
        `  → Verifique o arquivo e salve novamente pelo Jupyter.`
    );
  }
  if (typeof nb.nbformat !== "number" || !Array.isArray(nb.cells)) {
    throw new Error(
      `Notebook fora do formato nbformat: ${ipynbPath}.\n` +
        `  → Salve novamente pelo Jupyter (nbformat 4).`
    );
  }
  let hasPlantUml = false;
  let needsGraphviz = false;
  for (const cell of nb.cells) {
    const source = Array.isArray(cell.source)
      ? cell.source.join("")
      : String(cell.source ?? "");
    if (!source.trimStart().startsWith("%%plantuml")) continue;
    hasPlantUml = true;
    if (cellNeedsGraphviz(source)) needsGraphviz = true;
    // O diagrama deve estar gerado localmente: output image/png salvo no .ipynb.
    const outputs = cell.outputs ?? [];
    const hasPng = outputs.some((o: any) => o.data?.["image/png"] != null);
    if (!hasPng) {
      throw new Error(
        `Célula %%plantuml sem output image/png salvo em ${ipynbPath}.\n` +
          `  → Execute o notebook no Jupyter (kernel IJava) e salve antes do build.\n` +
          `  → Diagramas PlantUML devem ser gerados localmente (offline).`
      );
    }
  }
  return { path: ipynbPath, hasPlantUml, needsGraphviz };
}

/** Encontra `nb: path("...")` em chamadas callisto e resolve relativo ao .typ. */
async function findNotebookUses(typFiles: string[]): Promise<string[]> {
  const found = new Set<string>();
  const re = /nb:\s*path\("([^"]+\.ipynb)"\)/g;
  for (const f of typFiles) {
    const text = await readTextFile(f);
    const dir = f.split("/").slice(0, -1).join("/") || ".";
    for (const m of text.matchAll(re)) {
      found.add(`${dir}/${m[1]}`.replace(/^\.\//, ""));
    }
  }
  return [...found];
}

export async function checkDeps(): Promise<void> {
  console.log("🔧 Verificando ferramentas...");
  const errors: string[] = [];

  // 1. typst
  const typstOut = await tryRun("typst", ["--version"]);
  const typstVer = typstOut?.match(/(\d+\.\d+\.\d+)/)?.[1];
  if (!typstVer) {
    errors.push(
      "typst não encontrado no PATH.\n  → Instale Typst 0.15.1+: https://github.com/typst/typst/releases"
    );
  } else if (cmpVersion(typstVer, MIN_TYPST) < 0) {
    errors.push(
      `typst ${typstVer} é antigo (mínimo ${MIN_TYPST}).\n  → Atualize: https://github.com/typst/typst/releases`
    );
  } else {
    console.log(`   ✓ typst ${typstVer}`);
  }

  // 2. bun
  const bunOut = await tryRun("bun", ["--version"]);
  const bunVer = bunOut?.match(/(\d+\.\d+\.\d+)/)?.[1];
  if (!bunVer) {
    errors.push(
      "bun não encontrado no PATH.\n  → Instale Bun 1.0+: https://bun.sh"
    );
  } else if (cmpVersion(bunVer, MIN_BUN) < 0) {
    errors.push(
      `bun ${bunVer} é antigo (mínimo ${MIN_BUN}).\n  → Atualize com: bun upgrade`
    );
  } else {
    console.log(`   ✓ bun ${bunVer}`);
  }

  // 3. callisto: versão pinada única em todos os .typ
  const typFiles = await listTypFiles(["posts", "templates", "documento.typ"]);
  const versions = new Set<string>();
  for (const f of typFiles) {
    const text = await readTextFile(f);
    for (const m of text.matchAll(/@preview\/callisto:(\d+\.\d+\.\d+)/g)) {
      versions.add(m[1]);
    }
  }
  if (versions.size === 0) {
    console.log("   · callisto: nenhum import encontrado (ok, sem notebooks)");
  } else if (versions.size > 1) {
    errors.push(
      `callisto com versões divergentes pinadas: ${[...versions].join(", ")}.\n` +
        `  → Unifique todos os #import "@preview/callisto:x.y.z" para a mesma versão.`
    );
  } else {
    console.log(`   ✓ callisto ${[...versions][0]} (pinada, consistente)`);
  }

  // 4. ipynb referenciados pelo callisto
  const nbPaths = await findNotebookUses(typFiles);
  let needsJava = false;
  let needsDot = false;
  for (const nbPath of nbPaths) {
    if (!(await exists(nbPath))) {
      errors.push(
        `Notebook referenciado não existe: ${nbPath}.\n` +
          `  → Verifique o nb: path("...") no .typ correspondente.`
      );
      continue;
    }
    try {
      const use = await inspectNotebook(nbPath);
      console.log(`   ✓ notebook ${nbPath} (JSON válido)`);
      if (use.hasPlantUml) {
        needsJava = true;
        if (use.needsGraphviz) needsDot = true;
        console.log(`     · contém %%plantuml (outputs image/png salvos)`);
      }
    } catch (e) {
      errors.push(e instanceof Error ? e.message : String(e));
    }
  }

  // 5. java (só se há %%plantuml)
  if (needsJava) {
    const javaOut = await tryRun("java", ["-version"]);
    if (!javaOut) {
      errors.push(
        "java não encontrado no PATH (necessário p/ kernel IJava + PlantUML).\n  → Instale um JDK 17+ (ex.: Eclipse Temurin: https://adoptium.net)"
      );
    } else {
      console.log("   ✓ java (kernel IJava)");
    }
  } else {
    console.log("   · java: não exigido (sem %%plantuml nos notebooks)");
  }

  // 6. graphviz (só se há diagrama que o exige)
  if (needsDot) {
    const dotOut = await tryRun("dot", ["-V"]);
    if (!dotOut) {
      errors.push(
        "graphviz (dot) não encontrado no PATH.\n  → Instale: https://graphviz.org/download/ (apt: sudo apt install graphviz)"
      );
    } else {
      console.log("   ✓ graphviz (dot)");
    }
  } else {
    console.log("   · graphviz: não exigido (só sequência ou sem plantuml)");
  }

  if (errors.length > 0) {
    throw new Error(
      "Dependências ausentes/inválidas:\n\n" + errors.map((e) => `❌ ${e}`).join("\n\n")
    );
  }
  console.log("   ✓ Todas as dependências ok\n");
}

if (import.meta.main) {
  checkDeps().catch((err) => {
    console.error("❌ Erro fatal:", err instanceof Error ? err.message : err);
    process.exit(1);
  });
}
