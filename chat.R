library(shiny)
library(shiny.collections)
library(purrr)
library(dplyr)
library(purrrlyr)


ui <- shinyUI(fluidPage(
  titlePanel("Cooper the Chatbot (MA COVID-19 support)"),
  div(textInput("name_field", "Name", width = "200px")),
  uiOutput("chatbox"),
  div(textInput("email_field", "Email", width = "200px")),
  uiOutput("chatbox"),
  div(style = "display:inline-block",
      textInput("message_field", "Your question", width = "500px")),
  div(style = "display:inline-block",
      actionButton("chat", "Ask Cooper")),
  div(style = "display:inline-block",
      actionButton("report", "Report Issue")),
  div(style = "display:inline-block",
      textInput("cooper_field", "Cooper's message", width = "500px"))
))

server <- shinyServer( function(input, output, session) {
  chat <- shiny.collections::collection("chat", connection)
  updateTextInput(session, "name_field",
                  value = get_random_username()
  )
  observeEvent(input$send, {
    new_message <- list(user = input$username_field,
                        text = input$message_field,
                        time = Sys.time())
    shiny.collections::insert(chat, new_message)
    updateTextInput(session, "message_field", value = "")
  })
  output$chatbox <- renderUI({
    if (!is_empty(chat$collection)) {
      render_msg_divs(chat$collection)
    } else {
      tags$span("Empty chat")
    }
  })
})

shinyApp(ui = ui, server = server)
