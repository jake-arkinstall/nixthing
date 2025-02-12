{
  plugins.nix.enable = true;
  plugins.tagbar.enable = true;
  plugins.lualine.enable = true;
  plugins.fugitive.enable = true;
  plugins.gitgutter.enable = true;
  plugins.rustaceanvim.enable = true;
  plugins.web-devicons.enable = true;
  /*
  plugins.lsp = {
    enable = true;
    inlayHints = true;
    servers = {
      pylsp.enable = true;
    };
  };
  */

#  significant performance degredation:
#  plugins.treesitter.enable = true;
#  plugins.treesitter-context.enable = true;
  plugins.nvim-tree = {
    enable = true;
    openOnSetup = true;
    openOnSetupFile = true;
    onAttach = {
      __raw = ''
        function(bufnr)
          local api = require("nvim-tree.api")
          local function opts(desc)
            return { buffer = bufnr, noremap = true, silent = true, nowait = true, desc = desc }
          end
          api.config.mappings.default_on_attach(bufnr)
          vim.keymap.set("n", "s", api.node.open.vertical, opts('Open: Vertical Split'))
          vim.keymap.set("n", "i", api.node.open.horizontal, opts('Open: Horizontal Split'))
          vim.keymap.set("n", "t", api.node.open.tab, opts('Open: Tab'))
        end
      '';
    };
  };
  plugins.telescope = {
    enable = true;
    extensions = {
        fzf-native.enable = true;
    };
    keymaps = {
        "<leader>fg" = "live_grep";
        "<leader>fz" = "find_files";
    };
  };

  /* Avoid rust-analyser locking the build dir */
  /* seems buggy 
  extraConfigLuaPost = ''
    require('lspconfig').rust_analyzer.setup{
      settings = {
        ["rust-analyzer"] = {
          server = {
            extraEnv = {
              CARGO_TARGET_DIR = "/tmp/rust-analyser"
            },
          },
        },
      },
    }
  '';
  */
}
