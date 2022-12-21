# label for knitr:
## ---- rpphi-data-collection ----
library(dplyr)
library(readr)
download.file(url = "https://osf.io/4ewkh/download", 
              destfile = "XPhiReplicability_CompleteData.csv")
rpphi <- read_csv("XPhiReplicability_CompleteData.csv")
rpphi %>% 
  mutate(FZ_OS = atanh(OriginalRES),
         FZ_RS = atanh(ReplicationRES),
         FZ_se_OS = 1/sqrt(OriginalN_Effect - 3),
         FZ_se_RS = 1/sqrt(ReplicationN_Effect - 3),
         pval_RS = 2*pnorm(abs(FZ_RS/FZ_se_RS), lower.tail = FALSE),
         pval_OS = 2*pnorm(abs(FZ_OS/FZ_se_OS), lower.tail = FALSE)) %>% 
  select(PAPER_ID, 
         OriginalN_Effect, 
         OriginalTEST, 
         OriginalEFFECTSIZE, 
         OriginalANALYSIS, 
         OriginalRES, 
         OriginalPOWER, 
         OriginalR95CI, 
         FZ_OS, 
         FZ_se_OS, 
         pval_OS,
         ReplicationN_Effect,
         ReplicationTEST,
         ReplicationANALYSIS, 
         ReplicationEFFECTSIZE, 
         ReplicationRES, 
         ReplicationR95CI, 
         FZ_RS,
         FZ_se_RS, 
         pval_RS,
         ReplicationSUCCESS,
         OSF) %>% 
  rename(Study = PAPER_ID, 
         Type_Test_OS = OriginalTEST, 
         Test_Statistic_OS = OriginalANALYSIS, 
         N_OS = OriginalN_Effect, 
         r_OS = OriginalRES, 
         r_CI_OS = OriginalR95CI,
         Effect_Size_OS = OriginalEFFECTSIZE, 
         Power_OS = OriginalPOWER,
         Type_Test_RS = ReplicationTEST,
         Test_Statistic_RS = ReplicationANALYSIS,
         N_RS = ReplicationN_Effect, 
         r_RS = ReplicationRES, 
         r_CI_RS = ReplicationR95CI, 
         Effect_Size_RS = ReplicationEFFECTSIZE,
         Replication_Success = ReplicationSUCCESS) %>%
 write_csv(path = "RPPHI.csv")