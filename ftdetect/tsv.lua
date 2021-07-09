local commands = {
  tsvdetect = {
    { "BufNewFile,BufRead", "*.tsv", "setfiletype tsv" },
    { "BufNewFile,BufRead", "*.tab", "setfiletype tsv" },
  },
}

require("events").nvim_create_augroups(commands)
