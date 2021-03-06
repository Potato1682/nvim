local icons = require "nvim-nonicons"

require("which-key").setup {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true,
      suggestions = 20,
    },
  },
  icons = {
    breadcrumb = icons.get "chevron-right", -- symbol used in the command line area that shows your active key combo
    separator = icons.get "arrow-right", -- symbol used between a key and it's label
    group = "", -- symbol prepended to a group
  },
  window = {
    border = "single",
  },
  layout = {
    height = { min = 4, max = 25 },
    width = { min = 20, max = 50 },
    spacing = 3,
  },
  key_labels = { ["<space>"] = "SPC", ["<tab>"] = "TAB" },
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true,
  triggers = { "<leader>", "z", "<localleader>" },
}

local options = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local japanese_mappings = {
  ["q"] = "バッファーを閉じる",
  ["e"] = "エクスプローラー",
  ["f"] = "ファイルを検索",
  ["h"] = "検索ハイライトを切る",
  ["p"] = "プロジェクト",
  [";"] = "ダッシュボード",
  ["*"] = "ドキュメントを生成",
  ["T"] = { "<cmd>TodoTrouble<cr>", "TODO 一覧" },
  ["a"] = { "<cmd>UltestSummary<cr>", "テスト エクスプローラー" },
  ["r"] = { "<cmd>ToggleTerm<cr>", "端末" },
  ["v"] = { "<cmd>Vista!!<cr>", "シンボル リスト" },
  ["w"] = { "<cmd>lua require'dapui'.toggle()<cr>", "デバッグ インターフェース" },
  ["x"] = { "<cmd>TroubleToggle<cr>", "エラー一覧" },
  ["u"] = { "<cmd>UndotreeToggle<cr>", "ナビゲーター" },
  ["j"] = { "<cmd>DBUIToggle<cr>", "データベース エクスプローラー" },
  ["m"] = { "<Plug>MarkdownPreviewToggle", "Markdownのプレビューを切り替え" },
  c = {
    name = "+コンテナ",

    c = { "<cmd>DockerToolsToggle<cr>", "Docker ツール" },
    a = { "<cmd>AttachToContainer<cr>", "接続" },
    b = { "<cmd>BuildImage<cr>", "イメージをビルド" },
    s = { "<cmd>StartImage<cr>", "devcontainers.jsonからイメージを起動" },
  },
  C = {
    name = "+変換",

    c = {
      name = "+色",

      c = { "<Plug>ColorConvertCycle", "変換を切り替え" },
      h = { "<Plug>ColorConvertHEX", "HEXに変換"},
      r = { "<Plug>ColorConvertRGB", "RGBに変換"},
      s = { "<Plug>ColorConvertHSL", "HSLに変換"}
    }
  },
  d = {
    name = "+診断",

    t = { "<cmd>TroubleToggle<cr>", "エラー一覧" },
    w = { "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", "ワークスペース" },
    d = { "<cmd>TroubleToggle lsp_document_diagnostics<cr>", "ドキュメント内" },
    q = { "<cmd>TroubleToggle quickfix<cr>", "クイックフィックス" },
    l = { "<cmd>TroubleToggle loclist<cr>", "場所を検索" },
    r = { "<cmd>TroubleToggle lsp_references<cr>", "リファレンス" },
  },
  D = {
    name = "+デバッグ",

    b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "ブレークポイントを切り替え" },
    B = { "<cmd>Telescope dap list_breakpoints<cr>", "ブレークポイント一覧" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "コンティニュー" },
    d = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "カーソル位置まで実行" },
    e = { "<cmd>lua require'dapui'.eval()<cr>", "現在行を評価" },
    h = { "<Plug>RestNvim", "HTTP をテスト" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "ステップ イン" },
    f = { "<cmd>lua require'dapui'.float_element()", "フィールドを確認" },
    o = { "<cmd>lua require'dap'.step_over()<cr>", "ステップ オーバー" },
    O = { "<cmd>lua require'dap'.step_out()<cr>", "ステップ アウト" },
    r = { "<cmd>lua require'dap.repl'.open()<cr>", "Replを開く" },
    s = { "<cmd>lua require'dap'.run()<cr>", "開始" },
  },
  g = {
    name = "+Git",

    j = "次のHunk",
    k = "前のHunk",
    p = "Hunkをプレビュー",
    r = "Hunkをリセット",
    R = "バッファーをリセット",
    s = "Hunkをステージ",
    u = "Hunkのステージを戻す",
    o = { "<cmd>Telescope git_status<cr>", "変更済みファイルを開く" },
    b = { "<cmd>Telescope git_branches<cr>", "ブランチをチェックアウト" },
    c = { "<cmd>Neogit commit<cr>", "変更をコミット" },
    C = { "<cmd>Telescope git_commits<cr>", "コミットをチェックアウト" },
    g = { "<cmd>Neogit<cr>", "Git ウィンドウ" },
    m = {
      name = "+マージ",

      t = { "<Plug>(MergetoolToggle)", "マージ ツール" },
      g = { "<cmd>diffget<cr>", "リモートの変更を受け入れる" },
      p = { "<cmd>diffput<cr>", "ローカルの変更を適用" },
    },
  },
  l = {
    name = "+LSP",

    d = { "<cmd>Telescope lsp_document_diagnostics<cr>", "ドキュメント内を診断" },
    D = { "<cmd>Telescope lsp_workspace_diagnostics<cr>", "ワークスペースを診断" },
    f = { "<cmd>Neoformat<cr>", "フォーマット" },
    I = { "<cmd>LspInfo<cr>", "状態" },
    q = { "<cmd>Telescope quickfix<cr>", "クイックフィックス" },
    x = { "<cmd>cclose<cr>", "クイックフィックスを閉じる" },
    s = { "<cmd>LspDocumentSymbol<cr>", "ドキュメント内のシンボル" },
    S = { "<cmd>LspWorkspaceSymbol<cr>", "ワークスペースのシンボル" },
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
    t = { "<cmd>Telescope live_grep<cr>", "テキスト" },
  },
  S = {
    name = "+セッション",

    s = { "<cmd>SessionSave<cr>", "セッションを保存" },
    l = { "<cmd>SessionLoad<cr>", "セッションを開く" },
  },
  t = {
    name = "+テスト",

    a = { "<cmd>UltestAttach<cr>", "動作中のデバッグにアタッチ" },
    c = { "<cmd>UltestClear<cr>", "結果を消去" },
    d = { "<cmd>UltestDebug<cr>", "デバッグテストを開始" },
    D = { "<cmd>UltestDebugNearest<cr>", "近くのデバッグテストを開始" },
    t = { "<cmd>UltestSummary<cr>", "テスト エクスプローラー" },
    s = { "<cmd>UltestStop<cr>", "動作中のテストを停止" },
  },
  y = {
    name = "+Treesitter",

    s = "@parameter.innerをスワップ",
    S = "@parameter.outerをスワップ",
  },

  -- extras
  z = {
    name = "+Zen Mode",

    z = { "<cmd>ZenMode<cr>", "Zen モードを切り替え" },
  },
}

