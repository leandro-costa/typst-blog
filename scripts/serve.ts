// Servidor de preview local para dist/
// Uso:
//   bun run serve            → serve só, sem rebuild
//   bun run dev / --watch    → monitora posts/templates/assets/scripts e roda o build a cada mudança

import { readFileBytes, exists } from "./lib.ts";
import { build } from "./build.ts";
import { watch } from "node:fs";
import type { Server, ServerWebSocket } from "bun";

const PORT = Number(process.env.PORT ?? "8080");
const ROOT = "dist";

// Live-reload (só no modo dev/--watch): servidor notifica o navegador após cada rebuild.
const IS_WATCH = process.argv.includes("--watch");
const liveClients = new Set<ServerWebSocket>();

// Script injetado nas páginas servidas para recarregar ao receber o sinal.
const LIVE_RELOAD_SCRIPT = `<script>
(function () {
  var proto = location.protocol === "https:" ? "wss://" : "ws://";
  var ws = new WebSocket(proto + location.host + "/__live_reload");
  ws.onmessage = function () { location.reload(); };
  ws.onclose = function () { setTimeout(function () { location.reload(); }, 400); };
})();
</script>`;

function broadcastReload(): void {
  const msg = JSON.stringify({ type: "reload" });
  for (const client of liveClients) client.send(msg);
}

// Diretórios/arquivos monitorados no modo watch.
const WATCH_TARGETS = ["posts", "templates", "assets", "scripts", "typst.toml", "refs.bib"];

const MIME_TYPES: Record<string, string> = {
  ".html": "text/html; charset=utf-8",
  ".css": "text/css",
  ".js": "application/javascript",
  ".json": "application/json",
  ".png": "image/png",
  ".jpg": "image/jpeg",
  ".jpeg": "image/jpeg",
  ".gif": "image/gif",
  ".svg": "image/svg+xml",
  ".pdf": "application/pdf",
  ".woff2": "font/woff2",
  ".woff": "font/woff",
  ".ttf": "font/ttf",
  ".otf": "font/otf",
};

function getMime(path: string): string {
  const ext = path.slice(path.lastIndexOf("."));
  return MIME_TYPES[ext] ?? "application/octet-stream";
}

async function serveFile(path: string): Promise<Response> {
  let decoded: string;
  try {
    decoded = decodeURIComponent(path);
  } catch {
    decoded = path;
  }
  const filePath = decoded === "/" ? `${ROOT}/index.html` : `${ROOT}${decoded}`;

  if (!(await exists(filePath))) {
    if (!(await exists(filePath + ".html"))) {
      return new Response("Not Found", { status: 404 });
    }
    return serveFile(decoded + ".html");
  }

  const data = await readFileBytes(filePath);
  if (IS_WATCH && filePath.endsWith(".html")) {
    const html = new TextDecoder().decode(data).replace("</body>", LIVE_RELOAD_SCRIPT + "</body>");
    return new Response(new TextEncoder().encode(html), {
      headers: { "Content-Type": getMime(filePath) },
    });
  }
  return new Response(data, {
    headers: { "Content-Type": getMime(filePath) },
  });
}

async function main(): Promise<void> {
  if (!(await exists(ROOT))) {
    console.error(`❌ Diretório ${ROOT}/ não encontrado. Execute o build primeiro.`);
    console.error("   bun run build");
    process.exit(1);
  }

  const { serve } = await import("bun");
  const server: Server = serve({
    port: PORT,
    fetch(req, srv) {
      const url = new URL(req.url);
      if (IS_WATCH && url.pathname === "/__live_reload") {
        if (srv.upgrade(req)) return undefined;
        return new Response("Upgrade failed", { status: 500 });
      }
      return serveFile(url.pathname);
    },
    websocket: {
      open(ws) {
        liveClients.add(ws);
      },
      close(ws) {
        liveClients.delete(ws);
      },
      message() {},
    },
  });
  console.log(`🌐 Servidor rodando em http://localhost:${PORT}`);

  if (IS_WATCH) {
    startWatch(server);
  }

  await new Promise(() => {});
}

// Rebuild com debounce: agrupa várias mudanças em um único build.
function startWatch(_server: Server): void {
  console.log(`👀 Modo watch ativo — monitorando: ${WATCH_TARGETS.join(", ")}`);
  let timer: ReturnType<typeof setTimeout> | undefined;
  const rebuild = () => {
    if (timer) clearTimeout(timer);
    timer = setTimeout(async () => {
      console.log("\n🔄 Mudança detectada, rebuildando...");
      try {
        await build();
        broadcastReload();
        console.log("   ✓ Rebuild concluído, recarregando o navegador\n");
      } catch (err) {
        console.error("   ✗ Rebuild falhou (mantendo servidor ativo):");
        console.error(err instanceof Error ? err.message : err);
      }
    }, 300);
  };

  for (const target of WATCH_TARGETS) {
    watch(target, { recursive: true }, (_evt, filename) => {
      console.log(`   ↻ ${target}/${filename ?? ""}`);
      rebuild();
    });
  }
}

main().catch((err) => {
  console.error("❌ Erro:", err);
  process.exit(1);
});