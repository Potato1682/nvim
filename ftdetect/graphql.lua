local commands = {
  gqldetect = {
    { "BufNewFile,BufRead", "*.graphql", "setfiletype graphql" },
    { "BufNewFile,BufRead", "*.graphqls", "setfiletype graphql" },
    { "BufNewFile,BufRead", "*.gql", "setfiletype graphql" },
  },
}

require("events").nvim_create_augroups(commands)
