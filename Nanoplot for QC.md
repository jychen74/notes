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
│   └── < 自定資料夾名稱 >/
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

- 原則：
  - raw = 原始資料
  - qc = QC 結果
  - analysis = 下游分析
  - notes = 記錄 run 設定

## 如何 run NanoPlot + QC 報告整理方式

- 把 sequence summary.txt 檔搬到 raw 資料夾
- 指令

```bash

cd ~/nanopore/runs/ < 自定資料夾名稱 >

mkdir -p qc/nanoplot

NanoPlot \
  --summary raw/sequencing_summary.txt \
  --outdir qc/nanoplot \
  --threads 16 \
  --loglength \
  --tsv_stats

```

## 產出資料

```bash
qc/nanoplot/
├── NanoPlot-report.html
├── length_distribution.png
├── quality_distribution.png
├── cumulative_yield.png
├── bivariate_plots.png
└── summary_stats.tsv
```

### length_distribution

- 是否有大量短 reads (adaptive sampling 截斷)
- 長尾是否存在
- 是否偏短（DNA 斷裂）

### quality_distribution

- Q 值是否集中在 Q10–Q20
- 是否有低品質尾端

### cumulative_yield

- 產量是否線性增加
- 是否中途掉速 (flowcell exhaustion)

### bivariate (Length vs Q)

- 長讀長是否伴隨高 Q
- adaptive sampling 是否影響 read quality

## 報告整理

###　每個 run 建一個 QC README.md

```
qc/
├── nanoplot/
│   ├── NanoPlot-report.html
│   ├── summary_stats.tsv
│   └── figures...
└── QC_summary.md
```

### QC_summary.md 建議內容

```
# Run QC Summary

Run ID:
Flowcell:
Basecalling model:
Adaptive sampling:

## Yield
Total yield: X Gb
Read count: X
N50: X bp

## Observations
- Length distribution shows...
- Q score distribution indicates...
- Adaptive depletion appears...

```

## R 自定圖表

### Read data

A) 讀 sequencing_summary

- 用 data.table::fread()（大檔快很多）

B) 產生：

- 自定 length histogram（log10 + 自定範圍）
- Length vs Q（用 hexbin，不會黑成一坨）
- Yield over time
- 自訂主題（theme_classic + 字體）

C) R script location

- the [R scripts]()

```
~/nanopore/scripts/
    nanoplot_custom_qc.R
```

- eahc run

```
qc/custom_r/
    length_hist.png
    length_vs_q_hex.png
    qc_summary.tsv
```
