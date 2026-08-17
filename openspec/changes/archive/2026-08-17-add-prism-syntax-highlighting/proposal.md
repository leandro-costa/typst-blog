## Why

The Typst blog currently displays code blocks without syntax highlighting. Adding Prism.js provides automatic language-aware code highlighting, improving the reading experience for code examples in Typst posts. This is especially important for a blog about Typst where readers frequently encounter code snippets.

## What Changes

- Add Prism.js CDN to the HTML output (both site and preview)
- Include prism.js and prism CSS via CDN
- Ensure code blocks have `data-lang` attributes for language detection
- Create a custom Prism.js theme CSS compatible with the blog's dark theme (#1a1a1a)
- Add Autoloader plugin for on-demand language loading

### New Capabilities

- `prism-integration`: Integrate Prism.js syntax highlighting for all supported languages in Typst code blocks. Includes CDN resources, theme CSS, and automatic language detection via `data-lang` attributes.

## Impact

- HTML output generation (generate-site.ts): Add Prism.js script and CSS includes
- Template updates: Ensure code blocks use `data-lang` attribute
- New dependency: prismjs CDN resources
- No breaking changes - existing code blocks will continue to work (without highlighting until Prism.js loads)