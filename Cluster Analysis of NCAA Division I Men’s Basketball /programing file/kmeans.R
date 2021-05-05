library(factoextra)
library(cluster)
library(ggplot2)
library(ggfortify)
library(GGally)

data<-read.csv("Data_20182019.csv", header=T, sep=",")

data1<-data[,-c(6,8,9)] #整理data
data1<-na.omit(data1)
ncaadata1 <- data[,-c(1,6,7,8,9)]
ncaadata1<-na.omit(ncaadata1) #清除ＮＡ

str(ncaadata1) #確認不是類別變數
names(ncaadata1) #看欄位
summary(ncaadata1)
nnn<-scale(ncaadata1) #標準化

set.seed(1000)
km3<-kmeans(nnn, centers=5) #kmeans分群
km3$size #各群size
head(km3) #各群相關係數

ncaanew<-cbind(data1, cbind(km3$cluster)) #將分群的結果，與原資料data1合併

names(ncaanew)[7] <- "clustergroup" #重新命名
names(ncaanew)
write.table(ncaanew,file="/Users/ningchu/Downloads.csv",sep=",",row.names=T, na = "NA")
write.csv(ncaanew,file="/Users/ningchu/Downloads.csv",row.names = FALSE)
write.table(ncaanew, file = "Downloads.csv", sep = ",")

qplot(Operating.Expenses.per.Team.Men.s.Team, data = ncaanew, color=as.character(clustergroup),bins = 30)
#相關係數分群
  ggpairs(xxx,columns = 1:4,mapping=aes(colour=as.character(km3$cluster)))
#看成績分布群框
  ggplot(ncaanew,aes(x = clustergroup, y = W.L.)) + 
  geom_jitter() + 
  stat_summary(fun.y = median, colour = "red", geom = "point", size = 5)
#看支出分布群框
  ggplot(ncaanew,aes(x = clustergroup, y =Expenses.Men.s.Team)) +
  geom_jitter() +
  stat_summary(fun.y = median, colour = "red", geom = "point", size = 5)
#看收入分布群框
  ggplot(ncaanew,aes(x = clustergroup, y =Revenues.Men.s.Team)) +
  geom_jitter() +
  stat_summary(fun.y = median, colour = "red", geom = "point", size = 5)
#看收入支出的關西
  qplot(Revenues.Men.s.Team,Expenses.Men.s.Team, data = ncaanew, color=as.character(clustergroup))
#聯盟差距
  qplot(Revenues.Men.s.Team,Coference, data = ncaanew, color=as.character(clustergroup))
#勝率跟收入的分佈
  qplot(W.L.,Revenues.Men.s.Team , data = ncaanew, color=as.character(clustergroup))
#聯盟表現
  qplot(W.L.,Coference, data = ncaanew, color=as.character(clustergroup))
#支出分佈
  qplot(Expenses.Men.s.Team , data = ncaanew, color=as.character(clustergroup))






