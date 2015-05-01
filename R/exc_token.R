#' exc_token Function
#'
#' This function is equivalent to `filter(! grepl("regex", Token))`
#' @param regex This is a regex one searches wants to exclude
#' @keywords ELAN linguistics
#' @export
#' @examples
#'find_token(".+лаздор.?")

exc_token <- function(corpus = corpus, regex = "чолӧм") {
        corpus %>% dplyr::filter(! grepl(regex, Token))
}
