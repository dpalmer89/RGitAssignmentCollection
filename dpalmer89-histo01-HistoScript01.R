## Load Packages in library
library(tidyverse)
library(ggplot2)

## Acquire data
final.data <- read_csv("finalData.csv")

## Define Graph as Var. Does not visualize
my.hist <- ggplot(final.data,aes(se.measure))

## Make Histogram
my.hist <- my.hist + geom_histogram(aes(y= ..count..) , binwidth = .25, fill="black", color = "black")

## Add Labels
my.hist <- my.hist + labs(title="Self-esteem Histogram",x="Self-esteem Level", y="Frequency")

## Adjust Axes
my.hist <- my.hist + coord_cartesian(xlim=c(0.5, 5.5) , ylim=c(0, 100))

## Make APA Ready
my.hist <- my.hist + theme_classic()
my.hist <- my.hist + theme(axis.line.x = element_line(colour = "black", size=0.5, linetype='solid'), axis.line.y = element_line(colour = 'black', size=0.5, linetype ='solid'))

## Set Histogram start/end and width
my.hist <- my.hist + scale_x_continuous(breaks=seq(1,5,by=1))

#Lower y-axis
my.hist <- my.hist + scale_y_continuous( expand = c(0,0), breaks=seq(0,100,by=10))

##Save
ggsave(filename = "myHistograph.pdf", plot = my.hist, width=6,height=6,units = 'in')
