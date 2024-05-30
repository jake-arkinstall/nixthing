{
  plugins.nix.enable = true;
  plugins.tagbar.enable = true;
  plugins.lualine.enable = true;
  plugins.nvim-tree = {
    enable = true;
    openOnSetup = true;
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
}
