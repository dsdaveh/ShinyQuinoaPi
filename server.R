library(UsingR)
library(plotrix)
library(shiny)

throw.history <- numeric()
set.seed <- 1999
last.reset <- 0
n.throws <- 0
hide.quick.start <- 0
show.explanation <- 0

shinyServer(
     function(input, output) {
          output$image <- renderPlot({
               if( input$resetButton > last.reset)  {
                    isolate({ 
                         throw.history<<-numeric()
                         last.reset <<- input$resetButton
                         n.throws <<- 0
                    })
               }
               input$goButton
               isolate({
                    n.throws <<- ifelse( n.throws < 0, 1, input$nthrows)
                    for( throw in 1:n.throws) {
                         
                         x <- runif( input$nq )
                         y <- runif( input$nq )
                         
                         r <- sqrt((x - .5)^2 +(y - .5)^2)
                         nq.in <- r <= .5
                         colr <- ifelse( nq.in, "red", "blue") #not used
                         
                         pi.est <- 4 * sum(nq.in) / input$nq
                         throw.history <<- c(throw.history, pi.est)
                    }
                    
                    text.obs <- sprintf("On the last throw, %d grains were thrown. %d landed in the circle.", input$nq, sum(nq.in))
                    text.pi <- expression(pi[estimated] == 4 %*% frac(total.in.circle, total.thrown))
                    text.result <- sprintf("= %.6f    (Error = %7.2f%%)", pi.est, -100*(1-pi.est/pi))
                    par(mar=c(2,2,5,2), mfrow=c(2,1))
                    plot  ( x=c(-.1, 1.1, 1.1, -.1)
                            ,y=c(-.1, -.1, 1.1, 1.1)
                            , axes=FALSE, asp=1, type="n", xlab="", ylab="")
                    mtext(line=4, text.obs)
                    mtext(line=1, text.pi)
                    mtext(text.result)
                    
                    lines( x=c(0,1,1,0,0), y=c(0,0,1,1,0), col="blue")
                    draw.circle(.5,.5,.5,nv=100,col="light blue", border="white")
                    
                    #brown.trans <- col2rgb("brown")  #165,42,42
                    points(x,y, pch=19, col=rgb(165,42,42, 70,maxColorValue=255)) # col=colr to color the points
                    
                    n.throws <- length(throw.history)
                    n.breaks <- ifelse(n.throws>35, 50, 10)
                    pi.avg <- mean(throw.history)
                    throw.hist <- hist(throw.history, breaks=n.breaks, main = "Estimate History")
                    hist.max <- max(throw.hist$counts)
                    mtext(line=0, sprintf("After %d throws, the estimate for pi=%.5f   (Error = %7.4f%%)"
                                          , n.throws, pi.avg
                                          , -100*(1-pi.avg/pi)))
                    lines(c(pi.avg, pi.avg), c(0, hist.max),col="red",lwd=2)
                    text(pi.avg, hist.max*.9 , expression(pi[est.avg]), col="red", c(0,0))
                    lines(c(pi, pi), c(0, hist.max),col="black",lty=2)
                    text(pi, hist.max*.8, expression(pi), adj=c(-1,0))
               } ) #isolate
          }, width=400, height=800)  #renderPlot
          
          output$quick.start <- renderText({
               hide <- input$hideQuick %% 2  #hide if the number of show/hide clicks is odd
               
               quick.text <- '<h4>Quick Start</h4>
                <li>Leave the default values for now (100 grain/1 throw)</li>
                <li>Hit the "Throw" button a few times</li>
                <li>Notice the histogram forming, and the estimated value of pi (red line) converging to the actual (black line)
                <li>Use the slider to increase the number of grains per throw</li>
                <li>Use the number of throws to speed up the growth of the histogram</li>
               '
               ifelse(hide, "", quick.text)
          })
          #if( input$hideQuick ) { output$quick.start <- ""}

          output$explain <- renderText({ 
                show <- input$hideExplain %% 2  #show if the number of show/hide clicks is odd
               explain.text <- "
               <div>The motivation for this gadget comes from 
               <a href='http://en.wikipedia.org/wiki/Monte_Carlo_method'>Wikipedia - Monte Carlo Method</a>
               (see Introduction)</div>
               <br><b>Try this warm up question to get you going:</b>
               <br>Q: What if you were asked to find the value of pi using just a can of beans, a string and a piece of college ruled notepaper?
               <br>A: Easy.  You wrap the string around the can and measure it to get the circumference (using the lines on the ruled paper), measure the diameter of can, and divide the circumfance by the diameter to get pi.
               <p>Q: Now what if you had to find pi using only some grains of quinoa?
               <br>A: You construct a diagram of a square with a circle circumscribed inside (like what's on the right hand side).
               Now throw some quinoa grains randomly and count the ones that land in the circle and divide it by the total thrown (assuming they all landed somewhere in the square) to get the ratio.
               The probability that a grain lands inside the circle is the area of the circle divided by the area of the square.
               Substituting the ratio above for the probabilty and rearranging a bit gives us an estimate for pi (see the formula to the right).
               Unfortunately, its not a rapidly converging estimate and you need to count a lot of quinoa -- or you can just run this handy app.
               </div>"
               ifelse(show, explain.text, " ")
           })
     }
)