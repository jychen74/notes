## NanoPlot 安裝指令（WSL + micromamba）

在 WSL 下建立 nanoplot enviroment

```bash

mkdir -p ~/bioenvs

micromamba create -y -p ~/bioenvs/nanoplot \
  -c conda-forge -c bioconda nanoplot matplotlib

```

> 加上 matplotlib 是為了避免之後 Python 繪圖依賴缺失。

## 裝好後啟用 Nanoplot

```bash

micromamba activate

micromamba activate ~/bioenvs/nanoplot

NanoPlot --version #注意大小寫有差

```

## 正確啟動與使用環境

- 開 WSL 的標準流程

```bash

wsl
cd ~
micromamba activate ~/bioenvs/nanoplot

```

- 確認目前在 Linux home：

```bash

pwd
# 應顯示 /home/epi2mewsl

```

- 不要在 /mnt/c/... 下跑分析，會跑到懷疑人生

## 預計資料夾結構

```bash

~/nanopore/
├── runs/
│   └── < 自定名稱 >/
│       ├── raw/
│       │   ├── sequencing_summary_*.txt
│       │   ├── fastq_pass/
│       │   └── pod5/
│       ├── qc/
│       │   ├── nanoplot/
│       │   └── custom_r/
│       └── notes/
├── ref/
├── analysis/
│   ├── host_depletion/
│   ├── metagenomics/
│   └── assembly/
└── bioenvs/

```

原則：  
 raw = 原始資料  
 qc = QC 結果  
 analysis = 下游分析  
 notes = 記錄 run 設定
