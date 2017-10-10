library(ggplot2)
library(tidyverse)

data <- read.csv("Appliances by hh income.csv",header=FALSE)

income_age <- data[123:129,]
colnames(income_age) <- c("Age","totalUS","<$20,000","$20,000-$39,999","$40,000-$59,999",
                           "$60,000-$79,999","$80,000-$99,999","$100,000-$119,999","$120,000-$139,999",
                           "$140,000+")

income_age[income_age=="Q"] <- ""
income_age[income_age=="N"] <- ""

frdf <- as.data.frame(income_age)

income_age <- frdf[1:4,]

income_age <- income_age %>%
  gather(key="Income",value="Housing Units",`totalUS`:`$140,000+`)

income_age$`Housing Units` <- as.numeric(income_age$`Housing Units`)
income_age$Income <- factor(income_age$Income,levels=c("totalUS","<$20,000","$20,000-$39,999","$40,000-$59,999",
                                             "$60,000-$79,999","$80,000-$99,999","$100,000-$119,999","$120,000-$139,999",
                                             "$140,000+"))

income_age$Age <- factor(income_age$Age, levels=c("Less than 2 years old","2 to 4 years old",
                                                  "5 to 9 years old","10 to 14 years old"))

ggplot(data=income_age)+
  geom_point(mapping=aes(x=Income,y=`Housing Units`,color=Age),size=2.5)+
  ggtitle("Age of Refrigerators by Household Income")

