local commands = {
  i3configdetect = {
    { "BufNewFile,BufRead", ".i3.config", "setfiletype i3config" },
    { "BufNewFile,BufRead", "i3.config", "setfiletype i3config" },
    { "BufNewFile,BufRead", "*.i3.config", "setfiletype i3config" },
    { "BufNewFile,BufRead", "*.i3config", "setfiletype i3config" },
    { "BufNewFile,BufRead", "*i3/config", "setfiletype i3config" },
    { "BufNewFile,BufRead", "*sway/config", "setfiletype i3config" },
    { "BufNewFile,BufRead", "*.swayconfig", "setfiletype i3config" },
    { "BufNewFile,BufRead", "*.sway.config", "setfiletype i3config" },
    { "BufNewFile,BufRead", "sway.config", "setfiletype i3config" },
  },
}

require("events").nvim_create_augroups(commands)
