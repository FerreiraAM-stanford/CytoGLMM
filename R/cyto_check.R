#' Check if input to cytoxxx function have errors
#'
cyto_check = function(cell_n_subsample,
                       cell_n_min,
                       protein_names) {

  if(cell_n_subsample > cell_n_min) stop("cell_n_subsample is larger than cell_n_min")
  if(sum(str_detect(protein_names,"/")) > 0) stop("protein names cannot contain '/'")
  starts_with_number = sapply(protein_names,
                              function(x) str_locate(x, "[0-9]")[1] == 1)
  if(sum(starts_with_number,na.rm = TRUE) > 0) stop("protein names cannot start with numbers")
  if(sum(make.names(protein_names) != protein_names) > 0)
    stop("cleanup your protein names (don't use special characters)")

}
