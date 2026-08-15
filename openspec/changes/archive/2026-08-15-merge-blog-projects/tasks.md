# Tasks — Merge Blog Projects

## 1. Estrutura do projeto

- [x] 1.1 Remover os projetos antigos `typst-blog/` e `typst-blog-js/`
- [x] 1.2 Criar a estrutura do novo projeto em `typst-blog-v2/`: `posts/`, `templates/`, `scripts/`, `assets/`, `dist/`
- [x] 1.3 Declarar tarefas `build` e `serve` em `package.json` para Bun
- [x] 1.4 Adicionar arquivos base de assets (`assets/css/style.css`) herdando o CSS do projeto JS
- [x] 1.5 Criar `.vscode/settings.json` com `tinymist.typstExtraArgs: ["--features", "html"]`, `tinymist.exportTarget: "paged"`, `tinymist.formatterMode: "typstfmt"`
- [x] 1.6 Escrever README documentando uso, dependência do Typst v0.15+, e as duas formas de preview (post individual vs bundle)

## 2. Post autossuficiente

- [x] 2.1 Criar `templates/post.typ` com `post-layout(meta, rest)` que estiliza título, data, autor, tags e corpo
- [x] 2.2 Migrar/reescrever posts existentes para o formato `#let meta` + corpo solto + `#show: rest => post-layout(meta, rest)`
- [x] 2.3 Validar que cada post compila sozinho (preview Tinymist renderiza o artigo estilizado)

## 3. Build tooling (TypeScript)

- [x] 3.1 Criar `scripts/lib.ts` com utilitários Bun (ler/escrever, fs, runCommand, getEnv) e `parseToml`/`loadConfig` para ler `typst.toml`
- [x] 3.2 Criar parser de posts que extrai `meta` (title/date/slug/author/tags/excerpt) e o corpo, ignorando posts inválidos com aviso
- [x] 3.3 Criar gerador de `site.typ` que importa cada post como módulo, monta home + páginas via `#document(...)`, e inclui o guard `#let is-preview = "x-preview" in sys.inputs` renderizando uma página tipografada com tudo (sem `html.elem` e sem `#document`)
- [x] 3.4 Criar gerador de `book.typ` que reutiliza a mesma fonte dos posts
- [x] 3.5 Criar `scripts/build.ts` orquestrando: ler posts → gerar `site.typ` → compilar bundle → `dist/` → gerar/compilar `book.typ` → `dist/book.pdf` (A4) → copiar assets
- [x] 3.6 Criar `scripts/serve.ts` servindo `dist/` para preview local
- [x] 3.7 Ordenar posts por `meta.date` (fonte de verdade) e derivar slug/identificador do prefixo `AAAA-MM-DD` do nome do arquivo
- [x] 3.8 Criar `typst.toml` com config de site/livro (título, subtítulo, autor) e usá-la no build (com fallback para env vars)

## 4. Site generation (Typst)

- [x] 4.1 Criar `templates/site.typ` com layout de página (nav, hero, footer) e helpers de post-cards (excerpt/tags) e link do PDF
- [x] 4.2 Gerar a home com hero e lista de cards a partir de `x.meta` dos posts importados
- [x] 4.3 Gerar uma página por post com nav/footer e o post renderizado (`#x`)
- [x] 4.4 Garantir que o CSS referencie os assets corretamente e seja copiado para `dist/`

## 5. Book generation (Typst)

- [x] 5.1 Criar `templates/book.typ` com capa, sumário e paginação em papel A4
- [x] 5.2 Gerar `book.typ` compilável que inclui cada post como capítulo a partir da mesma fonte
- [x] 5.3 Validar `dist/book.pdf` em A4 com capa, sumário e conteúdo

## 6. Validação

- [x] 6.1 Rodar `bun run build` com posts válidos e conferir `dist/`
- [x] 6.2 Rodar `bun run serve` e abrir o site localmente
- [x] 6.3 Abrir um post no VS Code e confirmar preview do artigo estilizado via Tinymist (post individual)
- [x] 6.4 Abrir `site.typ` no VS Code e confirmar que o guard `x-preview` renderiza, em modo paged, uma página tipografada com tudo (título + lista + todos os posts), sem `html.elem` e sem `#document`