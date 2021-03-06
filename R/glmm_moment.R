#' Generalized linear mixed model with maximum likelihood.
#'
#' @import mbest
#' @import doParallel
#' @import dplyr
#' @export
#'
glmm_moment = function(df_samples,
                       protein_names,
                       response,
                       group = "donor",
                       covariate_names = NULL,
                       cores = detectCores()) {
  registerDoParallel(cores = cores)
  markers_str = paste0(c(protein_names,covariate_names),collapse = " + ")
  formula_expr = NULL
  if( is.factor(pull(df_samples,response)) ) {
    formula_expr = parse(text = paste0("mhglm(",
                                       paste(response,"~",markers_str,"+",paste0("(",markers_str," | ",group,"),")),
                                       "family = binomial(link='logit'),",
                                       "data = df_samples,",
                                       "control = mhglm.control(parallel = TRUE,fit.method = 'firthglm.fit'))"))
  } else {
    formula_expr = parse(text = paste0("mhglm(",
                                       paste(response,"~",markers_str,"+",paste0("(",markers_str," | ",group,"),")),
                                       "family = gaussian(link = 'identity'),",
                                       "data = df_samples,",
                                       "control = mhglm.control(parallel = TRUE,fit.method = 'firthglm.fit'))"))
  }
  eval(formula_expr)
}
