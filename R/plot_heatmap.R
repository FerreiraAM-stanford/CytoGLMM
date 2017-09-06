#' Heatmap of median marker expression.
#'
#' @import dplyr
#' @import magrittr
#' @import pheatmap
#' @import RColorBrewer
#' @export
#'
plot_heatmap = function(df_samples,
                        sample_info_names,
                        protein_names,
                        arrange_by_1,
                        arrange_by_2 = "",
                        rownames) {
    expr_median = df_samples %>%
      group_by(.dots = sample_info_names) %>%
      summarise_at(protein_names,median) %>%
      arrange_(arrange_by_1)
    if(nchar(arrange_by_2) > 0) expr_median %<>% arrange_(arrange_by_2)
    df_expr_median = as.data.frame(expr_median[,protein_names])
    rownames(df_expr_median) = pull(expr_median,rownames)
    col_names = arrange_by_1
    if(nchar(arrange_by_2) > 0) col_names = c(arrange_by_1,arrange_by_2)
    df_annotation = data.frame(expr_median[,col_names])
    rownames(df_annotation) = pull(expr_median,rownames)
    color = colorRampPalette(brewer.pal(n = 9, name = "YlGnBu"))(100)
    pheatmap(t(df_expr_median),
             color = color,
             clustering_method = "average",
             show_colnames = FALSE,
             cluster_cols = FALSE,
             cluster_rows = TRUE,
             annotation_col = df_annotation)
}