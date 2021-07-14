require("events").nvim_create_autocmd { { "BufNewFile,BufRead", "*.nix", "setfiletype nix" } }
