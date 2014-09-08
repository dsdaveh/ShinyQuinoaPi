shinyUI(pageWithSidebar(
     headerPanel("Estimating Pi with Quinoa"),
     sidebarPanel(
          sliderInput('nq', 'How much qinuoa do you want to throw?',
                      value = 100, min = 10, max = 10000, step = 10,),
          
          numericInput('nthrows', 'How many throws?',
                      value = 1, min = 1, max = 100, step = 10),
          
          actionButton('goButton', 'Throw'), actionButton('resetButton', 'Reset History'),
          
          br(), br(), h4('What is this?'),
          span("The motivation for this gadget comes from "),
          a("Wikipedia - Monte Carlo Method", href="http://en.wikipedia.org/wiki/Monte_Carlo_method"),
          span("."),br(),
          span(" (see Introduction)."), br(),
          p('Try this warm up question to get you going: What if you were asked to find the value of pi using just a can of beans, a string and a piece of college ruled notepaper?'),
          p('Easy.  You wrap the string around the can and measure it to get the circumference (using the lines on the ruled paper), measure the diameter of can, and divide the circumfance by the diameter to get pi'),
          p('Now what if you had to find pi using only some grains of quinoa?'),
          span("Answer: You construct a diagram of a square with a circle circumscribed (like what's on the right hand side)."),
          span("  Now throw some quinoa grains randomly and count the ones that land in the circle and divide it by the total thrown (assuming they all landed somewhere in the square) to get the ratio."),
          span("  The probability that a grain lands inside the circle is the area of the circle divided by the area of the square."),
          span("  Substituting the ratio above for the probabilty and rearranging a bit gives us an estimate for pi (see the formula to the right)."),
          p('  Unfortunately, its not a rapidly converging estimate and you need to count a lot of quinoa -- or you can just run this handy app.'),
          br(),br(),
          span("Comments welcome: "), a("www.linkedin.com/in/davehurst", href="https://www.linkedin.com/in/davehurst")
     ),
     
     
     mainPanel(
          plotOutput('image')
     )
))