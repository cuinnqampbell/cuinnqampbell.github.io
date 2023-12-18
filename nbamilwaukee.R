install.packages("skimr")
install.packages("hoopR")
library(hoopR)
install.packages("tictoc")

tictoc::tic()
progressr::with_progress({
  nba_pbp <- hoopR::load_nba_pbp()
})
tictoc::toc()
library(tidyverse)
nba_pbp_df <- nba_pbp %>% 
  filter(home_team_name == "Milwaukee" |away_team_name == "Milwaukee")
write_csv(nba_pbp_df,"nbamilwaukee.csv")

bucks_home_2024 <- subset(nba_pbp_df, home_team_name == "Milwaukee" & season == 2024)

bucks_freethrow_home_2024 <- subset(nba_pbp_df, type_text == "Free Throw - 1 of 2" & team_id == 15 & season == 2024)

bucks_freethrow2_2024 <- subset(nba_pbp_df, type_text == "Free Throw - 2 of 2" & team_id == 15 & season == 2024)

Q1 <- bucks_freethrow_home_2024 %>% 
  group_by(scoring_play) %>% 
  count(scoring_play == TRUE)

Q1 %>% 
  ggplot(aes(x = scoring_play, y = n))+
  geom_bar(stat = "identity",
           position = "dodge",
           alpha = 0.5)+
  theme_bw()+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())+
  labs(title = "Results from First Free Throw",
       x = "Scoring Play",
       y = "Number")


Q2 <- bucks_freethrow2_2024 %>% 
  group_by(scoring_play) %>% 
  count(scoring_play == TRUE)
  
Q2 %>% 
  ggplot(aes(x = scoring_play, y = n))+
  geom_bar(stat = "identity",
           position = "dodge",
           alpha = 0.5)+
  theme_bw()+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())+
  labs(title = "Results from Second Free Throw",
       x = "Scoring Play",
       y = "Number")



  
  
  