(() => {
  const input = document.getElementById("search");
  const results = document.getElementById("search-results");
  if (!input || !results) return;

  let index = null;

  fetch("/search-index.json")
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

// Conecta o TOC da sidebar aos headings reais do post (`.post-content`), na ordem.
(() => {
  const toc = document.querySelector(".toc-list");
  const content = document.querySelector(".post-content");
  if (!toc || !content) return;
  const links = toc.querySelectorAll("a");
  const heads = content.querySelectorAll("h2, h3, h4, h5, h6");
  heads.forEach((h, i) => {
    if (!h.id) h.id = "toc-item-" + i;
    if (links[i]) links[i].href = "#" + h.id;
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