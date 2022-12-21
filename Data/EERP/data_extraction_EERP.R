# label for knitr:
## ---- eerp-data-collection ----
# - All files downloaded from https://osf.io/pnwuz/
# - Unfortunately this data had to be manually recorded from the file 
#   "create_studydetails.do" since I do not own the commercial software stata 
#   which is required to run the .do file and generate .dat file (economists ..)
# - Similarly, effective sample size taken from  "effectstandardization.py" file
# - Prediction market infos taken from table S3 in Supplementary of Article
#   http://science.sciencemag.org/content/sci/suppl/2016/03/02/
#   science.aaf0918.DC1/aaf0918-Camerer-SM.pdf

library(dplyr)
library(readr)
Study <- c("Abeler et al. (AER 2011)", 
           "Ambrus and Greiner (AER 2012)", 
           "Bartling et al. (AER 2012)",
           "Charness and Dufwenberg (AER 2011)", 
           "Chen and Chen (AER 2011)", 
           "de Clippel et al. (AER 2014)",
           "Duffy and Puzzello (AER 2014)", 
           "Dulleck et al. (AER 2011)", 
           "Fehr et al. (AER 2013)", 
           "Friedman and Oprea (AER 2012)", 
           "Fudenberg et al. (AER 2012)", 
           "Huck et al. (AER 2011)", 
           "Ifcher and Zarghamee (AER 2011)", 
           "Kessler and Roth (AER 2012)", 
           "Kirchler et al (AER 2012)",
           "Kogan et al. (AER 2011)", 
           "Kuziemko et al. (QJE 2014)", 
           "Ericson and Fuster (QJE 2011)")
Market_Belief <- c(0.696, 0.692, 0.805, 0.695, 0.778, 0.759, 0.806, 0.738, 0.629,
                   0.833, 0.933, 0.920, 0.588, 0.937, 0.712, 0.802, 0.632, 0.622)
Survey_Belief_premarket <- c(0.696, 0.542, 0.807, 0.715, 0.682, 0.730, 0.685, 
                             0.807, 0.674, 0.863, 0.790, 0.749, 0.542, 0.837, 
                             0.704, 0.748, 0.568, 0.658)
Survey_Belief_postmarket <- c(0.697, 0.620, 0.733, 0.708, 0.692, 0.716, 0.694, 
                              0.744, 0.666, 0.817, 0.770, 0.730, 0.566, 0.825, 
                              0.728, 0.752, 0.582, 0.650)
pval_OS <- c(0.046, 0.057, 0.007, 0.01, 0.033, 0.001, 0.01, 0.0001, 0.011, 
             4*10^(-11), 0.001, 0.0039, 0.031, 1.631*10^(-18), 0.0163, 0.000026,
             0.07, 0.03)
# Attention, these are session numbers, not effective sample size!
# N_OS <- c(120, 117, 216, 162, 72, 158, 54, 168, 60, 78, 124,120, 58, 288, 120, 
#           126, 42, 112)
# These are effective sample size:
N_OS <- c(120, 39, 12, 43, 6, 790, 9, 21, 30, 78, 124, 12, 58, 288, 12, 160, 
          42, 104)
r_OS <- c(0.182821975588, 0.310518647505, 0.719849875686, 0.383943377571, 
          0.842508557739, 0.117768981826, 0.761510174904, 0.722509234548, 
          0.453281944406, 0.642590125822, 0.303741608956, 0.832065702534, 
          0.282103220856, 0.486223364603, 0.664409308738, 0.323896842962, 
          0.282261740933, 0.212921823047)
pval_RS <- c(0.16, 0.012, 0.001, 0.003, 0.571, 4*10^(-10), 0.674, 0.0008, 
             0.026, 0.004276, 0.0001506473, 0.1415, 0.933, 0.016, 0.0095, 
             0.001, 0.154, 0.0546)
# Attention, these are session numbers, not effective sample size!
# N_RS <- c(318, 357, 360, 264, 168, 156, 96, 128, 102, 40, 128, 160, 131, 48,
#           220, 90, 144, 262)
# These are effective sample size:
N_RS <- c(318, 119, 20, 65, 14, 780, 16, 16, 51, 40, 128, 16, 131, 48, 22,
          112, 144, 248)
r_RS <- c(0.0790703532018, 0.229536356959, 0.657411288278, 0.363002684809,
          0.170189166838, 0.266538269195, -0.11596300548, 0.731605727911, 
          0.311199311719, 0.437953607707, 0.326573539422, 0.367593525514, 
          -0.00701629144787, 0.34463841128, 0.533556821497, 0.304223231247, 
          -0.119848901099, 0.122871403263)
Power_RS <- c(0.9, 0.91, 0.94, 0.9, 0.9, 0.9, 0.93, 0.92, 0.91, 0.99, 0.92, 
              0.91, 0.9, 0.95, 0.9, 0.94, 0.92, 0.91)

tibble(Study, r_OS, N_OS, pval_OS, r_RS, N_RS, pval_RS, Power_RS, 
       Market_Belief, Survey_Belief_premarket, Survey_Belief_postmarket) %>% 
  mutate(FZ_OS = atanh(r_OS),
         FZ_se_OS = 1/sqrt(N_OS - 3),
         pvalFZ_OS = 2*pnorm(abs(FZ_OS)/FZ_se_OS, lower.tail = FALSE),
         FZ_RS = atanh(r_RS),
         FZ_se_RS = 1/sqrt(N_RS - 3),
         pvalFZ_RS = 2*pnorm(abs(FZ_RS)/FZ_se_RS, lower.tail = FALSE)) %>% 
  write_csv(path = "EERP.csv")