require("which-key").setup {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ...
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true -- bindings for prefixed with g
    }
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+" -- symbol prepended to a group
  },
  window = {
    border = "single", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 } -- extra window padding [top, right, bottom, left]
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3 -- spacing between columns
  },
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true -- show help message on the command line when the popup is visible
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false -- use `nowait` when creating keymaps
}

-- Set leader
vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', { noremap = true, silent = true })
vim.g.mapleader = ' '

-- no hl
vim.api.nvim_set_keymap('n', '<Leader>h', ':set hlsearch!<CR>', { noremap = true, silent = true })

-- explorer
vim.api.nvim_set_keymap('n', '<Leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- telescope
vim.api.nvim_set_keymap('n', '<Leader>f', ':Telescope find_files<CR>', { noremap = true, silent = true })

-- dashboard
vim.api.nvim_set_keymap('n', '<Leader>;', ':Dashboard<CR>', { noremap = true, silent = true })

-- Comments
vim.api.nvim_set_keymap("n", "<leader>/", "gcc", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>/", "gcc", { noremap = true, silent = true })

-- close buffer
vim.api.nvim_set_keymap("n", "<leader>c", ":BufferClose<CR>", { noremap = true, silent = true })

-- open projects
vim.api.nvim_set_keymap('n', '<leader>p', ":lua require'telescope'.extensions.project.project{}<CR>", { noremap = true, silent = true })

local japanese_mappings = {
  ["/"] = "コメントアウトを切り替え",
  ["c"] = "バッファーを閉じる",
  ["e"] = "エクスプローラー",
  ["f"] = "ファイルを検索",
  ["h"] = "検索ハイライトを切る",
  ["p"] = "プロジェクト",
  [";"] = "ダッシュボード",
  ["*"] = "ドキュメントを生成",
  ["t"] = { "<cmd>OpenTodo<cr>", "TODO 一覧" },
  d = {
    name = "+診断",
    t = { "<cmd>TroubleToggle<cr>", "エラー一覧" },
    w = { "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", "ワークスペース" },
    d = { "<cmd>TroubleToggle lsp_document_diagnostics<cr>", "ドキュメント内" },
    q = { "<cmd>TroubleToggle quickfix<cr>", "クイックフィックス" },
    l = { "<cmd>TroubleToggle loclist<cr>", "場所を検索" },
    r = { "<cmd>TroubleToggle lsp_references<cr>", "リファレンス" }
  },
  D = {
    name = "+デバッグ",
    b = { "<cmd>DebugToggleBreakpoint<cr>", "ブレークポイントを切り替え" },
    c = { "<cmd>DebugContinue<cr>", "コンティニュー" },
    i = { "<cmd>DebugStepInto<cr>", "ブロック内へステップ" },
    o = { "<cmd>DebugStepOver<cr>", "ブロック末尾までステップ" },
    r = { "<cmd>DebugToggleRepl<cr>", "Repl表示を切り替え" },
    s = { "<cmd>DebugStart<cr>", "開始" }
  },
  g = {
    name = "+Git",
    j = { "<cmd>NextHunk<cr>", "次のHunk" },
    k = { "<cmd>PrevHunk<cr>", "前のHunk" },
    p = { "<cmd>PreviewHunk<cr>", "Hunkをプレビュー" },
    r = { "<cmd>ResetHunk<cr>", "Hunkをリセット" },
    R = { "<cmd>ResetBuffer<cr>", "バッファーをリセット" },
    s = { "<cmd>StageHunk<cr>", "Hunkをステージ" },
    u = { "<cmd>UndoStageHunk<cr>", "Hunkのステージを戻す" },
    o = { "<cmd>Telescope git_status<cr>", "変更済みファイルを開く" },
    b = { "<cmd>Telescope git_branches<cr>", "ブランチをチェックアウト" },
    c = { "<cmd>Telescope git_commits<cr>", "コミットをチェックアウト" },
    C = { "<cmd>Telescope git_bcommits<cr>", "開いているファイルのコミットをチェックアウト" }
  },
  l = {
    name = "+LSP",
    a = { "<cmd>Lspsaga code_action<cr>", "コード アクション" },
    A = { "<cmd>Lspsaga range_code_action<cr>", "選択範囲でコード アクション" },
    d = { "<cmd>Telescope lsp_document_diagnostics<cr>", "ドキュメント内を診断" },
    D = { "<cmd>Telescope lsp_workspace_diagnostics<cr>", "ワークスペースを診断" },
    f = { "<cmd>LspFormatting<cr>", "フォーマット" },
    i = { "<cmd>LspInfo<cr>", "情報" },
    l = { "<cmd>Lspsaga lsp_finder<cr>", "ファインダー" },
    L = { "<cmd>Lspsaga show_line_diagnostics<cr>", "今の行の診断" },
    p = { "<cmd>Lspsaga preview_definition<cr>", "定義をプレビュー" },
    q = { "<cmd>Telescope quickfix<cr>", "クイックフィックス" },
    r = { "<cmd>Lspsaga rename<cr>", "名前を変更" },
    t = { "<cmd>LspTypeDefinition<cr>", "型定義へジャンプ" },
    x = { "<cmd>cclose<cr>", "クイックフィックスを閉じる" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "ドキュメント内のシンボル" },
    S = { "<cmd>Telescope lsp_workspace_symbols<cr>", "ワークスペースのシンボル" }
  },
  s = {
    name = "+検索",
    b = { "<cmd>Telescope git_branches<cr>", "ブランチをチェックアウト" },
    c = { "<cmd>Telescope colorscheme<cr>", "カラースキーム" },
    d = { "<cmd>Telescope lsp_document_diagnostics<cr>", "ドキュメント内の診断情報" },
    D = { "<cmd>Telescope lsp_workspace_diagnostics<cr>", "ワークスペースの診断情報" },
    f = { "<cmd>Telescope find_files<cr>", "ファイルを検索" },
    m = { "<cmd>Telescope marks<cr>", "マーク済みの場所" },
    M = { "<cmd>Telescope man_pages<cr>", "マニュアル" },
    r = { "<cmd>Telescope oldfiles<cr>", "最近開いたファイル" },
    R = { "<cmd>Telescope registers<cr>", "レジスター" },
    t = { "<cmd>Telescope live_grep<cr>", "テキスト" }
  },
  S = { name = "+セッション", s = { "<cmd>SessionSave<cr>", "セッションを保存" }, l = { "<cmd>SessionLoad<cr>", "セッションを開く" } },

  -- extras
  z = {
    name = "+Zen Mode",
    s = { "<cmd>TZBottom<cr>", "ステータスバーの表示を切り替え" },
    t = { "<cmd>TZTop<cr>", "タブの表示を切り替え" },
    z = { "<cmd>TZAtaraxis<cr>", "Zen モードを切り替え" }
  }
}

local mappings = {
  ["/"] = "Comment Toggle",
  ["c"] = "Close Buffer",
  ["e"] = "Explorer",
  ["f"] = "Find File",
  ["h"] = "No Highlight",
  ["p"] = "Projects",
  ["*"] = "Generate document",
  ["t"] = { "<cmd>OpenTodo<cr>", "Open TODOs" },
  d = {
    name = "+Diagnostics",
    t = { "<cmd>TroubleToggle<cr>", "trouble" },
    w = { "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", "workspace" },
    d = { "<cmd>TroubleToggle lsp_document_diagnostics<cr>", "document" },
    q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
    l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
    r = { "<cmd>TroubleToggle lsp_references<cr>", "references" }
  },
  D = {
    name = "+Debug",
    b = { "<cmd>DebugToggleBreakpoint<cr>", "Toggle Breakpoint" },
    c = { "<cmd>DebugContinue<cr>", "Continue" },
    i = { "<cmd>DebugStepInto<cr>", "Step Into" },
    o = { "<cmd>DebugStepOver<cr>", "Step Over" },
    r = { "<cmd>DebugToggleRepl<cr>", "Toggle Repl" },
    s = { "<cmd>DebugStart<cr>", "Start" }
  },
  g = {
    name = "+Git",
    j = { "<cmd>NextHunk<cr>", "Next Hunk" },
    k = { "<cmd>PrevHunk<cr>", "Prev Hunk" },
    p = { "<cmd>PreviewHunk<cr>", "Preview Hunk" },
    r = { "<cmd>ResetHunk<cr>", "Reset Hunk" },
    R = { "<cmd>ResetBuffer<cr>", "Reset Buffer" },
    s = { "<cmd>StageHunk<cr>", "Stage Hunk" },
    u = { "<cmd>UndoStageHunk<cr>", "Undo Stage Hunk" },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    C = { "<cmd>Telescope git_bcommits<cr>", "Checkout commit(for current file)" }
  },
  l = {
    name = "+LSP",
    a = { "<cmd>Lspsaga code_action<cr>", "Code Action" },
    A = { "<cmd>Lspsaga range_code_action<cr>", "Selected Action" },
    d = { "<cmd>Telescope lsp_document_diagnostics<cr>", "Document Diagnostics" },
    D = { "<cmd>Telescope lsp_workspace_diagnostics<cr>", "Workspace Diagnostics" },
    f = { "<cmd>LspFormatting<cr>", "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    l = { "<cmd>Lspsaga lsp_finder<cr>", "LSP Finder" },
    L = { "<cmd>Lspsaga show_line_diagnostics<cr>", "Line Diagnostics" },
    p = { "<cmd>Lspsaga preview_definition<cr>", "Preview Definition" },
    q = { "<cmd>Telescope quickfix<cr>", "Quickfix" },
    r = { "<cmd>Lspsaga rename<cr>", "Rename" },
    t = { "<cmd>LspTypeDefinition<cr>", "Type Definition" },
    x = { "<cmd>cclose<cr>", "Close Quickfix" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = { "<cmd>Telescope lsp_workspace_symbols<cr>", "Workspace Symbols" }
  },
  s = {
    name = "+Search",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    d = { "<cmd>Telescope lsp_document_diagnostics<cr>", "Document Diagnostics" },
    D = { "<cmd>Telescope lsp_workspace_diagnostics<cr>", "Workspace Diagnostics" },
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    m = { "<cmd>Telescope marks<cr>", "Marks" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    t = { "<cmd>Telescope live_grep<cr>", "Text" }
  },
  S = { name = "+Session", s = { "<cmd>SessionSave<cr>", "Save Session" }, l = { "<cmd>SessionLoad<cr>", "Load Session" } },

  -- extras
  z = {
    name = "+Zen",
    s = { "<cmd>TZBottom<cr>", "toggle status line" },
    t = { "<cmd>TZTop<cr>", "toggle tab bar" },
    z = { "<cmd>TZAtaraxis<cr>", "toggle zen" }
  }
}

if O.japanese then
    require"which-key".register(japanese_mappings, opts)
else
    require"which-key".register(mappings, opts)
end

