# label for knitr:
## ---- data-extraction-final ----
library(dplyr)
library(readr)
rpp <- read_csv("RPP/RPP.csv")
rpphi <- read_csv("RPPHI/RPPHI.csv")
ssrp <- read_csv("SSRP/SSRP.csv")
eerp <- read_csv("EERP/EERP.csv")

# Subsets of data where effect sizes transformed to correlations available
rpp_correlations_subset <- rpp %>% 
  filter(!is.na(r_OS) & !is.na(r_RS)) %>% 
  mutate(Project = "Psychology",
         Study = Authors_OS,
         Survey_Belief_Premarket = NA,
         Survey_Belief_Postmarket = NA,
         Market_Belief = NA) %>% 
  select(Study, r_OS, r_RS, FZ_OS, FZ_RS, FZ_se_OS, FZ_se_RS, pval_RS, 
         N_OS, N_RS, pval_OS, Project, Survey_Belief_Premarket,
         Survey_Belief_Postmarket, Market_Belief)

eerp_correlations_subset <- eerp %>% 
  mutate(Project = "Experimental Economics",
         Stuy = Study,
         Survey_Belief_Premarket = eerp$Survey_Belief_premarket,
         Survey_Belief_Postmarket = eerp$Survey_Belief_postmarket,
         Market_Belief = eerp$Market_Belief) %>% 
  select(Study, r_OS, r_RS, FZ_OS, FZ_RS, FZ_se_OS, FZ_se_RS, pval_RS, 
         N_OS, N_RS, pval_OS, Project, Survey_Belief_Premarket,
         Survey_Belief_Postmarket, Market_Belief)

ssrp_correlations_subset <- ssrp %>% 
  mutate(Project = "Social Sciences",
         Study = Name_OS,
         Survey_Belief_Premarket = ssrp$Survey_Belief,
         Survey_Belief_Postmarket = NA,
         Market_Belief = ssrp$Market_Belief) %>% 
  select(Study, r_OS, r_RS, FZ_OS, FZ_RS, FZ_se_OS, FZ_se_RS, pval_RS, 
         N_OS, N_RS, pval_OS, Project, Survey_Belief_Premarket,
         Survey_Belief_Postmarket, Market_Belief)

rpphi_correlations_subset <- rpphi %>% 
  filter(!is.na(r_OS) & !is.na(r_RS) & !is.na(pval_RS)) %>% 
  mutate(Project = "Experimental Philosophy",
         Study = Study,
         Survey_Belief_Premarket = NA,
         Survey_Belief_Postmarket = NA,
         Market_Belief = NA) %>% 
  select(Study, r_OS, r_RS, FZ_OS, FZ_RS, FZ_se_OS, FZ_se_RS, pval_RS, 
         N_OS, N_RS, pval_OS, Project, Survey_Belief_Premarket, 
         Survey_Belief_Postmarket, Market_Belief)

data_correlations_subset <- rbind(rpp_correlations_subset, 
                                  eerp_correlations_subset, 
                                  ssrp_correlations_subset, 
                                  rpphi_correlations_subset) %>% 
  mutate(pval_RS_significant = factor(pval_RS < 0.05, 
                                      labels = c("Not Significant", 
                                                 "Significant")))

write_csv(data_correlations_subset, 
          path = "Data_Final/replications_correlation_subset.csv")

# Subset of data where standard error of Fisher z-transformed correlations available (Meta analytic subset)
data_ma_subset <- data_correlations_subset %>% 
  filter(!is.na(FZ_se_OS) & !is.na(FZ_se_RS))

write_csv(data_ma_subset, path = "Data_Final/replications_ma_subset.csv")