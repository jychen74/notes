## NanoPlot 安裝指令（WSL + micromamba）

在 WSL 下建立 nanoplot enviroment

```linux

mkdir -p ~/bioenvs

micromamba create -y -p ~/bioenvs/nanoplot \
  -c conda-forge -c bioconda nanoplot matplotlib

```
