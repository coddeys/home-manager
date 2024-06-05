{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;

    extraConfig = ''
      syntax on
      filetype plugin indent on

      set nocompatible
      set number
      set showmode
      set smartcase
      set smarttab
      set smartindent
      set autoindent
      set expandtab
      set shiftwidth=2
      set softtabstop=2
      set laststatus=0

      hi Constant ctermfg=5*
      hi Comment ctermfg=2*
      hi Normal ctermbg=none
      set mouse=a

      let g:haskell_classic_highlighting = 1
      let g:haskell_indent_if = 3
      let g:haskell_indent_case = 2
      let g:haskell_indent_let = 4
      let g:haskell_indent_where = 6
      let g:haskell_indent_before_where = 2
      let g:haskell_indent_after_bare_where = 2
      let g:haskell_indent_do = 3
      let g:haskell_indent_in = 1
      let g:haskell_indent_guard = 2
      let g:haskell_indent_case_alternative = 1
      let g:cabal_indent_section = 2

    '';

    plugins = with pkgs.vimPlugins; [
      ctrlp
      editorconfig-vim
      gruvbox-community
      vim-nix
      fzf-vim
      haskell-vim
    ];

  };
}
