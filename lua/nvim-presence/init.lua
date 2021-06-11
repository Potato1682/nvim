if O.japanese then
  require("presence"):setup {
    editing_text = "%s を編集中",
    file_explorer_text = "%s を確認中",
    git_commit_text = "変更をコミット中",
    plugin_manager_text = "プラグインを管理中",
    reading_text = "%s を読書中",
    workspace_text = "%s で作業中",
    line_number_text = "行 %s | ファイル %s"
  }
else
  require("presence"):setup()
end

