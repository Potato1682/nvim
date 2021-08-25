local commands = {
  sysctldetect = {
    { "BufNewFile,BufRead", "/usr/lib/sysctl.d/*.conf", "setfiletype sysctl" },
  },
}

require("events").nvim_create_augroups(commands)
