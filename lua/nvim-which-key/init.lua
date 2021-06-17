require("which-key").setup {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = { enabled = true, suggestions = 20 },
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+" -- symbol prepended to a group
  },
  window = {
    border = "single"
  },
  layout = {
    height = { min = 4, max = 25},
    width = { min = 20, max = 50 },
    spacing = 3
  },
  key_labels = { ["<space>"] = "SPC", ["<tab>"] = "TAB" },
  hidden = {"<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
  show_help = true,
  triggers = { "<leader>" }
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false -- use `nowait` when creating keymaps
}

local japanese_mappings = {
  ["c"] = "バッファーを閉じる",
  ["e"] = "エクスプローラー",
  ["f"] = "ファイルを検索",
  ["h"] = "検索ハイライトを切る",
  ["p"] = "プロジェクト",
  [";"] = "ダッシュボード",
  ["*"] = "ドキュメントを生成",
  ["t"] = { "<cmd>TodoTrouble<cr>", "TODO 一覧" },
  ["r"] = { "<cmd>ToggleTerm<cr>", "端末" },
  ["v"] = { "<cmd>SymbolsOutline<cr>", "シンボル リスト" },
  ["w"] = { "<cmd>lua require'dapui'.toggle()<cr>", "デバッグ インターフェース" },
  ["x"] = { "<cmd>TroubleToggle<cr>", "エラー一覧" },
  ["u"] = { "<cmd>UndotreeToggle<cr>", "ナビゲーター" },
  ["q"] = { "<cmd>DBUIToggle<cr>", "データベース エクスプローラー" },
  ["m"] = { "<Plug>MarkdownPreviewToggle", "Markdownのプレビューを切り替え" },
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
    b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "ブレークポイントを切り替え" },
    B = { "<cmd>Telescope dap list_breakpoints<cr>", "ブレークポイント一覧" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "コンティニュー" },
    e = { "<cmd>lua require'dapui'.eval()<cr>", "現在行を評価" },
    h = { "<Plug>RestNvim", "HTTP をテスト" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "ブロック内へステップ" },
    f = { "<cmd>lua require'dapui'.float_element()", "フィールドを確認" },
    o = { "<cmd>lua require'dap'.step_out()<cr>", "ブロック末尾までステップ" },
    r = { "<cmd>lua require'dap'.repl_open()<cr>", "Replを開く" },
    s = { "<cmd>lua require'dap'.run()<cr>", "開始" }
  },
  g = {
    name = "+Git",
    j = { "<cmd>Gitsigns next_hunk<cr>", "次のHunk" },
    k = { "<cmd>Gitsigns prev_hunk<cr>", "前のHunk" },
    p = { "<cmd>Gitsigns preview_hunk<cr>", "Hunkをプレビュー" },
    r = { "<cmd>Gitsigns reset_hunk<cr>", "Hunkをリセット" },
    R = { "<cmd>Gitsigns reset_buffer<cr>", "バッファーをリセット" },
    s = { "<cmd>Gitsigns stage_hunk<cr>", "Hunkをステージ" },
    u = { "<cmd>Gitsigns undo_stage_hunk<cr>", "Hunkのステージを戻す" },
    o = { "<cmd>Telescope git_status<cr>", "変更済みファイルを開く" },
    b = { "<cmd>Telescope git_branches<cr>", "ブランチをチェックアウト" },
    c = { "<cmd>Neogit commit<cr>", "変更をコミット" },
    C = { "<cmd>Telescope git_commits<cr>", "コミットをチェックアウト" },
    g = { "<cmd>Neogit<cr>", "Git ウィンドウ" },
    m = {
      name = "+マージ",
      t = { "<Plug>(MergetoolToggle)", "マージ ツール" },
      g = { "<cmd>diffget<cr>", "リモートの変更を受け入れる" },
      p = { "<cmd>diffput<cr>", "ローカルの変更を適用" }
    }
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
    a = { "<cmd>lua require('spectre').open_file_search()<cr>", "ファイル内を置換" },
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
  S = {
    name = "+セッション",
    s = { "<cmd>SessionSave<cr>", "セッションを保存" },
    l = { "<cmd>SessionLoad<cr>", "セッションを開く" }
  },

  -- extras
  z = {
    name = "+Zen Mode",
    s = { "<cmd>TZBottom<cr>", "ステータスバーの表示を切り替え" },
    t = { "<cmd>TZTop<cr>", "タブの表示を切り替え" },
    z = { "<cmd>TZAtaraxis<cr>", "Zen モードを切り替え" }
  }
}

local mappings = {
  ["c"] = "Close Buffer",
  ["e"] = "Explorer",
  ["f"] = "Find File",
  ["h"] = "No Highlight",
  ["p"] = "Projects",
  ["*"] = "Generate document",
  ["t"] = { "<cmd>TodoTrouble<cr>", "Open TODOs" },
  ["r"] = { "<cmd>ToggleTerm<cr>", "Terminal" },
  ["v"] = { "<cmd>SymbolsOutline<cr>", "Symbol List" },
  ["w"] = { "<cmd>lua require'dapui'.toggle()<cr>", "Debug UI" },
  ["x"] = { "<cmd>TroubleToggle<cr>", "Error List" },
  ["u"] = { "<cmd>UndotreeToggle<cr>", "Undo Tree" },
  ["q"] = { "<cmd>DBUIToggle", "Database UI" },
  ["m"] = { "<Plug>MarkdownPreviewToggle", "Toggle markdown preview" },
  d = {
    name = "+Diagnostics",
    t = { "<cmd>TroubleToggle<cr>", "Error List" },
    w = { "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", "workspace" },
    d = { "<cmd>TroubleToggle lsp_document_diagnostics<cr>", "document" },
    q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
    l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
    r = { "<cmd>TroubleToggle lsp_references<cr>", "references" }
  },
  D = {
    name = "+Debug",
    b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
    B = { "<cmd>Telescope dap list_breakpoints<cr>", "Breakpoints" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate Current Expression" },
    h = { "<Plug>RestNvim", "Test HTTP" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
    f = { "<cmd>lua require'dapui'.float_element()<cr>", "Current Elements" },
    o = { "<cmd>lua require'dap'.step_out()<cr>", "Step Over" },
    r = { "<cmd>lua require'dap'.repl_open()<cr>", "Open Repl" },
    s = { "<cmd>lua require'dap'.run()<cr>", "Start" }
  },
  g = {
    name = "+Git",
    j = { "<cmd>Gitsigns next_hunk<cr>", "Next Hunk" },
    k = { "<cmd>Gitsigns prev_hunk<cr>", "Prev Hunk" },
    p = { "<cmd>Gitsigns preview_hunk<cr>", "Preview Hunk" },
    r = { "<cmd>Gitsigns reset_hunk<cr>", "Reset Hunk" },
    R = { "<cmd>Gitsigns reset_buffer<cr>", "Reset Buffer" },
    s = { "<cmd>Gitsigns stage_hunk<cr>", "Stage Hunk" },
    u = { "<cmd>Gitsigns undo_stage_hunk<cr>", "Undo Stage Hunk" },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Neogit commit<cr>", "Commit changes" },
    C = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    g = { "<cmd>Neogit<cr>", "Git Window" },
    m = {
      name = "+Merge",
      t = { "<Plug>(MergetoolToggle)", "Merge Tool" },
      g = { "<cmd>diffget<cr>", "Get diff" },
      p = { "<cmd>diffput<cr>", "Put diff" }
    }
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
    a = { "<cmd>lua require('spectre').open_file_search()<cr>", "Replace file" },
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

