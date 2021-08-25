 require("hclipboard").setup {
  should_bypass_cb = function(regname, ev)
    local ret = false

    if ev.visual and (ev.operator == 'd' or ev.operator == 'c') then
        if ev.regname == '' or ev.regname == regname then
            ret = true
        end
    end

    return ret
  end
}
