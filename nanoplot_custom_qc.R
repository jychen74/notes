## ONT QC Custom Script
#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  library(data.table)
  library(ggplot2)
  library(scales)
  library(hexbin)
})

args <- commandArgs(trailingOnly = TRUE)

if (length(args) != 1) {
  stop("Usage: Rscript ont_qc_custom.R sequencing_summary.txt")
}

input_file <- args[1]

if (!file.exists(input_file)) {
  stop("Input file not found.")
}

cat("Reading sequencing summary...\n")

# Detect column names first
header <- fread(input_file, nrows = 0)
cols <- names(header)

# Common Dorado / MinKNOW names
len_col <- grep("sequence_length", cols, value = TRUE)[1]
q_col <- grep("mean_qscore", cols, value = TRUE)[1]
time_col <- grep("start_time", cols, value = TRUE)[1]

if (is.na(len_col) | is.na(q_col)) {
  stop("Cannot detect required columns.")
}

dt <- fread(
  input_file,
  select = c(len_col, q_col, time_col),
  showProgress = TRUE
)

setnames(dt, c("len", "q", "t_start")[1:ncol(dt)])

dt <- dt[!is.na(len) & !is.na(q)]
dt[, len := as.numeric(len)]
dt[, q := as.numeric(q)]

if ("t_start" %in% names(dt)) {
  dt[, t_start := as.numeric(t_start)]
}

# Output directory
run_dir <- dirname(dirname(input_file))
outdir <- file.path(run_dir, "qc", "custom_r")
dir.create(outdir, recursive = TRUE, showWarnings = FALSE)

cat("Generating plots...\n")

# -------------------------
# Length Distribution
# -------------------------
p_len <- ggplot(dt, aes(x = len)) +
  geom_histogram(bins = 200, fill = "#2c7fb8", color = "white") +
  scale_x_log10(labels = comma) +
  labs(
    title = "Read Length Distribution",
    x = "Read length (bp, log10 scale)",
    y = "Read count"
  ) +
  theme_classic(base_size = 14)

ggsave(
  file.path(outdir, "length_distribution_log10.png"),
  p_len,
  width = 8,
  height = 5,
  dpi = 300
)

# -------------------------
# Q score Distribution
# -------------------------
p_q <- ggplot(dt, aes(x = q)) +
  geom_histogram(bins = 100, fill = "#f03b20", color = "white") +
  labs(title = "Q Score Distribution", x = "Mean Q score", y = "Read count") +
  theme_classic(base_size = 14)

ggsave(
  file.path(outdir, "qscore_distribution.png"),
  p_q,
  width = 8,
  height = 5,
  dpi = 300
)

# -------------------------
# Length vs Q (Hexbin)
# -------------------------
set.seed(1)
n <- min(nrow(dt), 500000)
dt_sample <- dt[sample(.N, n)]

p_lq <- ggplot(dt_sample, aes(x = len, y = q)) +
  stat_binhex(bins = 80) +
  scale_x_log10(labels = comma) +
  scale_fill_viridis_c() +
  labs(
    title = "Length vs Q Score (Hexbin)",
    x = "Read length (bp, log10 scale)",
    y = "Mean Q score",
    fill = "Count"
  ) +
  theme_classic(base_size = 14)

ggsave(
  file.path(outdir, "length_vs_q_hexbin.png"),
  p_lq,
  width = 8,
  height = 5,
  dpi = 300
)

# -------------------------
# Yield over time (10 min bins)
# -------------------------
if ("t_start" %in% names(dt)) {
  dt[, t_min := t_start / 60]
  dt[, bin10 := floor(t_min / 10) * 10]
  yield10 <- dt[, .(yield_bp = sum(len)), by = bin10][order(bin10)]
  yield10[, yield_gb := yield_bp / 1e9]

  p_yield <- ggplot(yield10, aes(x = bin10, y = yield_gb)) +
    geom_col(fill = "#41ab5d") +
    labs(
      title = "Yield per 10 Minutes",
      x = "Time (minutes)",
      y = "Yield (Gb)"
    ) +
    theme_classic(base_size = 14)

  ggsave(
    file.path(outdir, "yield_per_10min.png"),
    p_yield,
    width = 9,
    height = 5,
    dpi = 300
  )

  yield10[, cum_gb := cumsum(yield_gb)]

  p_cum <- ggplot(yield10, aes(x = bin10, y = cum_gb)) +
    geom_line(size = 1) +
    labs(
      title = "Cumulative Yield",
      x = "Time (minutes)",
      y = "Cumulative yield (Gb)"
    ) +
    theme_classic(base_size = 14)

  ggsave(
    file.path(outdir, "cumulative_yield.png"),
    p_cum,
    width = 9,
    height = 5,
    dpi = 300
  )
}

# -------------------------
# QC Summary stats
# -------------------------
cat("Calculating summary stats...\n")

len_sorted <- sort(dt$len, decreasing = TRUE)
cs <- cumsum(len_sorted)
n50 <- len_sorted[min(which(cs >= sum(len_sorted) / 2))]

summary_tbl <- data.table(
  reads = nrow(dt),
  yield_gb = sum(dt$len) / 1e9,
  mean_len = mean(dt$len),
  median_len = median(dt$len),
  mean_q = mean(dt$q),
  median_q = median(dt$q),
  N50 = n50
)

fwrite(summary_tbl, file.path(outdir, "qc_summary.tsv"), sep = "\t")

cat("QC completed.\n")
cat("Output directory:", outdir, "\n")
