install.packages("cluster")
library("cluster")
library(tidyverse)
library(knitr)

data<-read.csv("Data_20182019.csv", header=T, sep=",")
dim(data)
head(data)
names(data)
#刪除欄位
data1<-na.omit(data) #清除ＮＡ
ncaadata <- data1[,-c(1,6,7)] #排除資料中的scholl與conference文字變數，方便計算歐幾里得距離
str(ncaadata)
xxx<-scale(ncaadata) #標準化


E.dist <- dist(x = xxx, method = "euclidean")#計算歐幾里得距離
# 將以上資料間距離作為參數投入階層式分群函數：hclust()
# 使用歐式距離進行分群
h.E.cluster <- hclust(E.dist)
plot(h.E.cluster, xlab="歐式距離",family="黑體-繁 中黑")

dev.off()
plot(hclust(E.dist, method="ward.D2"), xlab = "華德法: Ward's Method")  # 華德法


#我們聚焦在採用歐式距離搭配華德最小變異聚合演算法
dev.off()
par(family="黑體-繁 中黑")
plot(hclust(E.dist, method="ward.D2"), xlab = "華德法: Ward's Method")
rect.hclust(tree = hclust(E.dist, method="ward.D2"), k = 5, border = "red")


#計算聚合係數(agglomerative coefficient)。聚合係數是衡量群聚結構被辨識的程度，聚合係數越接近1代表有堅固的群聚結構(strong clustering structure)





