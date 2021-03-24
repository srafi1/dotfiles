#! /bin/bash

# Install language servers to be used in Neovim

for lsp in $@; do
    case $lsp in
        pyright|python)
            yay -S --noconfirm pyright
            ;;
        ccls|c|cpp)
            yay -S --noconfirm ccls
            ;;
        texlab|tex|latex)
            yay -S --noconfirm texlab
            ;;
        tsserver|javascript|js|ts)
            yarn global add typescript typescript-language-server
            ;;
        bashls|bash)
            yarn global add bash-language-server
            ;;
        cssls|css)
            yarn global add vscode-css-languageserver-bin
            ;;
        dockerls|docker)
            yarn global add dockerfile-language-server-nodejs
            ;;
        html)
            yarn global add vscode-html-languageserver-bin
            ;;
        vimls|vim)
            yarn global add vim-language-server
            ;;
        gopls|go|golang)
            yay -S --noconfirm gopls
            ;;
        sumneko_lua|lua)
            yay -S --noconfirm lua-language-server-git
            ;;
        jdtls|java)
            yay -S --noconfirm jdtls
            ;;
    esac
done
