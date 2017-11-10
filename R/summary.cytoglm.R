#' Extact and plot noise term
#'
#' @import ggplot2
#' @import tibble
#' @import magrittr
#' @import dplyr
#' @import cowplot
#' @export
#'
summary.cytoglm = function(fit) {

  if(class(fit) != "cytoglm")
    stop("Input needs to be a cytoglm object computed by cytoglm function.")

  cat("\n#######################\n")
  if(fit$unpaired)  {
    cat("## unpaired anlaysis ##")
  } else {
    cat("## paired analysis ####")
  }
  cat("\n#######################\n\n")
  cat("number of bootstrap samples:",fit$num_boot,"\n\n")
  cat("number of cells per donor table:")
  cell_count = table(fit$df_samples_subset$donor,pull(fit$df_samples_subset,fit$condition))
  print(cell_count)

  cat("\nproteins included in the analysis:\n",fit$protein_names,"\n\n")
  cat("condition compared:",fit$condition,"\n")

}