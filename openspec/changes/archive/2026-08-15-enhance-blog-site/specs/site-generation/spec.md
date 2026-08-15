## ADDED Requirements

### Requirement: Navegação prev/next, sidebar à esquerda e TOC colapsável

O site SHALL fornecer navegação "anterior/próximo" entre postagens, seguindo a ordem de
grupo. A página de post SHALL usar a sidebar à esquerda com a estrutura de tópicos (TOC)
do próprio post no topo, seguida de tags, recentes, busca e link do livro. O TOC SHALL ser
gerado no build (a partir do corpo, ignorando blocos de código) e ancorado aos headings
reais do post. A sidebar SHALL ser colapsável: quando colapsada, vira uma barra no topo
exibindo "Neste post" e um botão, com o TOC oculto; clicar na barra ou no botão re-expande.
Em resoluções pequenas a sidebar SHALL colapsar automaticamente. O layout SHALL ser fluido,
ocupando 100% da largura da página. O post SHALL oferecer um modo leitura (botão no título)
que esconde navbar, sidebar e rodapé, exibindo apenas o conteúdo em largura total.

#### Scenario: Prev/next segue a ordem de grupo
- **WHEN** o usuário navega a página de um post do grupo `aula-01`
- **THEN** há links para o post anterior e o próximo na ordem de grupo

#### Scenario: Sidebar à esquerda com TOC do post
- **WHEN** o site é compilado para HTML
- **THEN** a página do post inclui a sidebar à esquerda com o TOC do post (gerado no build),
  tags, recentes e link do livro

#### Scenario: TOC ancorado aos headings do post
- **WHEN** o build gera o TOC de um post com headings
- **THEN** cada item do TOC aponta para o heading correspondente no corpo do post

#### Scenario: Colapso manual da sidebar
- **WHEN** o usuário clica no botão da sidebar (ou na barra "Neste post")
- **THEN** a sidebar colapsa para uma barra no topo com o TOC oculto, e um novo clique a re-expande

#### Scenario: Colapso responsivo
- **WHEN** a resolução é pequena (ex.: ≤ 860px)
- **THEN** a sidebar colapsa automaticamente para a barra no topo, sem exibir o TOC

#### Scenario: Modo leitura esconde a interface
- **WHEN** o usuário ativa o modo leitura
- **THEN** navbar, sidebar e rodapé ficam ocultos e apenas o conteúdo do post é exibido,
  independentemente da resolução

#### Scenario: Layout fluido
- **WHEN** o site é renderizado
- **THEN** o conteúdo ocupa 100% da largura da página, sem largura máxima fixa

#### Scenario: Marca do navbar usa o título da config
- **WHEN** o site é compilado a partir do `typst.toml`
- **THEN** a marca do navbar exibe o título do site vindo da config, em todas as páginas

### Requirement: Categorias (aula/exercicio/solucao/trabalho) no navbar

O site SHALL tratar os tipos `aula`, `exercicio`, `solucao` e `trabalho` como categorias
(tags especiais). O navbar SHALL exibir um link para cada categoria presente nos posts; cada
link aponta para uma página estática em `/categorias/<tipo>.html` que lista os cards dos
posts daquele tipo.

#### Scenario: Link de categoria no navbar
- **WHEN** existem posts do tipo `aula`
- **THEN** o navbar exibe um link "Aulas" apontando para `/categorias/aula.html`

#### Scenario: Página de categoria lista os posts do tipo
- **WHEN** o usuário abre `/categorias/exercicio.html`
- **THEN** a página lista os cards dos posts de tipo `exercicio`

### Requirement: Listagens ordenadas por data

Todas as listagens de posts do site (home, por tag e por categoria) SHALL ser ordenadas por
data de publicação, com o post mais recente primeiro.

#### Scenario: Home ordenada por data decrescente
- **WHEN** a home lista os posts
- **THEN** o post mais recente aparece primeiro

#### Scenario: Listagem filtrada ordenada por data
- **WHEN** uma página de tag ou categoria lista posts
- **THEN** os cards são ordenados por data, mais recente primeiro

### Requirement: Tags como páginas estáticas

O site SHALL gerar uma página estática por tag em `/tags/<tag>.html`, listando os posts
daquela tag, além de uma nuvem de tags na sidebar que aponta para essas páginas.

#### Scenario: Página de tag lista os posts
- **WHEN** existe a tag `poo`
- **THEN** `/tags/poo.html` lista os cards dos posts marcados com `poo`

### Requirement: Página de Referências

O site SHALL renderizar as referências de `refs.bib` (tentativa de `#bibliography`
nativo no export HTML, com fallback de página estática gerada pelo build).

#### Scenario: Referências disponíveis no site
- **WHEN** `refs.bib` define referências e o site é compilado
- **THEN** uma página de Referências lista as entradas (nativamente ou via fallback)

### Requirement: Feed RSS

O site SHALL expor um feed RSS/Atom (`/rss.xml`) gerado pelo build a partir dos
metadados, ordenado por `meta.date` decrescente.

#### Scenario: Feed gerado no build
- **WHEN** o build termina com posts válidos
- **THEN** `dist/rss.xml` contém as entradas ordenadas por data