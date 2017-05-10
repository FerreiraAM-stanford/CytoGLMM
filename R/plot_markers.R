#' Plot all markers for one donor.
#'
#' @import ggplot2
#' @import reshape2
#' @export
#'
plot_markers <- function(df_samples,
                        donor_id,
                        protein_names,
                        density = TRUE) {
  df_samples_subset = subset(df_samples,donor == donor_id)
  df_samples_subset = data.frame(df_samples_subset[,protein_names],
                                 condition = df_samples_subset$condition)
  df_samples_subset_long = melt(df_samples_subset,id = "condition")
  if(density) {
    ggplot(df_samples_subset_long,aes(x = value,y = ..scaled..,color = condition)) +
      geom_density() +
      facet_wrap(~ variable,ncol = 8) +
      ggtitle(donor_id) +
      xlab("arcsinh transformed counts")
  } else {
    ggplot(df_samples_subset_long,aes(x = value,fill = condition)) +
      geom_histogram(binwidth=.2, alpha=.5, position="identity") +
      facet_wrap(~ variable,ncol = 8) +
      ggtitle(donor_id) +
      xlab("arcsinh transformed counts")
  }
}