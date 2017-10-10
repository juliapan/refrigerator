library(ggplot2)
library(tidyverse)

data <- read.csv("Appliances by hh income.csv",header=FALSE)

fridge_data <- data[103:190,]
colnames(fridge_data) <- c("FridgeUse","totalUS","<$20,000","$20,000-$39,999","$40,000-$59,999",
                           "$60,000-$79,999","$80,000-$99,999","$100,000-$119,999","$120,000-$139,999",
                           "$140,000+")

fridge_data[fridge_data=="Q"] <- ""
fridge_data[fridge_data=="N"] <- ""

frdf <- as.data.frame(fridge_data)

quant <- frdf[1:4,]

quant <- quant %>%
  gather(key="Income",value="Housing Units",`totalUS`:`$140,000+`)

quant$`Housing Units` <- as.numeric(quant$`Housing Units`)
quant$Income <- factor(quant$Income,levels=c("totalUS","<$20,000","$20,000-$39,999","$40,000-$59,999",
                       "$60,000-$79,999","$80,000-$99,999","$100,000-$119,999","$120,000-$139,999",
                       "$140,000+"))

ggplot(data=quant)+
    geom_point(mapping=aes(x=Income,y=`Housing Units`,color=FridgeUse),size=2.5)+
    ggtitle("Refrigerator Use by Household Income")

