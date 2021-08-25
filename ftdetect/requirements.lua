local commands = {
  requirementsdetect = {
    { "BufNewFile,BufRead", "requirements.txt", "setfiletype requirements" },
    { "BufNewFile,BufRead", "constraints.txt", "setfiletype requirements" },
    { "BufNewFile,BufRead", "dev-requirements.txt", "setfiletype requirements" },
    { "BufNewFile,BufRead", "requirements/dev.txt", "setfiletype requirements" },
    { "BufNewFile,BufRead", "requires/tests.txt", "setfiletype requirements" },
    { "BufNewFile,BufRead", "requirements.in", "setfiletype requirements" },
    { "BufNewFile,BufRead", "*.pip", "setfiletype requirements" },
  },
}

require("events").nvim_create_augroups(commands)
