// Fluxo export→execute do Callisto para docs em modo exportação
// (callisto.config com `kernel:` + `nb: path("...")`).
// Usado por scripts/build.ts (etapa 0b) — cobre `bun run build` e `bun run dev`,
// que rebuilda via build(). Incremental: só exporta/executa se o .typ mudou.

import { runCommand, readTextFile, writeTextFile, listTypFiles } from "./lib.ts";

export interface ExportDoc {
  typPath: string;
  dir: string;
  notebooks: string[];
}

/** Encontra docs .typ em modo exportação e os notebooks que cada um gera. */
export async function findExportDocs(): Promise<ExportDoc[]> {
  const typs = await listTypFiles(["posts"]);
  const out: ExportDoc[] = [];
  for (const f of typs) {
    const text = await readTextFile(f);
    if (!text.includes("callisto.config(") || !/kernel\s*:/.test(text)) continue;
    // Sem #stage-notebook() não há o que exportar (doc ainda não pronto).
    if (!text.includes("stage-notebook()")) {
      console.log(`   · sem stage-notebook (ignorado): ${f}`);
      continue;
    }
    const dir = f.split("/").slice(0, -1).join("/") || ".";
    const nbs = [
      ...new Set(
        [...text.matchAll(/nb:\s*path\("([^"]+\.ipynb)"\)/g)].map((m) =>
          `${dir}/${m[1]}`.replace(/^\.\//, "")
        )
      ),
    ];
    if (nbs.length > 0) out.push({ typPath: f, dir, notebooks: nbs });
  }
  return out;
}

/** Exporta (typst eval, UTF-8) + executa (nbconvert) os notebooks desatualizados. */
export async function syncExportNotebooks(): Promise<void> {
  const docs = await findExportDocs();
  if (docs.length === 0) {
    console.log("   · callisto export: nenhum doc em modo exportação");
    return;
  }
  const fs = await import("node:fs/promises");
  for (const doc of docs) {
    const typMtime = (await fs.stat(doc.typPath)).mtimeMs;
    for (const nb of doc.notebooks) {
      let nbMtime = 0;
      try {
        nbMtime = (await fs.stat(nb)).mtimeMs;
      } catch {
        /* ainda não gerado */
      }
      if (nbMtime > typMtime) {
        console.log(`   · notebook atualizado: ${nb}`);
        continue;
      }
      console.log(`   ↻ exportando: ${doc.typPath} → ${nb}`);
      const ev = await runCommand(
        "typst",
        [
          "eval",
          "--input",
          "callisto-export=true",
          "--in",
          doc.typPath,
          "query(<notebook>).first().value",
        ]
      );
      if (!ev.success) {
        throw new Error(
          `Falha ao exportar notebook de ${doc.typPath} (typst eval):\n${ev.stderr}`
        );
      }
      // writeTextFile grava UTF-8 sem BOM (redirect `>` do PowerShell gravaria UTF-16!).
      await writeTextFile(nb, ev.stdout.trimEnd() + "\n");

      console.log(`   ↻ executando: ${nb}`);
      const ex = await runCommand(
        "jupyter",
        [
          "nbconvert",
          "--to",
          "notebook",
          "--execute",
          nb.split("/").pop() ?? nb,
          "--inplace",
          "--ExecutePreprocessor.timeout=300",
        ],
        { cwd: doc.dir }
      );
      if (!ex.success) {
        throw new Error(
          `Falha ao executar ${nb} (nbconvert):\n${ex.stderr}\n` +
            `  → Verifique o kernel e as dependências do notebook.`
        );
      }
      console.log(`   ✓ notebook executado: ${nb}`);
    }
  }
}

if (import.meta.main) {
  syncExportNotebooks().catch((err) => {
    console.error("❌ Erro fatal:", err instanceof Error ? err.message : err);
    process.exit(1);
  });
}
