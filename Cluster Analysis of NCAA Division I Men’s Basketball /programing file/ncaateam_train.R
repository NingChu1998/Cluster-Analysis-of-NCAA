library(rvest)
library(magrittr)

url <- "https://www.cbssports.com/college-basketball/news/2019-march-madness-field-ranking-all-68-teams-in-the-ncaa-tournament-bracket/"
ncaateam <- read_html(url)
class(ncaateam)
rating <- ncaateam %>%
  html_nodes(xpath =  "//div/div[@class='team-name']") %>%   
  html_text() %>%
  as.character()
rating <- gsub("\n","",rating) #delete \n
ncaa68team <- data.frame(rating)
write.table(ncaa68team, file = "/Users/ningchu/Desktop/ncaa68team.csv",row.names = FALSE, sep = ",")

