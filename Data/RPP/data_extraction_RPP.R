# Variables Legend
# ------------------
# "Study_ID",           
# "Authors_OS",             "Original Study, Authors"
# "Journal_OS",             "Original Study, Journal"
# "Discipline",             "Original Study, Subdiscipline"
# "Type_Test_Statistic_OS", "Original Study, Type of Test Statistic"
# "DF1_OS"                  "Original Study, Degrees of Freedom 1"
# "DF2_OS"                  "Original Study, Degrees of Freedom 2"
# "Test_Statistic_OS",      "Origial Study, Test Statistic"
# "Analysis_Type_OS",       "Original Study, Analysis Type"
# "Effect_Size_OS",         "Original Study, Effect Size as String"
# "Power_OS",               "Original Study, Power (if available)"
# "N_OS",                   "Original Study, Number of Observations"
# "r_OS",                   "Original Study, Standardized Effect Size (Correlation Coefficient r)"
# "pval_OS" ,               "Original Study, p-Value"
# "FZ_OS",                  "Original Study, Fisher z-transformed correlation coefficient r"
# "Type_Test_Statistic_OS", "Original Study, Type of Test Statistic"
# "DF1_OS"                  "Original Study, Degrees of Freedom 1"
# "DF2_OS"                  "Original Study, Degrees of Freedom 2"
# "Test_Statistic_RS",      "Replication Study, Test Statistic"
# "Analysis_Type_RS",       "Replication Study, Analysis Type"
# "Effect_Size_RS",         "Replication Study, Effect Size as String"
# "Power_RS",               "Replication Study, Power"
# "N_RS",                   "Replication Study, Number of Observations"
# "r_RS",                   "Replication Study, Standardized Effect Size (Correlation Coefficient r)"
# "pval_RS" ,               "Replication Study, p-Value"
# "FZ_RS",                  "Replication Study, Fisher z-transformed correlation coefficient r"
# "FZ_meta",                "Meta Analysis Estimate, Fisher z-transformed"

# label for knitr:
## ---- rpp-data-collection ----
library(dplyr)
library(readr)
url_master <- "https://github.com/CenterForOpenScience/rpp/archive/master.zip"
download.file(url = url_master, destfile = "rpp_git_repo.zip")
unzip("rpp_git_repo.zip" )

# ATTENTION: if running on linux: comment out the windows command 
# "choose.dir" at beginning of masterscript.R !
setwd("rpp-master/") 
source("masterscript.R")
setwd("../")

MASTER_cleaned <- MASTER %>% 
  mutate(FZ_OS = atanh(T_r..O.),
         FZ_RS = atanh(T_r..R.),
         Actual.Power..O. = as.double(as.character(Actual.Power..O.)),
         Power..R. = as.double(Power..R.)) %>% 
  select(ID, 
         Authors..O., 
         Journal..O.,  
         Discipline..O., 
         T_Test.Statistic..O., 
         T_df1..O., 
         T_df2..O., 
         T_Test.value..O.,  
         Type.of.analysis..O., 
         Effect.size..O., 
         Actual.Power..O., 
         T_N..O., 
         T_r..O., 
         T_pval_USE..O., 
         FZ_OS, 
         T_Test.Statistic..R., 
         T_df1..R.,
         T_df2..R., 
         T_Test.value..R., 
         Type.of.analysis..R., 
         Power..R.,
         Effect.Size..R., 
         T_N..R., 
         T_r..R., 
         T_pval_USE..R., 
         FZ_RS,
         Meta.analytic.estimate..Fz.) %>% 
  rename(Study_ID = ID, 
         Authors_OS = Authors..O., 
         Journal_OS = Journal..O.,
         Discipline = Discipline..O., 
         Type_Test_Statistic_OS = T_Test.Statistic..O., 
         DF1_OS = T_df1..O.,  
         DF2_OS = T_df2..O., 
         Test_Statistic_OS = T_Test.value..O.,
         N_OS = T_N..O., 
         r_OS = T_r..O., 
         pval_OS = T_pval_USE..O.,
         Analysis_Type_OS = Type.of.analysis..O., 
         Effect_Size_OS = Effect.size..O.,
         Power_OS = Actual.Power..O., 
         Type_Test_Statistic_RS = T_Test.Statistic..R.,
         DF1_RS = T_df1..R., 
         DF2_RS = T_df2..R., 
         Test_Statistic_RS = T_Test.value..R.,
         N_RS = T_N..R., 
         r_RS = T_r..R., 
         pval_RS = T_pval_USE..R.,
         Analysis_Type_RS = Type.of.analysis..R., 
         Effect_Size_RS = Effect.Size..R., 
         Power_RS = Power..R., 
         FZ_meta = Meta.analytic.estimate..Fz.) 

MASTER_cleaned$FZ_se_OS[!is.na(MASTER_cleaned$FZ_meta)] <- final$sei.o
MASTER_cleaned$FZ_se_RS[!is.na(MASTER_cleaned$FZ_meta)] <- final$sei.r
MASTER_cleaned <- MASTER_cleaned %>% 
  # these were one-sided p-values according supplementary
  mutate(pval_OS = ifelse(Study_ID %in% c(7, 15, 47, 94, 120, 140),  pval_OS*2, pval_OS), 
         pval_OS = ifelse(pval_OS > 1, 1, pval_OS),
         pval_RS = ifelse(Study_ID %in% c(7, 15, 47, 94, 120, 140), pval_RS*2, pval_RS),
         pval_RS = ifelse(pval_RS > 1, 1, pval_RS),
         pvalFZ_OS = 2*pnorm(abs(FZ_OS)/FZ_se_OS, lower.tail = FALSE),
         pvalFZ_RS = 2*pnorm(abs(FZ_RS)/FZ_se_RS, lower.tail = FALSE))
write_csv(MASTER_cleaned, path = "RPP.csv")