## Export extension list

```
positron --lis-extensions > "$HOME\Desktop\extensions_list.txt"

```

- 會在桌面產生一個文字檔

## Install extensions from a list

- 可以把 extension list 放在桌面上

```
Get-Content "$HOME\Desktop\extensions_list.txt" | ForEach-Object { positron --install-extension $_ }

```

- Current extensions
  - [0xtanzim.filetree-pro](https://github.com/0xTanzim/filetree-pro)
  - [arianjamasb.protein-viewer](https://github.com/molstar/VSCoding-Sequence)
  - carlocardella.vscode-virtualrepos
  - charliermarsh.ruff
  - cweijan.vscode-office
  - esbenp.prettier-vscode
  - github.vscode-github-actions
  - github.vscode-pull-request-github
  - meta.pyrefly
  - ms-python.debugpy
  - ms-toolsai.jupyter
  - ms-toolsai.jupyter-keymap
  - ms-toolsai.vscode-jupyter-cell-tags
  - ms-toolsai.vscode-jupyter-slideshow
  - posit.air-vscode
  - posit.publisher
  - posit.shiny
  - quarto.quarto
  - reageyao.biosyntax
  - redhat.vscode-yaml
  - shuuul.bioviewer
  - tomoki1207.pdf
  - yzhang.markdown-all-in-one
