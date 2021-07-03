local commands = {
  jsondetect = {
    { "BufNewFile,BufRead", "*.cjsn", "setfiletype jsonc" },
    { "BufNewFile,BufRead", "*.cjson", "setfiletype jsonc" },
    { "BufNewFile,BufRead", "*.jsonc", "setfiletype jsonc" },
    { "BufNewFile,BufRead", ".eslintrc.json", "setlocal filetype=jsonc" },
    { "BufNewFile,BufRead", ".babelrc", "setlocal filetype=jsonc" },
    { "BufNewFile,BufRead", ".jshintrc", "setlocal filetype=jsonc" },
    { "BufNewFile,BufRead", ".jslintrc", "setlocal filetype=jsonc" },
    { "BufNewFile,BufRead", ".mocharc.json", "setlocal filetype=jsonc" },
    { "BufNewFile,BufRead", ".mocharc.jsonc", "setlocal filetype=jsonc" },
    { "BufNewFile,BufRead", "coffeelint.json", "setlocal filetype=jsonc" },
    { "BufNewFile,BufRead", "tsconfig.json", "setlocal filetype=jsonc" },
    { "BufNewFile,BufRead", "jsconfig.json", "setlocal filetype=jsonc" },
    { "BufNewFile,BufRead", "*/waybar/config", "setlocal filetype=jsonc" },
  },
}

require("events").nvim_create_augroups(commands)
