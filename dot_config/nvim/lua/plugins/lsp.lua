local handler_opts = {
  ["eslint"] = {
    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "json",
    },
  root_dir = function(filename, bufnr)
      local root =
        require("lspconfig").util.root_pattern(".eslintrc.json")(filename)
      return root
    end,
    on_attach = function(_, bufnr)
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          if vim.fn.exists(":EslintFixAll") > 0 then
            vim.cmd.EslintFixAll()
          end
        end,
      })
    end,
  },
  ["tailwindcss"] = {
    filetypes = { "html", "javascriptreact", "typescriptreact" },
  },
}

local function setup_handler(server_name)
  local opts = handler_opts[server_name] or {}
  opts.capabilities = require("cmp_nvim_lsp").default_capabilities()
  local handler_on_attach = opts.on_attach
  opts.on_attach = function(client, bufnr)
    if handler_on_attach then
      handler_on_attach(client, bufnr)
    end

    if client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.document_highlight()
        end,
      })
      vim.api.nvim_create_autocmd("CursorMoved", {
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end

  require("lspconfig")[server_name].setup(opts)
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = true,
      },
      {
        "folke/neodev.nvim",
        config = true,
      },
      {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {
          ensure_installed = {
            "lua-language-server",
            "typescript-language-server",
            "eslint-lsp",
            "css-lsp",
            "json-lsp",
            "prisma-language-server",
            "tailwindcss-language-server",
            "yaml-language-server",
            "gopls",
            "prettierd",
            "stylua",
          },
          auto_update = true,
        },
      },
    },
    config = function()
      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup({
        automatic_installation = true,
      })
      require("neodev").setup()
      mason_lspconfig.setup_handlers({
        setup_handler,
      })
    end,
  },
}
