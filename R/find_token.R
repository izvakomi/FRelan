#' find_token Function
#'
#' This function is equivalent to `filter(grepl("regex", Token))`
#' @param regex This is a regex one searches with
#' @keywords ELAN linguistics
#' @export
#' @examples
#'find_token(".+лаздор.?")

find_token <- function(corpus = corpus, regex = "чолӧм") {
        corpus %>% dplyr::filter(grepl(regex, Token))
}
