(() => {
  const input = document.getElementById("search");
  const results = document.getElementById("search-results");
  if (!input || !results) return;

  // Base path derivado do próprio caminho deste script (sempre <base>/assets/js/search.js).
  // Site na raiz → base "". Ex.: "/typst-blog/assets/js/search.js" → "/typst-blog".
  const scriptPath = document.currentScript?.src ? new URL(document.currentScript.src).pathname : "";
  const base = scriptPath.replace(/\/assets\/js\/search\.js$/, "");

  let index = null;

  fetch(base + "/search-index.json")
    .then((r) => r.json())
    .then((data) => {
      index = data;
    })
    .catch(() => {
      index = [];
    });

  const render = (items) => {
    results.innerHTML = "";
    if (items.length === 0) {
      results.textContent = "Nenhum resultado.";
      return;
    }
    for (const item of items) {
      const a = document.createElement("a");
      a.href = item.url;
      a.className = "search-result";
      const title = document.createElement("span");
      title.className = "search-result-title";
      title.textContent = item.title;
      const meta = document.createElement("span");
      meta.className = "search-result-meta";
      meta.textContent = item.date + (item.tags.length ? " · " + item.tags.join(", ") : "");
      a.appendChild(title);
      a.appendChild(meta);
      results.appendChild(a);
    }
  };

  input.addEventListener("input", () => {
    const q = input.value.trim().toLowerCase();
    if (!q || !index) {
      results.innerHTML = "";
      return;
    }
    const terms = q.split(/\s+/);
    const hits = index
      .filter((item) => {
        const hay = [item.title, item.excerpt, item.tags.join(" ")].join(" ").toLowerCase();
        return terms.every((t) => hay.includes(t));
      })
      .slice(0, 8);
    render(hits);
  });
})();

// Conecta o TOC da sidebar às âncoras do SVG do post (corpo via <object>).
// Como o conteúdo é um SVG embutido num <object>, o clique no TOC deve rolar
// o documento interno do object até o elemento com o id `sec-N`/`fig-N`.
(() => {
  const toc = document.querySelector(".toc-list");
  const object = document.querySelector(".post-svg");
  if (!toc) return;
  const links = toc.querySelectorAll("a");

  links.forEach((link) => {
    // Item do título do post: rola até o topo do header (HTML), não dentro do SVG.
    if (link.hasAttribute("data-scroll-top")) {
      link.addEventListener("click", (e) => {
        e.preventDefault();
        const header = document.querySelector(".post-header") || document.querySelector(".post");
        if (header) {
          const rect = header.getBoundingClientRect();
          window.scrollTo({ top: window.scrollY + rect.top - 72, behavior: "auto" });
        }
      });
      return;
    }
    const anchor = link.getAttribute("data-svg-anchor");
    if (!anchor) return;
    link.addEventListener("click", (e) => {
      e.preventDefault();
      const obj = object || document.querySelector(".post-svg");
      if (!obj || !obj.contentDocument) {
        // Fallback: navega direto para a âncora (abre o SVG puro).
        const base = link.getAttribute("href")?.split("#")[0] ?? "";
        window.location.hash = base + anchor;
        return;
      }
      const target = obj.contentDocument.querySelector(anchor);
      if (target) {
        const objRect = obj.getBoundingClientRect();
        const targetRect = target.getBoundingClientRect();
        const y = window.scrollY + objRect.top + targetRect.top;
        window.scrollTo({ top: y - 72, behavior: "auto" });
      }
    });
  });
})();

// Lógica de exibição da sidebar (colapso) e modo leitura (fullscreen do conteúdo).
(() => {
  const layout = document.querySelector(".layout.toc-left");
  if (!layout) return;

  const COLLAPSED = "is-collapsed";
  const sbBtn = document.getElementById("toggle-sidebar");
  const fsBtn = document.getElementById("toggle-fullscreen");
  const header = layout.querySelector(".toc-header");

  // Responsivo: em telas pequenas a sidebar colapsa automaticamente (barra no topo).
  const mq = window.matchMedia("(max-width: 860px)");
  if (mq.matches) layout.classList.add(COLLAPSED);

  const setCollapsed = (v) => layout.classList.toggle(COLLAPSED, v);
  const isCollapsed = () => layout.classList.contains(COLLAPSED);

  const syncSb = () => {
    const collapsed = isCollapsed();
    if (sbBtn) {
      sbBtn.classList.toggle("active", collapsed);
      sbBtn.title = collapsed ? "Mostrar sumário" : "Ocultar sumário";
    }
  };

  const onToggle = () => {
    setCollapsed(!isCollapsed());
    syncSb();
  };

  // O botão ☰ e o cabeçalho "Neste post" alternam o colapso (uma única ação).
  if (sbBtn) sbBtn.addEventListener("click", (e) => { e.stopPropagation(); onToggle(); });
  if (header) header.addEventListener("click", onToggle);
  syncSb();

  if (fsBtn) {
    fsBtn.addEventListener("click", () => {
      const fs = document.body.classList.toggle("is-fullscreen");
      fsBtn.classList.toggle("active", fs);
      fsBtn.title = fs ? "Sair do modo leitura" : "Modo leitura";
    });
  }
})();
