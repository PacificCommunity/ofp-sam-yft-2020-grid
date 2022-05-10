## Plot SB/SBF0, starting with the 2020 diagnostic model

library(TAF)
library(FLR4MFCL)

## 1  Read 2020 assessment rep file

mkdir("run")

penguin.diagnostic <- read.MFCLRep("z:/yft/2020/assessment/ModelRuns/Diagnostic/plot-14.par.rep")
penguin.grid <- read.MFCLRep("z:/yft/2020/assessment/ModelRuns/Grid/CondLen_M0.2_Size60_H0.8_Mix2/plot-out.par.rep")
web.zip.file <- read.MFCLRep("https://raw.githubusercontent.com/PacificCommunity/ofp-sam-yft-2020-grid/main/Grid_Models/CondAgeGrowth_Size20_H0.8_Mix2/plot-out.par.rep")
download("https://github.com/PacificCommunity/ofp-sam-yft-2020-runs/releases/download/runs/diagnostic_matt.zip", "run")
our.condor.run <- read.MFCLRep(unz("run/diagnostic_matt.zip", "plot-10.par.rep"))

## 2  Plot SB and SBF0

xyplot(data~year|area, group=qname,
       data=FLQuants(qts(adultBiomass_nofish(our.condor.run)), qts(adultBiomass(our.condor.run))),
       type="l", as.table=TRUE, main="Our Condor run")

## xyplot(data~year, data=FLQuants(SB(our.condor.run), SBF0(our.condor.run)))

b <- flr2taf(SB(penguin.diagnostic)/1e6, colname="SB")
b0 <- flr2taf(SBF0(penguin.diagnostic)/1e6, colname="SBF0")
pdiag <- merge(b, b0)
pdiag$Depletion <- pdiag$SB / pdiag$SBF0

b <- flr2taf(SB(penguin.grid)/1e6, colname="SB")
b0 <- flr2taf(SBF0(penguin.grid)/1e6, colname="SBF0")
pgrid <- merge(b, b0)
pgrid$Depletion <- pgrid$SB / pgrid$SBF0

b <- flr2taf(SB(web.zip.file)/1e6, colname="SB")
b0 <- flr2taf(SBF0(web.zip.file)/1e6, colname="SBF0")
web <- merge(b, b0)
web$Depletion <- web$SB / web$SBF0

b <- flr2taf(SB(our.condor.run)/1e6, colname="SB")
b0 <- flr2taf(SBF0(our.condor.run)/1e6, colname="SBF0")
our <- merge(b, b0)
our$Depletion <- our$SB / our$SBF0

sb <- data.frame(Year=our$Year, pdiag=pdiag$SB, pgrid=pgrid$SB, web=web$SB, our=our$SB)
depletion <- data.frame(Year=our$Year, pdiag=pdiag$Depletion, pgrid=pgrid$Depletion, web=web$Depletion, our=our$Depletion)
round(sb, 3)
round(depletion, 3)
round(sb$web / sb$our, 2)

plot(SBF0~Year, data=our, type="l", lty=3, ylim=lim(our$SBF0), ylab="Spawning biomass (Mt)")
lines(SB~Year, data=our)

plot(Depletion~Year, data=our, type="l", ylim=lim(our$Depletion))
abline(h=0.2, lty=3)



## 3  Plot SB / SBF0

plot(SBSBF0(our.condor.run), ylim=c(0, 1.05))
plot(flr2taf(SBSBF0(our.condor.run), colname="SBSBF0"), ylim=c(0, 1.05))



library(R4MFCL)
r <- read.rep(unz("run/diagnostic_matt.zip", "plot-10.par.rep"))
ssb <- rowSums(r$AdultBiomass)
ssb.annual <- colMeans(matrix(ssb, nrow=4))
years <- unique(trunc(r$yrs))
out <- data.frame(Year=years, SSB=ssb.annual)
