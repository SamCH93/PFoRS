# Variables Legend
# ------------------
# "study",    "Study ID"
# "name_os",  "Original Study, Name"
# "sref",     "Original Study, Study Reference"
# "type_os",  "Original Study, Type of Test Statistic"
# "stat_os",  "Origial Study, Statistic"
# "n_os",     "Original Study, Number of Observations"
# "in_os",    "Original Study, Number of Individuals"
# "r_os",     "Original Study, Standardized Effect Size (Correlation Coefficient r)"
# "r95l_os",  "Original Study, Lower Bound of 95% CI Around r"
# "r95u_os",  "Original Study, Upper Bound of 95% CI Around r"
# "p_os",     "Original Study, p-Value"
# "type_rs1", "Replication Study 1, Type of Test Statistic"
# "stat_rs1", "Replication Study 1, Statistic"
# "n_rs1",    "Replication Study 1, Number of Observations"
# "in_rs1",   "Replication Study 1, Number of Individuals"
# "r_rs1",    "Replication Study 1, Standardized Effect Size (Correlation Coefficient r)"
# "r95l_rs1", "Replication Study 1, Lower Bound of 95% CI Around r"
# "r95u_rs1", "Replication Study 1, Upper Bound of 95% CI Around r"
# "p_rs1",    "Replication Study 1, p-Value"
# "pow_rs1",  "Replication Study 1, Statistical Power"
# "type_rs2", "Replication Study 2, Type of Test Statistic"
# "stat_rs2", "Replication Study 2, Statistic"
# "n_rs2",    "Replication Study 2, Number of Observations"
# "in_rs2",   "Replication Study 2, Number of Individuals"
# "r_rs2",    "Replication Study 2, Standardized Effect Size (Correlation Coefficient r)"
# "r95l_rs2", "Replication Study 2, Lower Bound of 95% CI Around r"
# "r95u_rs2", "Replication Study 2, Upper Bound of 95% CI Around r"
# "p_rs2",    "Replication Study 2, p-Value"
# "pow_rs2",  "Replication Study 2, Statistical Power"

# Two-Stage Procedure
# --------------------
# In stage 1, we had 90% power to detect 75% of the original effect size at the 5% significance 
# level in a two-sided test. If the original result replicated in stage 1 (a two-sided P < 0.05 
# and an effect in the same direction as in the original study), no further data collection was
# carried out. If the original result did not replicate in stage 1, we carried out a second data
# collection in stage 2 to have 90% power to detect 50% of the original effect size for the 
# first and second data collections pooled.

# Original Studies
# -----------------
# label for knitr:
## ---- ssrp-data-collection ----
library(dplyr)
library(readr)
names <- c("Ackerman et al. (2010), Science",
           "Aviezer et al. (2012), Science",
           "Balafoutas and Sutter (2012), Science",
           "Derex et al. (2013), Nature",
           "Duncan et al. (2012), Science",
           "Gervais and Norenzayan (2012), Science",
           "Gneezy et al. (2014), Science",
           "Hauser et al. (2014), Nature",
           "Janssen et al. (2010), Science",
           "Karpicke and Blunt (2011), Science",
           "Kidd and Castano (2013), Science",
           "Kovacs et al. (2010), Science",
           "Lee and Schwarz (2010), Science",
           "Morewedge et al. (2010), Science",
           "Nishi et al. (2015), Nature",
           "Pyc and Rawson (2010), Science",
           "Ramirez and Beilock (2011), Science",
           "Rand et al. (2012), Nature",
           "Shah et al. (2012), Science",
           "Sparrow et al. (2011), Science",
           "Wilson et al. (2014), Science")
download.file(url = "https://osf.io/abu7k/download", 
              destfile = "SSRP_Data_Processed.csv")
download.file(url = "https://osf.io/vr6p8/download", 
              destfile = "SSRP_Data_Peer_Beliefs_Processed.csv")
ssrp <- read_csv("SSRP_Data_Processed.csv")
ssrp_pmarket <- read_csv("SSRP_Data_Peer_Beliefs_Processed.csv")
prediction_markets <- ssrp_pmarket %>% 
  select(m3_p, m3_b) %>% 
  rename(Market_Belief = m3_p,
         Survey_Belief = m3_b) %>% 
  filter(!is.na(Market_Belief))

ssrp %>% 
  mutate(Name_OS = names,
         FZ_OS = atanh(r_os),
         FZ_se_OS = 1/sqrt(n_os - 3),
         FZ_RS1 = atanh(r_rs1),
         FZ_se_RS1 = 1/sqrt(n_rs1 - 3),
         FZ_RS2 = atanh(r_rs2),
         FZ_se_RS2 = 1/sqrt(n_rs2 - 3)) %>% 
  select(study, 
         Name_OS, 
         sref, 
         type_os, 
         stat_os, 
         n_os, 
         in_os, 
         r_os, 
         r95l_os, 
         r95u_os, 
         p_os, 
         FZ_OS, 
         FZ_se_OS,
         type_rs1, 
         stat_rs1, 
         n_rs1, 
         in_rs1, 
         r_rs1, 
         r95l_rs1,
         r95u_rs1, 
         p_rs1, 
         pow_rs1, 
         FZ_RS1, 
         FZ_se_RS1,
         type_rs2, 
         stat_rs2, 
         n_rs2, 
         in_rs2, 
         r_rs2,
         r95l_rs2,
         r95u_rs2,
         p_rs2, 
         pow_rs2, 
         FZ_RS2, 
         FZ_se_RS2) %>% 
  rename(Study = study, 
         Sref = sref, 
         Type_OS = type_os,
         Stat_OS = type_os,
         N_OS = n_os, 
         In_OS = in_os,
         r_OS = r_os, 
         r95l_OS = r95l_os,
         r95u_OS = r95u_os,
         pval_OS = p_os, 
         Type_RS1 = type_rs1, 
         Stat_RS1 = stat_rs1,
         N_RS1 = n_rs1, 
         In_RS1 = in_rs1, 
         r_RS1 = r_rs1,
         r95l_RS1 = r95l_rs1,
         r95u_RS1 = r95u_rs1,
         pval_RS1 = p_rs1,
         Power_RS1 = pow_rs1, 
         Type_RS2 = type_rs2, 
         Stat_RS2 = stat_rs2,
         N_RS2 = n_rs2, 
         In_RS2 = in_rs2, 
         r_RS2 = r_rs2, 
         r95l_RS2 = r95l_rs2,
         r95u_RS2 = r95u_rs2,
         pval_RS2 = p_rs2,
         Power_RS2 = pow_rs2) %>% 
  mutate(r_RS = ifelse(!is.na(r_RS2), r_RS2, r_RS1),
         FZ_RS = ifelse(!is.na(FZ_RS2), FZ_RS2, FZ_RS1),
         FZ_se_RS = ifelse(!is.na(FZ_se_RS2), FZ_se_RS2, FZ_se_RS1),
         pval_RS = ifelse(!is.na(FZ_se_RS2), pval_RS2, pval_RS1),
         N_RS = ifelse(!is.na(FZ_se_RS2), N_RS2, N_RS1)) %>% 
  bind_cols(., prediction_markets) %>% 
  write_csv(path = "SSRP.csv")