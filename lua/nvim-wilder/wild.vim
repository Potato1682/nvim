call wilder#set_option("pipeline", [
  \ wilder#debounce(10),
  \ wilder#branch(
  \   [
  \     wilder#check({ _, x -> empty(x) }),
  \     wilder#history(),
  \     wilder#result({
  \       "draw": [{ _, x -> " " . x }]
  \     }),
  \   ],
  \   wilder#substitute_pipeline({
  \     "pipeline": wilder#python_search_pipeline({
  \       "pattern": wilder#python_fuzzy_pattern({
  \         "start_at_boundary": 0,
  \       }),
  \       "engine": "re2",
  \       "sorter": wilder#python_lexical_sorter(),
  \       "skip_cmdtype_check": 1,
  \     }),
  \   }),
  \   wilder#python_file_finder_pipeline({
  \     "file_command": { _, arg -> arg[0] ==# "."
  \                         ? [ "fd", "-tf", "-H" ]
  \                         : [ "fd", "-tf" ]
  \                     },
  \     "dir_command": [ "fd", "-td" ],
  \     "filters": [{
  \                  "name": "cpsm_filter",
  \                  "opts": {
  \                    "cpsm_path": stdpath("data") . "/dein/repos/github.com/nixprime/cpsm/autoload"
  \                  }
  \                }],
  \     "cache_timestamp": { -> 1 },
  \   }),
  \   wilder#cmdline_pipeline({
  \     "fuzzy": 2,
  \     "language": "python",
  \     "fuzzy_filter": wilder#python_cpsm_filter(stdpath("data") . "/dein/repos/github.com/nixprime/cpsm/autoload"),
  \     "sorter": wilder#python_fuzzywuzzy_sorter(),
  \     "set_pcre2_pattern": 0,
  \   }),
  \   wilder#python_search_pipeline({
  \     "pattern": wilder#python_fuzzy_pattern({
  \       "start_at_boundary": 0,
  \     }),
  \     "engine": "re2",
  \     "sorter": wilder#python_lexical_sorter(),
  \   }),
  \ ),
\ ])

let s:highlighter = wilder#python_cpsm_highlighter({
\   "cpsm_path": stdpath("data") . "/dein/repos/github.com/nixprime/cpsm/autoload",
\   "highlight_mode": "detailed"
\ })

call wilder#set_option("renderer", wilder#renderer_mux({
  \ ":": wilder#popupmenu_renderer({
  \   "highlighter": s:highlighter,
  \   "winblend": 17,
  \   "ellipsis": "…",
  \   "left": [
  \     wilder#popupmenu_devicons({
  \       "get_icon": wilder#devicons_get_icon_from_nvim_web_devicons({
  \         "dir_icon": "",
  \         "default_icon": "",
  \       }),
  \       "get_hl": wilder#devicons_get_hl_from_nvim_web_devicons({
  \         "dir_hl": "Blue",
  \         "default_hl": "Normal",
  \       }),
  \     }),
  \   ],
  \   "right": [
  \     " ",
  \     wilder#popupmenu_scrollbar(),
  \   ],
  \ }),
  \ "/": wilder#wildmenu_renderer(wilder#wildmenu_lightline_theme({
  \   "use_powerline_symbols": 0,
  \   "highlights": {
  \     "mode": "Title",
  \     "index": "Grey",
  \     "left_arrow2": "Normal",
  \     "right_arrow2": "Normal",
  \   },
  \   "highlighter": s:highlighter,
  \ })),
\ }))
