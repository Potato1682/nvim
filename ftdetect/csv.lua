local commands = {
  csvdetect = {
    { "BufNewFile,BufRead", "*.csv", "setfiletype csv" },
    { "BufNewFile,BufRead", "*.dat", "setfiletype csv_pipe" },
  },
}

require("events").nvim_create_augroups(commands)
