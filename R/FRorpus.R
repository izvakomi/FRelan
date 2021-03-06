#' FRorpus Function
#'
#' This function launches Shiny app
#' @param corpus The corpus file
#' @keywords ELAN linguistics
#' @export
#' @examples
#'find_token(".+лаздор.?")

FRorpus <- function(corpus, c1 = "Before", c2 = "Token", c3 = "After", c4 = FALSE) {
require(shiny)
require(dplyr)

data <- corpus
# regex_eng <- read.delim("R/data/regex-eng.txt")

filtering <- function( regex, after, before, ignore){
        data <- data %>% dplyr::filter(grepl(regex, Token, perl = TRUE))
        data <- data %>% dplyr::filter(grepl(after, After, perl = TRUE))
        data <- data %>% dplyr::filter(grepl(before, Before, perl = TRUE))
        data <- data %>% dplyr::filter(! grepl(ignore, Token, perl = TRUE))
}

shinyApp(ui = fluidPage(theme = "bootstrap.css",
        navbarPage(
                title = 'FRorpus',
                        tabPanel('Concordances',

                                tags$head(tags$style(".table .alignRight {color: black; text-align:right;}")),
                                tags$head(tags$style(".table .alignCenter {color: blue; text-align:center;}")),
                                tags$head(tags$style(".table .alignLeft {color: black; text-align:left;}")),
# Create a new Row in the UI for selectInputs
                                fluidRow(
                                        column(3,
                                          textInput("text3", label = h4("Over left border:"), value = "^.+$")),
                                        column(3,
                                          textInput("text1", label = h4("Search tokens:"), value = "^.+$")),
                                        column(3,
                                          textInput("text2", label = h4("Over right border:"), value = "^.+$")),
                                        column(3,
                                          textInput("text4", label = h4("Ignore:"), value = "$nothing")),
# Create a new row for the table.
                                fluidRow(dataTableOutput(outputId="table")
                                                   ))
),

                        tabPanel('Information & Help',
                                 (fluidPage(
                                 h1("FRorpus application"),
                                 p(paste0("This corpus contains currently data from Kola Saami languages. It is intensively under development, but will offer easy access to this data.")),
                                 p("The regular expressions have to be used in the searches. They are Perl compatible.")
                                 ))
),
                        tabPanel('Contact',
                                (fluidPage(h1("Freiburg Research Group in Saami Studies")
                                           )))


                          )
                ),
server = function(input, output) {

        ###########################################################################
        ###### DATA TABLE #########################################################
        ###########################################################################

        # Filter data based on selections
        output$table <- renderDataTable({

                data <- filtering(input$text1, input$text2, input$text3, input$text4)
#                 if (nrow(data) == nrow(corpus)){
#                         regex_eng
#                 } else {
                 if (c4 == FALSE){
                data[,c(c1, c2, c3)] # dplyr::arrange(Token) %>% dplyr::select(columns)
                 } else {
                data[,c(c1, c2, c3, c4)]
                 }

        }, options = list(
                aoColumnDefs = list(
                        list(targets = c(0, 1, 2), searchable = FALSE),
                        list(sClass="alignRight", aTargets=c(0)),
                        list(sClass="alignCenter", aTargets=c(1)),
                        list(sClass="alignLeft", aTargets=c(2)),
                        list(sWidth=c("200px"), aTargets=c(0)),
                        list(sWidth=c("100px"), aTargets=c(1)),
                        list(sWidth=c("200px"), aTargets=c(2))
                ),
                searching = 0,  # global search box on/off
                lengthMenu = c(10, 50, 100),
                pageLength = 100)
        )
})
}
