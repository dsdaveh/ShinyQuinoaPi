shinyUI(fluidPage(
     titlePanel("Estimating Pi with Quinoa"),
     fluidRow(column(12,
          h4( "A Shiny Example of the Monte Carlo Method"),
          span("Using R and Shiny.  "), 
          a("www.linkedin.com/in/davehurst", href="https://www.linkedin.com/in/davehurst")
     )),
     fluidRow( 
       column(6, wellPanel(

          htmlOutput('quick.start'),
          actionLink('hideQuick', "Show/Hide Quick Start"),
          span(HTML('<hr>')),
          
          sliderInput('nq', 'How much qinuoa do you want to throw?',
                      value = 110, min = 10, max = 10000, step = 10,),
          
          numericInput('nthrows', 'How many throws?',
                      value = 1, min = 1, max = 100, step = 10),
          br(),
          
          actionButton('goButton', 'Throw'), actionButton('resetButton', 'Reset History'),
      
          h4('What is this?'),
          htmlOutput('explain'),
          actionLink('hideExplain', "Show/Hide Explanation")
       )),

       column(6,
          plotOutput('image')
       )
     )

))