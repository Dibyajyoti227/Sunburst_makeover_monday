# libraries
library(tidyverse)
library(treemap)
library(sunburstR)
library(readxl)
library(htmlwidgets)

my_data <- read_excel("C:/Users/Gabriel/Desktop/MakeOver_monday/Non-meat_eaters_Britain/my_data.xlsx",sheet = "Data")

# Load dataset from PC

colnames(my_data) <- c("Center_circle","Category", "Frequency", "Consumption_percentage")


# Reformat data for the sunburstR package
 my_data1 <- my_data %>%
        filter(Center_circle != "") %>%
#        filter(Category != "") %>%
        mutate(path = paste(Center_circle, Category, Frequency, sep="-")) %>%
        dplyr::select(path, Consumption_percentage)

 # colors
 colors <- c("#cccccc","#66ff33","#99ff99","#ccffff","#ff9900","#990000","#000066","#0000cc","#3366cc","#6699ff","#99ffff","#cccccc")
 # match those colors to leaf names, matched by index
 labels <- c("All-consumers","Vegan","Vegetarian","Pescatarian","Flexitarian","Meateater","Daily","Weekly","Monthly","Less often","Never","Do not know")  

 
 sun <- sunburst(my_data1,  colors = list(range = colors, domain = labels), withD3 = T, width = "100%",height = 800, legend=TRUE)
 
 htmlwidgets::onRender(
         sun,
         "
    function(el, x) {
    d3.selectAll('.sunburst-legend text').attr('font-size', '12px');
    }
    "
 )  
# Plot
# sunburst(my_data1, colors = list(range = colors, domain = labels), legend=TRUE)