let s:can_use_lua_pcre2 = luaeval("pcall(require, 'pcre2')")

function! s:page_index(ctx, result) abort
  let l:total = len(a:result.value) == 0 ? "-" : len(a:result.value)
  let l:page_start = a:ctx.page[0] == -1 ? "" : a:ctx.page[0] + 1
  let l:page_end   = a:ctx.page[1] == -1 ? "" : a:ctx.page[1] + 1
  let l:displaywidth = len(l:total)

  let l:selected = a:ctx.selected == -1 ? "-" : a:ctx.selected + 1

  let l:result = " "
  let l:result .= repeat(" ", l:displaywidth - len(l:selected)) . l:selected

  if l:page_start == 1 && l:page_end == 1
    let l:pages = " / " . 1
  else
    let l:pages = " / " . repeat(" ", l:displaywidth - len(l:page_start)) . l:page_start . "-" . repeat(" ", l:displaywidth - len(l:page_end)) . l:page_end
  endif

  if len(l:result) + len(l:pages) + 1 + len(l:total) <= a:ctx.width
    let l:result .= l:pages
  endif

  let l:result .= " / " . l:total

  return l:result
endfunction

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
  \       "sorter": wilder#python_fuzzywuzzy_sorter(),
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
  \                    "cpsm_path": stdpath("data") . "/site/pack/packer/opt/cpsm/autoload"
  \                  }
  \                }],
  \     "path": wilder#project_root([ ".hg", ".git", "package.json" ]),
  \   }),
  \   wilder#cmdline_pipeline({
  \     "fuzzy": 2,
  \     "language": "python",
  \     "fuzzy_filter": wilder#lua_fzy_filter(),
  \     "set_pcre2_pattern": s:can_use_lua_pcre2 ? 1 : 0,
  \   }),
  \   wilder#python_search_pipeline({
  \     "pattern": wilder#python_fuzzy_pattern({
  \       "start_at_boundary": 0,
  \     }),
  \     "engine": "re2",
  \     "sorter": wilder#python_fuzzywuzzy_sorter(),
  \   }),
  \ ),
\ ])

let s:highlighters = [
  \ wilder#python_cpsm_highlighter({
  \   "cpsm_path": stdpath("data") . "/site/pack/packer/opt/cpsm/autoload",
  \   "highlight_mode": "detailed",
  \ }),
\ ]

if s:can_use_lua_pcre2
  let s:highlighters = extend([
    \ wilder#lua_pcre2_highlighter()
  \ ], s:highlighters)
endif

let s:scale = ['#ec6449', '#f3784c', '#f88e53', '#fba35e', '#fdb76b',
\              '#fdca79', '#feda89', '#fee89a', '#fdf2a8', '#fbf8b0',
\              '#f5faad', '#ebf7a6', '#ddf1a0', '#ccea9f', '#b7e2a1',
\              '#a0d9a3', '#89cfa5', '#72c3a7', '#5cb3ac', '#4ba0b1']

let s:popupmenu_gradient = map(copy(s:scale), { i, fg -> wilder#make_hl(
\  "WilderPopupmenuAccent" . i, "Pmenu", [ {}, {}, { "foreground": fg, "bold": 0 }]
\ )})

let s:wildmenu_gradient = map(copy(s:scale), { i, fg -> wilder#make_hl(
\  "WilderWildmenuAccent" . i, "MsgArea", [ {}, {}, { "foreground": fg, "bold": 0 }]
\ )})

let s:highlighter_with_gradient = wilder#highlighter_with_gradient(s:highlighters)

let s:wildmenu_renderer = wilder#wildmenu_renderer({
  \ "highlights": {
  \   "gradient": s:wildmenu_gradient,
  \   "separator": "Grey",
  \ },
  \ "ellipsis": "…",
  \ "left": [
  \   {
  \     "value": "  ",
  \     "hl": "Title",
  \   },
  \   {
  \     "value": wilder#wildmenu_spinner({
  \       "frames": [ "⠋ ", "⠙ ", "⠹ ", "⠸ ", "⠼ ", "⠴ ", "⠦ ", "⠧ ", "⠇ ", "⠏ " ],
  \       "done": " ",
  \       "interval": 80,
  \     }),
  \     "hl": "Title",
  \   },
  \   {
  \     "value": wilder#wildmenu_powerline_separator("", "Title", "StatusLine"),
  \   },
  \   {
  \     "value": " ",
  \   },
  \   {
  \     "value": wilder#wildmenu_previous_arrow({
  \       "previous": " ",
  \     })
  \   },
  \ ],
  \ "right": [
  \   {
  \     "value": wilder#wildmenu_next_arrow({
  \       "next": " ",
  \       "previous": "   ",
  \       "hl": "Grey",
  \     })
  \   },
  \   {
  \     "value": " ",
  \     "hl": "Grey",
  \   },
  \   {
  \     "value": wilder#wildmenu_index({
  \       "hl": "Grey",
  \     })
  \   },
  \ ],
  \ "highlighter": s:highlighter_with_gradient,
\ })

call wilder#set_option("renderer", wilder#renderer_mux({
  \ ":": wilder#popupmenu_renderer({
  \   "highlights": {
  \     "gradient": s:popupmenu_gradient,
  \   },
  \   "highlighter": s:highlighter_with_gradient,
  \   "winblend": 17,
  \   "ellipsis": "…",
  \   "left": [
  \     " ",
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
  \   "bottom": [
  \     { ctx, result -> s:page_index(ctx, result) },
  \   ],
  \ }),
  \ "/": s:wildmenu_renderer,
  \ "substitute": s:wildmenu_renderer
\ }))