local mappings = {
  ["q"] = "Close Buffer",
  ["e"] = "Explorer",
  ["f"] = "Find File",
  ["h"] = "No Highlight",
  ["p"] = "Projects",
  ["*"] = "Generate document",
  ["T"] = { "<cmd>TodoTrouble<cr>", "Open TODOs" },
  ["a"] = { "<cmd>UltestSummary<cr>", "Test Explorer" },
  ["r"] = { "<cmd>ToggleTerm<cr>", "Terminal" },
  ["v"] = { "<cmd>Vista!!<cr>", "Symbol List" },
  ["w"] = { "<cmd>lua require'dapui'.toggle()<cr>", "Debug UI" },
  ["x"] = { "<cmd>TroubleToggle<cr>", "Error List" },
  ["u"] = { "<cmd>UndotreeToggle<cr>", "Undo Tree" },
  ["j"] = { "<cmd>DBUIToggle<cr>", "Database UI" },
  ["m"] = { "<Plug>MarkdownPreviewToggle", "Toggle markdown preview" },
  c = {
    name = "+Containers",

    c = { "<cmd>DockerToolsToggle<cr>", "Docker Tools" },
    a = { "<cmd>AttachToContainer<cr>", "Connect" },
    b = { "<cmd>BuildImage<cr>", "Build Image" },
    s = { "<cmd>StartImage<cr>", "Start Image from devcontainers.json" },
  },
  C = {
    name = "+Convert",

    c = {
      name = "+Colors",

      c = { "<Plug>ColorConvertCycle", "Cycle color conversion" },
      h = { "<Plug>ColorConvertHEX", "Convert to HEX"},
      r = { "<Plug>ColorConvertRGB", "Convert to RGB"},
      s = { "<Plug>ColorConvertHSL", "Convert to HSL"}
    }
  },
  d = {
    name = "+Diagnostics",

    t = { "<cmd>TroubleToggle<cr>", "Error List" },
    w = { "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", "workspace" },
    d = { "<cmd>TroubleToggle lsp_document_diagnostics<cr>", "document" },
    q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
    l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
    r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
  },
  D = {
    name = "+Debug",

    b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
    B = { "<cmd>Telescope dap list_breakpoints<cr>", "Breakpoints" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    d = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
    e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate Current Expression" },
    h = { "<Plug>RestNvim", "Test HTTP" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
    f = { "<cmd>lua require'dapui'.float_element()<cr>", "Current Elements" },
    o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
    O = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
    r = { "<cmd>lua require'dap.repl'.open()<cr>", "Open Repl" },
    s = { "<cmd>lua require'dap'.run()<cr>", "Start" },
  },
  g = {
    name = "+Git",

    j = "Next Hunk",
    k = "Prev Hunk",
    p = "Preview Hunk",
    r = "Reset Hunk",
    R = "Reset Buffer",
    s = "Stage Hunk",
    u = "Undo Stage Hunk",
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Neogit commit<cr>", "Commit changes" },
    C = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    g = { "<cmd>Neogit<cr>", "Git Window" },
    m = {
      name = "+Merge",

      t = { "<Plug>(MergetoolToggle)", "Merge Tool" },
      g = { "<cmd>diffget<cr>", "Get diff" },
      p = { "<cmd>diffput<cr>", "Put diff" },
    },
  },
  l = {
    name = "+LSP",

    a = "Code Action",
    d = { "<cmd>Telescope lsp_document_diagnostics<cr>", "Document Diagnostics" },
    D = { "<cmd>Telescope lsp_workspace_diagnostics<cr>", "Workspace Diagnostics" },
    f = { "<cmd>Neoformat<cr>", "Format" },
    I = { "<cmd>LspInfo<cr>", "Information" },
    q = { "<cmd>Telescope quickfix<cr>", "Quickfix" },
    x = { "<cmd>cclose<cr>", "Close Quickfix" },
    s = { "<cmd>LspDocumentSymbol<cr>", "Document Symbols" },
    S = { "<cmd>LspWorkspaceSymbol<cr>", "Workspace Symbols" },
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
    ["r"] = "Recent Files",
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    t = { "<cmd>Telescope live_grep<cr>", "Text" },
  },
  S = {
    name = "+Session",
    s = { "<cmd>SessionSave<cr>", "Save Session" },
    ["l"] = "Load Session",
  },
  t = {
    name = "+Test",

    a = { "<cmd>UltestAttach<cr>", "Attach to Running Debug" },
    c = { "<cmd>UltestClear<cr>", "Clear Results" },
    d = { "<cmd>UltestDebug<cr>", "Debug Current File" },
    D = { "<cmd>UltestDebugNearest<cr>", "Debug Nearest Position" },
    t = { "<cmd>UltestSummary<cr>", "Test Explorer" },
    s = { "<cmd>UltestStop<cr>", "Stop Running Test Jobs" },
  },
  y = {
    name = "+Treesitter",

    s = "swap @parameter.inner",
    S = "swap @parameter.outer",
  },

  -- extras
  z = { "<cmd>ZenMode<cr>", "Zen Mode" },
}

if O.japanese then
  require("which-key").register(japanese_mappings, options)
else
  require("which-key").register(mappings, options)
end
