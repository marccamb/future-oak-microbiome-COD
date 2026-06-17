#' Generate a Summary Table for phyloseq Objects
#'
#' @description
#' Creates a summary table containing key statistics about a phyloseq object,
#' including sample and ASV (Amplicon Sequence Variant) counts, and sequencing
#' depth metrics.
#'
#' @param ps A phyloseq object to summarize
#' @param name A character string to use as the row name in the output table
#'
#' @details
#' The function performs the following operations:
#' \itemize{
#'   \item Counts the total number of samples in the phyloseq object
#'   \item Removes taxa with zero total counts
#'   \item Counts the remaining number of ASVs (taxa)
#'   \item Calculates sequencing depth statistics across samples
#' }
#'
#' The sequencing depth metrics include mean, standard deviation, and quantiles
#' (0%, 25%, 50%, 75%, 100%) of read counts per sample, providing a comprehensive
#' overview of sequencing effort variation across the dataset.
#'
#' @return
#' A data frame with one row (named according to the `name` parameter) and eight columns:
#' \describe{
#'   \item{Nb sample}{Total number of samples}
#'   \item{Nb ASVs}{Total number of ASVs after removing zero-count taxa}
#'   \item{Mean reads per sample}{Mean sequencing depth}
#'   \item{Min reads per sample}{Minimum sequencing depth (0th percentile)}
#'   \item{1st quartile reads per sample}{25th percentile of sequencing depth}
#'   \item{Median reads per sample}{Median sequencing depth (50th percentile)}
#'   \item{3rd quartile reads per sample}{75th percentile of sequencing depth}
#'   \item{Max reads per sample}{Maximum sequencing depth (100th percentile)}
#' }
#'
#' @examples
#' \dontrun{
#' # Assuming you have a phyloseq object called 'ps_data'
#' summary_table <- phyloseq_summary_table(ps_data, name = "Dataset1")
#' summary_table
#' }
#'
#' @seealso
#' \code{\link[phyloseq]{nsamples}}, \code{\link[phyloseq]{ntaxa}},
#' \code{\link[phyloseq]{sample_sums}}, \code{\link[phyloseq]{prune_taxa}}
#'
#' @importFrom phyloseq nsamples ntaxa sample_sums prune_taxa taxa_sums
#'
#' @export

phyloseq_summary_table <- function(ps, name) {
  # Basic dimensions
  n_samples <- phyloseq::nsamples(ps)
  ps <- prune_taxa(taxa_sums(ps) > 0, ps)
  n_taxa    <- phyloseq::ntaxa(ps)
  # # Sequencing depth
  sample_sums <- phyloseq::sample_sums(ps)
  sample_sums_quantile <- quantile(sample_sums)
  sample_sums_mean <- mean(sample_sums)
  sample_sums_sd <- sd(sample_sums)

  # Build table
  df <- data.frame(
    "Nb sample" = n_samples,
    "Nb ASVs" = n_taxa,
    "Mean reads per sample" = sample_sums_mean,
    "Min reads per sample" = sample_sums_quantile['0%'],
    "1st quartile reads per sample" = sample_sums_quantile['25%'],
    "Median reads per sample" = sample_sums_quantile['50%'],
    "3rd quartile reads per sample" = sample_sums_quantile['75%'],
    "Max reads per sample" = sample_sums_quantile['100%'],
    row.names = name,
    stringsAsFactors = FALSE
  )
  return(df)
  #print(knitr::kable(df))
}