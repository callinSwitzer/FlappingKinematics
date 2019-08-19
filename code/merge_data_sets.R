# Callin Switzer
## 8/8/2019
## merge data files



# install packages
ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if(length(new.pkg)) install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

packages <- c("tidyverse")
ipak(packages)

# set ggplot theme
theme_set(theme_classic() + 
            theme(axis.text=element_text(colour="black"), 
                  text=element_text(size=10)))

# set  directories
dataDir <- file.path(getwd(), "data", "clipped_audio")
figDir <- file.path(getwd(), "figures")
dataOut <- file.path(getwd(), "dataOutput")

print(paste("last run ", Sys.time()))
print(R.version)



audFile <- read_csv(file.path(dataDir,  "audio_output_full_FFT3.csv")) %>%
  mutate(
  BeeID = substr(fname, 0, 3),
  Treatment = substr(fname, 4, 4) 
  ) %>%
  rename(freq_v2 = freq2) %>%
  group_by(BeeID)
audFile

# smooth vs. spiky frequency estimate
# freq_v2 is the smoothed DFT estimate
plot(audFile$freq_v2, audFile$freq1)
abline(0, 1)



smoothFreq = audFile %>%
  select(c(BeeID, Treatment, freq_v2))

smoothFreq[smoothFreq$Treatment == "L", "Treatment"] = "H"
smoothFreq[smoothFreq$Treatment == "U", "Treatment"] = "L"


# combine with final data
fdata  = read_csv(file.path(getwd(), "data", "beeRespData_final.csv")) 
data2 = full_join(fdata, smoothFreq, by = c("BeeID", "Treatment"))

plot(data2$freq, data2$freq_v2)
abline(0, 1)


write_csv(data2, file.path(getwd(), "data", "beeRespData_freqUpdated.csv"))
