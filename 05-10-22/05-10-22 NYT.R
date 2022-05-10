library(tidyverse)
nytdata <- read.csv(file = "NYTTidyTuesday.csv")
nytdata <- nytdata[,3:9]
nytdata$title <- as.character(nytdata$title)
nytdata$author <- as.character(nytdata$author)
nytdata$first_week <- lubridate::ymd(nytdata$first_week)
str(nytdata)

clean <- nytdata %>% group_by(author) %>% summarize(books = n(),
                                           author = as.factor(author),
                                           year = year,
                                           title = title,
                                           total_weeks = total_weeks) %>% filter(books == 1) %>% 
  arrange(desc(total_weeks)) %>% head(10) %>% select(-books)

# Best One Hitter Wonder Novels by Author

clean %>% ggplot(aes(x = total_weeks, y = reorder(title,total_weeks))) + geom_col()


