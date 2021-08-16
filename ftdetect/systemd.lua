local commands = {
  systemddetect = {
    { "BufNewFile,BufRead", "*.automount", "setfiletype systemd" },
    { "BufNewFile,BufRead", "*.mount", "setfiletype systemd" },
    { "BufNewFile,BufRead", "*.path", "setfiletype systemd" },
    { "BufNewFile,BufRead", "*.service", "setfiletype systemd" },
    { "BufNewFile,BufRead", "*.socket", "setfiletype systemd" },
    { "BufNewFile,BufRead", "*.swap", "setfiletype systemd" },
    { "BufNewFile,BufRead", "*.target", "setfiletype systemd" },
    { "BufNewFile,BufRead", "*.timer", "setfiletype systemd" },
    { "BufNewFile,BufRead", "*.slice", "setfiletype systemd" },
    { "BufNewFile,BufRead", "*.nspwan", "setfiletype systemd" },
    { "BufNewFile,BufRead", "*.unit", "setfiletype systemd" },
    { "BufNewFile,BufRead", "*.link", "setfiletype systemd" },
    { "BufNewFile,BufRead", "*.netdev", "setfiletype systemd" },
    { "BufNewFile,BufRead", "*.network", "setfiletype systemd" },
    { "BufNewFile,BufRead", "/etc/systemd/*.conf", "setfiletype config" },
  },
}

require("events").nvim_create_augroups(commands)
