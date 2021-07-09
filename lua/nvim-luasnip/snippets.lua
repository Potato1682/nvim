local luasnip = require "luasnip"

local s = luasnip.snippet
local sn = luasnip.snippet_node
local t = luasnip.text_node
local i = luasnip.insert_node
local c = luasnip.choice_node

luasnip.snippets = {
  all = {},
  lua = {
    s("module", {
      t "local M = {}",
      t { "", "", "" },
      t "function M.",
      i(1),
      t "(",
      i(2),
      t ")",
      t { "", "\t" },
      i(0),
      t { "", "end" },
      t { "", "", "" },
      t "return M",
    }),
  },
  java = {
    s("class", {
      c(1, {
        t "public ",
        t "private ",
      }),
      t "class ",
      i(2),
      t " ",
      c(3, {
        t "{",
        sn(nil, {
          t "extends ",
          i(1),
          t " {",
        }),
        sn(nil, {
          t "implements ",
          i(1),
          t " {",
        }),
      }),
      t { "", "\t" },
      i(0),
      t { "", "}" },
    }),
    s("class-allman", {
      c(1, {
        t "public ",
        t "private ",
      }),
      t "class ",
      i(2),
      t " ",
      c(3, {
        t "",
        sn(nil, {
          t "extends ",
          i(1),
        }),
        sn(nil, {
          t "implements ",
          i(1),
        }),
      }),
      t { "", "{" },
      t { "", "\t" },
      i(0),
      t { "", "}" },
    }),
    s("fn", {
      c(1, {
        t "public ",
        t "private ",
      }),
      c(2, {
        t "void",
        i(nil, { "" }),
        t "String",
        t "char",
        t "int",
        t "double",
        t "boolean",
      }),
      t " ",
      i(3),
      t "(",
      i(4),
      t ")",
      c(5, {
        t "",
        sn(nil, {
          t { "", " throws " },
          i(1),
        }),
      }),
      t { " {", "\t" },
      i(0),
      t { "", "}" },
    }),
    s("fn-allman", {
      c(1, {
        t "public ",
        t "private ",
      }),
      c(2, {
        t "void",
        i(nil, { "" }),
        t "String",
        t "char",
        t "int",
        t "double",
        t "boolean",
      }),
      t " ",
      i(3),
      t "(",
      i(4),
      t ")",
      c(5, {
        t "",
        sn(nil, {
          t { "", " throws " },
          i(1),
        }),
      }),
      t { "", " {", "", "\t" },
      i(0),
      t { "", "}" },
    }),
  },
}
