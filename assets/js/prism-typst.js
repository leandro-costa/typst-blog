/* Prism Typst grammar (custom) - realce de sintaxe para Typst */
Prism.languages.typst = {
  'comment': [
    /\/\/.*$/m,
    /\/\*[\s\S]*?\*\//
  ],
  'string': {
    pattern: /"(?:[^"\\\n]|\\.)*"/,
    greedy: true
  },
  'raw-block': {
    pattern: /```[\s\S]*?```|`[^`\n]*`/,
    greedy: true,
    alias: 'string'
  },
  'content': {
    pattern: /\[[\s\S]*?\]/,
    greedy: true,
    alias: 'string'
  },
  'command': {
    pattern: /#[\w-]+(?=\s*[(\[]|[\s;,#])|#[\w-]+/,
    alias: 'keyword'
  },
  'function': {
    pattern: /#[\w-]+(?=\s*\()/,
    alias: 'function'
  },
  'keyword': /\b(?:import|export|from|let|set|show|if|else|for|while|return|in|and|or|not|true|false|none|auto|context)\b/,
  'label': /@[\w-]+/,
  'reference': /#ref\(\s*"(?:[^"\\]|\\.)*"\s*\)/,
  'boolean': /\b(?:true|false|none|auto)\b/,
  'number': /\b0x[\da-fA-F]+|\b\d+(?:\.\d+)?(?:%|[a-zA-Z]*)\b/,
  'punctuation': /[(){}[\],;:]/,
  'operator': /(?:==|!=|<=|>=|=>|\.\.|\.\.\.|\+|-|\*|\/|%|<|>|=|!|\||&)/,
  'variable': /\b[A-Za-z_][\w-]*\b/
};