## NanoPlot 安裝指令（WSL + micromamba）

在 WSL 下建立 nanoplot enviroment

```bash

mkdir -p ~/bioenvs

micromamba create -y -p ~/bioenvs/nanoplot \
  -c conda-forge -c bioconda nanoplot matplotlib

```

> 加上 matplotlib 是為了避免之後 Python 繪圖依賴缺失。

## 啟用 Nanoplot

```bash

micromamba activate

micromamba activate ~/bioenvs/nanoplot

NanoPlot --version #注意大小寫有差

```
