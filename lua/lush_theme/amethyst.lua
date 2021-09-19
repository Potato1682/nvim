--
-- Built with,
--
--        ,gggg,
--       d8" "8I                         ,dPYb,
--       88  ,dP                         IP'`Yb
--    8888888P"                          I8  8I
--       88                              I8  8'
--       88        gg      gg    ,g,     I8 dPgg,
--  ,aa,_88        I8      8I   ,8'8,    I8dP" "8I
-- dP" "88P        I8,    ,8I  ,8'  Yb   I8P    I8
-- Yb,_,d88b,,_   ,d8b,  ,d8b,,8'_   8) ,d8     I8,
--  "Y8P"  "Y888888P'"Y88P"`Y8P' "YY8P8P88P     `Y8
--

-- This is a starter colorscheme for use with Lush,
-- for usage guides, see :h lush or :LushRunTutorial

--
-- Note: Because this is lua file, vim will append your file to the runtime,
--       which means you can require(...) it in other lua code (this is useful),
--       but you should also take care not to conflict with other libraries.
--
--       (This is a lua quirk, as it has somewhat poor support for namespacing.)
--
--       Basically, name your file,
--
--       "super_theme/lua/lush_theme/super_theme_dark.lua",
--
--       not,
--
--       "super_theme/lua/dark.lua".
--
--       With that caveat out of the way...
--

-- Enable lush.ify on this file, run:
--
--  `:Lushify`
--
--  or
--
--  `:lua require('lush').ify()`

local lush = require "lush"
local hsluv = lush.hsluv

local theme = lush(function()
  return {
    -- The following are all the Neovim default highlight groups from the docs
    -- as of 0.5.0-nightly-446, to aid your theme creation. Your themes should
    -- probably style all of these at a bare minimum.
    --
    -- Referenced/linked groups must come before being referenced/lined,
    -- so the order shown ((mostly) alphabetical) is likely
    -- not the order you will end up with.
    --
    -- You can uncomment these and leave them empty to disable any
    -- styling for that group (meaning they mostly get styled as Normal)
    -- or leave them commented to apply vims default colouring or linking.

    Normal { fg = hsluv "#c5cdd9", bg = hsluv "#2f313a" }, -- normal text
    NormalFloat { Normal, bg = Normal.bg.ro(10).li(10) }, -- Normal text in floating windows.
    NormalNC { Normal }, -- normal text in non-current windows
    Red { fg = hsluv("#ec7279").da(8).sa(20) },
    Blue { fg = hsluv "#6cb6eb" },
    Green { fg = hsluv "#a0c980" },
    Cyan { fg = hsluv "#5dbbc1" },
    Yellow { fg = hsluv("#deb974").ro(5).li(24) },
    Grey { fg = hsluv "#7f8490" },
    Purple { fg = hsluv "#d38aea" },
    DarkPurple { fg = hsluv "#bb70d2" },
    Comment { fg = hsluv "#7e8294", gui = "italic" }, -- any comment
    Lighter { bg = Normal.bg.li(8) },
    ColorColumn { bg = Lighter.bg.da(16) }, -- used for the columns set with 'colorcolumn'

    -- placeholder characters substituted for concealed text (see 'conceallevel')
    Conceal { Comment, cterm = "", gui = "" },

    Cursor { bg = hsluv("#0072f3").ro(5) },
    lCursor { Cursor }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
    CursorIM { fg = Normal.fg.da(10), bg = Normal.bg.da(10) }, -- like Cursor, but used when in IME mode |CursorIM|
    CursorColumn { Lighter }, -- Screen-column at the cursor, when 'cursorcolumn' is set.

    -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
    CursorLine { Lighter },

    Directory { Green }, -- directory names (and other special names in listings)
    DiffAdd { bg = hsluv(131, 70, 25), blend = 13 }, -- diff mode: Added line |diff.txt|
    DiffAddSeparator { fg = Comment.fg, bg = DiffAdd.bg.da(20) },
    DiffText { bg = hsluv(251, 80, 38) }, -- diff mode: Changed text within a changed line |diff.txt|
    DiffChange { bg = DiffText.bg.da(26) }, -- diff mode: Changed line |diff.txt|
    DiffModifiedSeparator { fg = Comment.fg, bg = DiffChange.bg.da(20) },
    DiffDelete { bg = hsluv(10, 80, 18), blend = 13 }, -- diff mode: Deleted line |diff.txt|
    DiffRemoveSeparator { fg = Comment.fg, bg = DiffDelete.bg.da(20) }, -- diff mode: Deleted line |diff.txt|

    -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
    EndOfBuffer { Normal, fg = Normal.bg },

    Terminal { Normal, bg = Normal.bg.da(30) },
    TermCursor { Cursor }, -- cursor in a focused terminal
    TermCursorNC { bg = Cursor.bg.da(10) }, -- cursor in an unfocused terminal
    ErrorMsg { Red }, -- error messages on the command line
    WarningMsg { Yellow }, -- warning messages
    InfoMsg { Blue },
    VertSplit { ColorColumn, fg = Normal.fg.da(70) }, -- the column separating vertically split windows
    Folded { fg = Normal.fg.da(40), bg = Normal.bg.ro(3).da(4), gui = "underline" }, -- line used for closed folds
    FoldColumn { Folded }, -- 'foldcolumn'
    SignColumn { Normal }, -- column where |signs| are displayed
    IncSearch { DiffText, fg = Normal.fg }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"

    -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    LineNr { fg = Normal.fg.da(60) },

    -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    CursorLineNr { fg = Normal.fg.da(20), bg = Normal.bg.li(3) },

    -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    MatchParen { bg = Normal.bg.li(15), gui = "underline" },

    ModeMsg { fg = Normal.fg.da(50), gui = "italic" }, -- 'showmode' message (e.g., "-- INSERT -- ")
    MsgArea { fg = Normal.fg.li(40), bg = Normal.bg.da(10) }, -- Area for messages and cmdline
    FloatBorder { fg = MsgArea.bg, bg = MsgArea.bg },
    MsgSeparator { bg = Normal.bg.da(15) }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    MoreMsg { ModeMsg }, -- |more-prompt|

    -- '@' at the end of the window, characters from 'showbreak'
    -- and other characters that do not really exist in the text
    -- (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line).
    -- See also |hl-EndOfBuffer|.
    NonText { fg = Normal.fg.da(60) },

    Pmenu { NormalFloat }, -- Popup menu: normal item.
    PmenuSel { fg = Normal.fg.da(8), bg = hsluv "#4a4cfa" }, -- Popup menu: selected item.
    PmenuSbar { bg = NormalFloat.bg.da(8) }, -- Popup menu: scrollbar.
    PmenuThumb { bg = Normal.bg.li(50) }, -- Popup menu: Thumb of the scrollbar.
    Question { fg = Normal.fg.da(30).ro(20), gui = "italic" }, -- |hit-enter| prompt and yes/no questions

    -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
    Search { DiffChange },

    -- Unprintable characters: text displayed differently from what it really is.
    -- But not 'listchars' whitespace. |hl-Whitespace|
    SpecialKey { NonText },

    -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    SpellBad { gui = "underline", sp = Red.fg.da(20) },

    -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    SpellCap { gui = "underline", sp = Yellow.fg.da(30) },

    -- Word that is recognized by the spellchecker as one that is used in another region.
    -- |spell| Combined with the highlighting used otherwise.
    SpellLocal { gui = "underline", sp = Green.fg.da(30) },

    -- Word that is recognized by the spellchecker as one that is hardly ever used.
    -- |spell| Combined with the highlighting used otherwise.
    SpellRare { gui = "underline", sp = Purple.fg.da(30) },

    StatusLine { Normal, bg = MsgArea.bg }, -- status line of current window
    StatusLineNc { fg = Normal.fg.da(20), bg = MsgArea.bg },
    StatusLineTerm { StatusLine },
    StatusLineTermNC { fg = Normal.fg.da(20), bg = MsgArea.bg },
    TabLine { Normal, bg = MsgArea.bg }, -- tab pages line, not active tab page label
    TabLineFill { ModeMsg, gui = "none" }, -- tab pages line, where there are no labels
    TabLineSel { ModeMsg }, -- tab pages line, active tab page label
    Title { PmenuSel }, -- titles for output from ":set all", ":autocmd" etc.
    Visual { bg = Normal.bg.li(7) }, -- Visual mode selection
    Whitespace { SpecialKey }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    WildMenu { PmenuSel }, -- current match in 'wildmenu' completion

    -- These groups are not listed as default vim groups,
    -- but they are defacto standard group names for syntax highlighting.
    -- commented out groups should chain up to their "preferred" group by
    -- default,
    -- Uncomment and edit if you want more specific syntax highlighting.

    Constant { fg = hsluv("#20b2aa").ro(10) }, -- (preferred) any constant
    String { Green }, --   a string constant: "this is a string"
    Character { Yellow }, --  a character constant: 'c', '\n'
    Number { Green }, --   a number constant: 234, 0xff
    Boolean { Green, gui = "italic" }, --  a boolean constant: TRUE, false

    Identifier { fg = hsluv "#ec7279" }, -- (preferred) any variable name
    Function { fg = PmenuSel.bg.li(30).sa(0) }, -- function name (also: methods for classes)

    Statement { Purple, gui = "italic" }, -- (preferred) any statement
    Conditional { Statement }, --  if, then, else, endif, switch, etc.
    Repeat { Statement }, --   for, do, while, etc.
    Label { Purple }, --    case, default, etc.
    Operator { Purple }, -- "sizeof", "+", "*", etc.
    Exception { Statement }, --  try, catch, throw

    PreProc { fg = PmenuSel.bg.ro(8).li(8).sa(0), gui = "italic" }, -- (preferred) generic Preprocessor

    Type { DarkPurple, gui = "italic" }, -- (preferred) int, long, char, etc.
    Keyword { DarkPurple, gui = "italic" }, --  any other keyword

    Special { Purple }, -- (preferred) any special symbol

    CurrentWord { MatchParen, gui = "" },
    ExtraWhiteSpace { DiffDelete },

    Bold { gui = "bold" },
    Italic { gui = "italic" },

    -- ("Ignore", below, may be invisible...)
    -- Ignore         { }, -- (preferred) left blank, hidden  |hl-Ignore|

    Error { gui = "undercurl", sp = hsluv "#ec7279" }, -- (preferred) any erroneous construct
    Warning { gui = "undercurl", sp = Yellow.fg },

    -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX
    Todo { fg = Purple.fg, gui = "italic,bold" },

    -- These groups are for the native LSP client. Some other LSP clients may
    -- use these groups, or use their own. Consult your LSP client's
    -- documentation.

    -- LspReferenceText                     { }, -- used for highlighting "text" references
    -- LspReferenceRead                     { }, -- used for highlighting "read" references
    -- LspReferenceWrite                    { }, -- used for highlighting "write" references

    -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
    LspDiagnosticsDefaultError { Red },

    -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
    LspDiagnosticsDefaultWarning { Yellow },

    -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
    LspDiagnosticsDefaultInformation { Blue },

    -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
    LspDiagnosticsDefaultHint { Green },

    LspDiagnosticsUnderlineError { Error }, -- Used to underline "Error" diagnostics
    LspDiagnosticsUnderlineWarning { Warning }, -- Used to underline "Warning" diagnostics

    -- Used to underline "Information" diagnostics
    LspDiagnosticsUnderlineInformation { gui = "undercurl", sp = Blue.fg },

    LspDiagnosticsUnderlineHint { gui = "undercurl", sp = Green.fg.li(20) }, -- Used to underline "Hint" diagnostics

    -- These groups are for the neovim tree-sitter highlights.
    -- As of writing, tree-sitter support is a WIP, group names may change.
    -- By default, most of these groups link to an appropriate Vim group,
    -- TSError -> Error for example, so you do not have to define these unless
    -- you explicitly want to support Treesitter's improved syntax awareness.

    -- For C++/Dart attributes, annotations that can be attached to the code to denote some kind of meta information.
    TSAnnotation { fg = hsluv "#72737A" },
    TSAttribute { TSAnnotation }, -- (unstable) TODO: docs
    TSConstructor { Statement }, -- For constructor calls and definitions: ` { }` in Lua, and Java constructors.
    TSConstBuiltin { Statement }, -- For constant that are built in the language: `nil` in Lua.
    TSConstMacro { Statement }, -- For constants that are defined by macros: `NULL` in C.
    TSError { Error }, -- For syntax/parser errors.
    TSParameter { fg = Yellow.fg.da(15) }, -- For parameters of a function.
    TSPunctDelimiter { fg = Normal.fg.da(40) }, -- For delimiters ie: `.`
    TSStringRegex { String, gui = "italic" }, -- For regexes.
    TSStringEscape { Character }, -- For escape characters within a string.
    TSType { Constant }, -- For types.
    TSVariable { Blue }, -- Any variable name that does not have another highlight.

    -- Variable names that are defined by the languages, like `this` or `self`.
    TSVariableBuiltin { fg = PreProc.fg.li(20).ro(10) },

    TSUnderline { fg = Normal.fg.da(30) }, -- For text to be represented with an underline.
    TSStrike { gui = "strikethrough" }, -- For strikethrough text.

    -- p00f/nvim-ts-rainbow
    rainbowcol1 { Red },
    rainbowcol2 { Yellow },
    rainbowcol3 { Green },
    rainbowcol4 { Cyan },
    rainbowcol5 { Blue },
    rainbowcol6 { Purple },
    rainbowcol7 { Green },

    -- lukas-reineke/indent-blankline.nvim
    IndentRainbow1 { Red },
    IndentRainbow2 { Yellow },
    IndentRainbow3 { Green },
    IndentRainbow4 { Cyan },
    IndentRainbow5 { Blue },
    IndentRainbow6 { Purple },

    -- APZelos/blamer.nvim
    Blamer { Grey },

    -- liuchengxu/vista.vim
    VistaBracket { Grey },
    VistaChildrenNr { Yellow },
    VistaScope { Red },
    VistaTag { Green },
    VistaPrefix { Grey },
    VistaColon { Green },
    VistaIcon { Purple },
    VistaLineNr { Normal },
    VistaScopeKind { Green },
    VistaHeadNr { Normal },
    VistaPublic { Blue },
    VistaProtected { Green },
    VistaPrivate { Purple },

    -- sindrets/diffview.nvim
    DiffviewFilePanelTitle { Green },
    DiffviewFilePanelCounter { Blue },

    -- netrw
    netrwDir { Green },
    netrwClassify { Green },
    netrwLink { Grey },
    netrwSymLink { Normal },
    netrwExe { Yellow },
    netrwComment { Grey },
    netrwList { Cyan },
    netrwHelpCmd { Blue },
    netrwCmdSep { Grey },
    netrwVersion { Purple },

    -- kyazdani42/nvim-tree.lua
    NvimTreeSymlink { Normal },
    NvimTreeFolderName { Green },
    NvimTreeRootFolder { fg = Grey.fg.da(30) },
    NvimTreeFolderIcon { Blue },
    NvimTreeEmptyFolderName { Green },
    NvimTreeOpenedFolderName { Green },
    NvimTreeExecFile { Yellow },
    NvimTreeOpenedFile { Normal },
    NvimTreeSpecialFile { Blue },
    NvimTreeImageFile { Purple },
    NvimTreeMarkdownFile { Normal },
    NvimTreeIndentMarker { Grey },
    NvimTreeGitStaged { Blue },
    NvimTreeGitMerge { fg = Blue.fg.ro(10) },
    NvimTreeGitRenamed { Purple },
    NvimTreeNew { Green },
    NvimTreeDeleted { Red },

    -- mbbill/undotree
    UndotreeNode { Green },
    UndotreeNodeCurrent { Blue },
    UndotreeSeq { Green },
    UndotreeCurrent { Blue },
    UndotreeNext { Yellow },
    UndotreeTimeStamp { Grey },
    UndotreeHead { Purple },
    UndotreeBranch { Blue },
    UndotreeSavedSmall { Red },

    -- which-key
    WhichKey { Red },
    WhichKeySeparator { Green },
    WhichKeyGroup { Purple },
    WhichKeyDesc { Blue },
    WhichKeyFloat { bg = MsgArea.bg },

    -- RRethy/vim-illuminate
    illuminatedWord { CurrentWord },

    -- phaazon/hop.nvim
    HopNextKey { Blue, gui = "underline" },
    HopNextKey1 { Purple },
    HopNextKey2 { Blue },
    HopUnmatched { Grey },

    -- andymass/vim-matchup
    MatchParenCur { MatchParen },
    MatchWord { CurrentWord },
    MatchWordCur { CurrentWord },

    -- lewis6991/gitsigns.nvim
    GitSignsAdd { Green },
    GitSignsChange { Blue },
    GitSignsDelete { Red },
    GitSignsChangeDelete { Purple },

    -- nvim-telescope/telescope.nvim
    TelescopeBorder { Grey },
    TelescopePromptPrefix { Purple },
    TelescopeSelection { CurrentWord, fg = Green.fg },

    -- neomake/neomake
    NeomakeError { ErrorMsg },
    NeomakeWarning { WarningMsg },
    NeomakeInfo { InfoMsg },
    NeomakeMessage { Normal, bg = "" },
    NeomakeErrorSign { Red },
    NeomakeWarningSign { Yellow },
    NeomakeInfoSign { Blue },
    NeomakeMessageSign { Green },
    NeomakeVirtualtextError { Red },
    NeomakeVirtualtextWarning { Yellow },
    NeomakeVirtualtextInfo { Blue },
    NeomakeVirtualtextMessage { Green },
  }
end)

-- return our parsed theme for extension or use else where.
return theme

-- vi:nowrap
