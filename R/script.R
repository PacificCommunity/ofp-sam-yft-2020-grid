## Plot SB/SBF0, starting with the 2020 diagnostic model

library(TAF)
library(FLR4MFCL)

## 1  Read 2017 and 2020 assessment rep file

mkdir("run")

download("https://github.com/PacificCommunity/ofp-sam-yft-2020-runs/releases/download/runs/diagnostic_matt.zip", "run")

direct <- read.MFCLRep("https://raw.githubusercontent.com/PacificCommunity/ofp-sam-yft-2020-grid/main/Grid_Models/CondAgeGrowth_Size20_H0.8_Mix2/plot-out.par.rep")

rep20 <- read.MFCLRep(unz("run/diagnostic_matt.zip", "plot-10.par.rep"))

download("https://github.com/PacificCommunity/ofp-sam-yft-2020-runs/releases/download/runs/diagnostic_matt.zip", "run")
rep20 <- read.MFCLRep(unz("run/diagnostic_matt.zip", "plot-10.par.rep"))

## 2  Plot SB and SBF0

xyplot(data~year|area, group=qname,
       data=FLQuants(qts(adultBiomass_nofish(rep20)), qts(adultBiomass(rep20))),
       type="l", as.table=TRUE, main="2020 assessment")

xyplot(data~year, data=FLQuants(SB(rep20), SBF0(rep20))

b <- flr2taf(SB(direct)/1e6, colname="SB")
b0 <- flr2taf(SBF0(direct)/1e6, colname="SBF0")
direct20 <- merge(b, b0)
direct20$Depletion <- assmt20$SB / assmt20$SBF0

b <- flr2taf(SB(rep20)/1e6, colname="SB")
b0 <- flr2taf(SBF0(rep20)/1e6, colname="SBF0")
assmt20 <- merge(b, b0)
assmt20$Depletion <- assmt20$SB / assmt20$SBF0

plot(SBF0~Year, data=assmt20, type="l", lty=3, ylim=lim(assmt20$SBF0),
     ylab="Spawning biomass (Mt)")
lines(SB~Year, data=assmt20)

plot(Depletion~Year, data=assmt20, type="l", ylim=lim(assmt20$Depletion))
abline(h=0.2, lty=3)



## 3  Plot SB / SBF0

plot(SBSBF0(rep20), ylim=c(0, 1.05))
plot(flr2taf(SBSBF0(rep20), colname="SBSBF0"), ylim=c(0, 1.05))



library(R4MFCL)
r <- read.rep(unz("run/diagnostic_matt.zip", "plot-10.par.rep"))
ssb <- rowSums(r$AdultBiomass)
ssb.annual <- colMeans(matrix(ssb, nrow=4))
years <- unique(trunc(r$yrs))
out <- data.frame(Year=years, SSB=ssb.annual)
