## Export extension list

```
positron --lis-extensions > "$HOME\Desktop\extensions_list.txt"

```

- 會在桌面產生一個文字檔

## Install extensions from a list

- 可以把 extension list 放在桌面上
- [Download current list](folder/extensions_list_20260213)

```
Get-Content "$HOME\Desktop\extensions_list.txt" | ForEach-Object { positron --install-extension $_ }

```

- Current extensions
  - [0xtanzim.filetree-pro](https://github.com/0xTanzim/filetree-pro)
  - [arianjamasb.protein-viewer](https://github.com/molstar/VSCoding-Sequence)
  - [carlocardella.vscode-virtualrepos](https://github.com/carlocardella/vscode-VirtualRepos)
  - [charliermarsh.ruff](https://github.com/astral-sh/ruff-vscode)
  - [cweijan.vscode-office](https://github.com/cweijan/vscode-office)
  - [esbenp.prettier-vscode](https://github.com/prettier/prettier-vscode)
  - [github.vscode-github-actions](https://github.com/github/vscode-github-actions.git)
  - [github.vscode-pull-request-github](https://github.com/github/vscode-github-actions.git)
  - [meta.pyrefly](https://github.com/facebook/pyrefly.git)
  - [ms-python.debugpy](https://github.com/microsoft/vscode-python-debugger.git)
  - [ms-toolsai.jupyter](https://github.com/Microsoft/vscode-jupyter.git)
  - [ms-toolsai.jupyter-keymap](https://github.com/Microsoft/vscode-jupyter-keymap.git)
  - [ms-toolsai.vscode-jupyter-cell-tags](https://github.com/Microsoft/vscode-jupyter-cell-tags.git)
  - [ms-toolsai.vscode-jupyter-slideshow](https://github.com/Microsoft/vscode-jupyter-slideshow.git)
  - [posit.air-vscode](https://github.com/posit-dev/air)
  - [posit.publisher](https://github.com/posit-dev/publisher)
  - [posit.shiny](https://github.com/posit-dev/shiny-vscode)
  - [quarto.quarto](https://github.com/quarto-dev/quarto.git)
  - [reageyao.biosyntax](https://github.com/liyao001/bioSyntax.git)
  - [redhat.vscode-yaml](https://github.com/redhat-developer/vscode-yaml.git)
  - [shuuul.bioviewer](https://github.com/shuuul/bioviewer.git)
  - [tomoki1207.pdf](https://github.com/tomoki1207/vscode-pdfviewer.git)
  - [yzhang.markdown-all-in-one](https://github.com/yzhang-gh/vscode-markdown.git)
