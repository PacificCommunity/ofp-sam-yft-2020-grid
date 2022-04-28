## Plot SB/SBF0, starting with the 2020 diagnostic model

library(TAF)
library(FLR4MFCL)

## 1  Read 2020 assessment rep file

mkdir("run")
download("https://github.com/PacificCommunity/ofp-sam-yft-2020-runs/releases/download/runs/diagnostic_matt.zip", "run")
rep20 <- read.MFCLRep(unz("run/diagnostic_matt.zip", "plot-10.par.rep"))

## 2  Plot SB and SBF0

xyplot(data~year|area, group=qname,
       data=FLQuants(qts(adultBiomass_nofish(rep20)), qts(adultBiomass(rep20))),
       type="l", as.table=TRUE, main="2020 assessment")

## 3  Plot SB / SBF0

plot(SBSBF0(rep20), ylim=c(0, 1.05))
plot(flr2taf(SBSBF0(rep20), colname="SBSBF0"), ylim=c(0, 1.05))
