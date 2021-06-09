local container = require("lspcontainers")

local lspconfig = require("lspconfig")

lspconfig.terraformls.setup {
  cmd = container.command("terraformls"),
  filetypes = { "hcl", "tf", "terraform", "tfvars" }
}

-- from docker image
lspconfig.tflint.setup {
  cmd = { "docker", "container", "run", "--interactive", "--rm", "--volume", vim.fn.getcwd() .. ":/data", "--image", "wata727/tflint", "--langserver"  }
}

