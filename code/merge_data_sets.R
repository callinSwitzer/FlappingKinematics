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



audFile <- read_csv(file.path(dataDir,  "audio_output_full_FFT.csv")) %>%
  mutate(
  BeeID = substr(fname, 0, 3),
  Treatment = substr(fname, 4, 4) 
  ) %>%
  group_by(BeeID)
audFile

plot(audFile$smoothEstimateFreq, audFile$spikyEstimateFreq)
abline(0, 1)

## REFREF: here


combinedAud = full_join(audFile, audFile2, by = c("fname", "BeeID", "Treatment"))
combinedAud <- combinedAud %>%
  select(-fname)

spread(combinedAud, c("BeeID"), "Treatment", )

plot(combinedAud$freq.x, type = 'l')
plot(combinedAud$freq.y, type = 'l')

plot(combinedAud$freq.x,combinedAud$freq.y, xlim = c(150, 250))
lines(0:300, 0:300)


with(combinedAud, plot(freq.x, freq.y))

