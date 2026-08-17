import { readTextFile, writeTextFile, type Post } from "./lib.ts";

const DIST_SVG = "dist/posts";

// Pós-processa cada SVG: transforma os `<a href="#sec-N">`/`<a href="#fig-N">`
// gerados pelos `#show` em alvos navegáveis, injetando `id="sec-N"`/`id="fig-N"`
// no próprio elemento `<a>`. Isso permite que o `<object>` e o TOC naveguem até
// a seção/figura correspondente (post.svg#sec-N).
export async function processSvgs(posts: Post[]): Promise<void> {
  for (const p of posts) {
    const path = `${DIST_SVG}/${p.meta.slug}.svg`;
    let svg = await readTextFile(path);
    svg = injectAnchors(svg);
    await writeTextFile(path, svg);
  }
}

function injectAnchors(svg: string): string {
  return svg.replace(
    /<a href="#((?:sec|fig)-\d+)" xlink:href="#\1">/g,
    (_m, id: string) => `<a id="${id}" href="#${id}" xlink:href="#${id}">`
  );
}