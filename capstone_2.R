winequality.red <- read.csv("C:/Users/andres.gomez/Desktop/DS/winequality-red.csv", sep=";")
View(winequality.red)

#R earlier than 3.6
set.seed(229)
#R 3.6 and later
#set.seed(1, sample.kind = "Rounding")