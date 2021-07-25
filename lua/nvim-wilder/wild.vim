call wilder#set_option("pipeline", [
  \ wilder#branch(
  \   [
  \     wilder#check({ _, x -> empty(x) }),
  \     wilder#history(),
  \     wilder#result({
  \       "draw": [{ _, x -> " " . x }]
  \     }),
  \   ],
  \   wilder#python_file_finder_pipeline({
  \     "file_command": [ "rg", "--files" ],
  \     "filters": [{ "name": "cpsm_filter", "opts": { "cpsm_path": stdpath("data") .. "/dein/repos/github.com/Potato1682/cpsm/autoload" }}],
  \     "cache_timestamp": { -> 1 },
  \   }),
  \   wilder#cmdline_pipeline({
  \     "fuzzy": 1,
  \     "language": "python",
  \     "fuzzy_filter": wilder#python_cpsm_filter(stdpath("data") .. "/dein/repos/github.com/Potato1682/cpsm/autoload"),
  \     "sorter": wilder#python_lexical_sorter(),
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

let s:highlighters = [
  \ wilder#python_cpsm_highlighter({ "cpsm_path": stdpath("data") .. "/dein/repos/github.com/Potato1682/cpsm/autoload", "highlight_mode": "detailed" }),
  \ wilder#lua_fzy_highlighter()
\ ]

call wilder#set_option("renderer", wilder#renderer_mux({
  \ ":": wilder#popupmenu_renderer({
  \   "highlighter": s:highlighters,
  \   "winblend": 17,
  \   "ellipsis": "…",
  \   "left": [
  \     wilder#popupmenu_devicons({
  \       "get_icon": wilder#devicons_get_icon_from_nvim_web_devicons(),
  \       "get_hl": wilder#devicons_get_hl_from_nvim_web_devicons(),
  \     }),
  \   ],
  \   "right": [
  \     " ",
  \     wilder#popupmenu_scrollbar(),
  \   ],
  \ }),
  \ "/": wilder#wildmenu_renderer({
  \   "highlighter": s:highlighters,
  \   "mode": "statusline",
  \   "left": [
  \     wilder#wildmenu_previous_arrow({ "previous": " ", "hl": "Blue" })
  \   ],
  \   "right": [
  \     wilder#wildmenu_next_arrow({ "next": " ", "previous": " ", "hl": "Blue" })
  \   ]
  \ }),
\ }))
