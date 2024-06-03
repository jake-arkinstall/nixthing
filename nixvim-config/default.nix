{ enable-copilot ? true }:
{
  imports = [ ./plugins.nix ];
  config = {
    plugins.copilot-vim.enable = enable-copilot;
    colorschemes = {
      nightfox = {enable = true; flavor = "carbonfox";};
    };
    globals.mapleader = ",";
    keymaps = [
      { key = "<leader>t"; mode = "n"; action = ":TagbarToggle<CR>"; }
      { key = "Y"; mode = "n"; action = "yy"; }
    ];
    opts = {
      swapfile = false;
      number = true;
      expandtab = true;
      tabstop = 4;
      shiftwidth = 4;
      splitbelow = true;
      splitright = true;
      wrap = false;
      clipboard = "unnamedplus";
      autoread = true;
      mouse = "a";
    };
  };
}
