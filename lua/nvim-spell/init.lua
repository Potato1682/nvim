local ok, spellsitter = pcall(require, "spellsitter")

if not ok then
  return false
end

spellsitter.setup {
  hl = "SpellBad",
  captures = { "comment", "string" },
}

return true
