{ config, pkgs, ... }:
let
  toLua = str: ''
    lua << EOF
    ${str}
    EOF
  '';
  toLuaFile = file: ''
    lua << EOF
    ${builtins.readFile file}
    EOF
  '';
in {
  home.packages = with pkgs; [
    lua-language-server
    rnix-lsp

    # Nix formatter
    nixfmt

    xclip
    wl-clipboard
  ];

  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      # Git
      vim-fugitive
      vim-rhubarb

      # Detect tabstop and shiftwidth automatically
      vim-sleuth

      # Theme
      {
        plugin = catppuccin-nvim;
        config = "colorscheme catppuccin-mocha";
      }

      # LSP config
      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./plugins/lsp.lua;
      }

      # Additional lua configuration, makes nvim stuff amazing!
      neodev-nvim

      # Autocomplete
      {
        plugin = nvim-cmp;
        config = toLuaFile ./plugins/cmp.lua;
      }
      # Snippet Engine & its associated nvim-cmp source
      luasnip
      cmp_luasnip

      # Adds LSP completion capabilities to autocomplete
      cmp-nvim-lsp

      # Adds a number of user-friendly snippets
      friendly-snippets

      # Show you pending keybinds
      which-key-nvim

      # Statusbar
      {
        plugin = lualine-nvim;
        config = toLuaFile ./plugins/lualine.lua;
      }
      nvim-web-devicons

      # Add indentation guides even on blank lines
      {
        plugin = indent-blankline-nvim;
        config = toLua "require('indent_blankline').setup()";
      }

      # Fuzzy Finder (files, lsp, etc)
      {
        plugin = telescope-nvim;
        config = toLuaFile ./plugins/telescope.lua;
      }
      telescope-fzf-native-nvim

      # Highlight, edit, and navigate code
      {
        plugin = nvim-treesitter.withAllGrammars;
        config = toLuaFile ./plugins/treesitter.lua;
      }

      # Better support for nix files
      vim-nix

    ];

    extraLuaConfig = ''
      ${builtins.readFile ./options.lua}
    '';
  };

}
