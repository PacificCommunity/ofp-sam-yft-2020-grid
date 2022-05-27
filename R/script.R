## Plot SB/SBF0, starting with the 2020 diagnostic model

library(TAF)
library(FLR4MFCL)

## 1  Read 2020 assessment rep file

mkdir("run")

penguin.diagnostic.10 <- read.MFCLRep("z:/yft/2020/assessment/ModelRuns/Diagnostic/plot-10.par.rep")
penguin.diagnostic.12 <- read.MFCLRep("z:/yft/2020/assessment/ModelRuns/Diagnostic/plot-12.par.rep")
penguin.diagnostic <- read.MFCLRep("z:/yft/2020/assessment/ModelRuns/Diagnostic/plot-14.par.rep")
penguin.grid <- read.MFCLRep("z:/yft/2020/assessment/ModelRuns/Grid/CondLen_M0.2_Size60_H0.8_Mix2/plot-out.par.rep")
web.zip.file <- read.MFCLRep("https://raw.githubusercontent.com/PacificCommunity/ofp-sam-yft-2020-grid/main/Grid_Models/CondAgeGrowth_Size60_H0.8_Mix2/plot-out.par.rep")
if(!file.exists("run/diagnostic_matt.zip"))
  download("https://github.com/PacificCommunity/ofp-sam-yft-2020-runs/releases/download/runs/diagnostic_matt.zip", "run")
our.condor.run <- read.MFCLRep(unz("run/diagnostic_matt.zip", "plot-10.par.rep"))
john.yft.diag <- read.MFCLRep("c:/x/yft/john_yft_diag/plot-15.par.rep")

## 2  Plot SB and SBF0

xyplot(data~year|area, group=qname,
       data=FLQuants(qts(adultBiomass_nofish(our.condor.run)), qts(adultBiomass(our.condor.run))),
       type="l", as.table=TRUE, main="Our Condor run")

xyplot(data~year, data=FLQuants(SB(our.condor.run), SBF0(our.condor.run)))

b <- flr2taf(SB(penguin.diagnostic.10)/1e3, colname="SB")
b0 <- flr2taf(SBF0(penguin.diagnostic.10)/1e3, colname="SBF0")
pdiag10 <- merge(b, b0)
pdiag10$Depletion <- pdiag10$SB / pdiag10$SBF0

b <- flr2taf(SB(penguin.diagnostic.12)/1e3, colname="SB")
b0 <- flr2taf(SBF0(penguin.diagnostic.12)/1e3, colname="SBF0")
pdiag12 <- merge(b, b0)
pdiag12$Depletion <- pdiag12$SB / pdiag12$SBF0

b <- flr2taf(SB(penguin.diagnostic)/1e3, colname="SB")
b0 <- flr2taf(SBF0(penguin.diagnostic)/1e3, colname="SBF0")
pdiag <- merge(b, b0)
pdiag$Depletion <- pdiag$SB / pdiag$SBF0

b <- flr2taf(SB(penguin.grid)/1e3, colname="SB")
b0 <- flr2taf(SBF0(penguin.grid)/1e3, colname="SBF0")
pgrid <- merge(b, b0)
pgrid$Depletion <- pgrid$SB / pgrid$SBF0

b <- flr2taf(SB(web.zip.file)/1e3, colname="SB")
b0 <- flr2taf(SBF0(web.zip.file)/1e3, colname="SBF0")
web <- merge(b, b0)
web$Depletion <- web$SB / web$SBF0

b <- flr2taf(SB(our.condor.run)/1e3, colname="SB")
b0 <- flr2taf(SBF0(our.condor.run)/1e3, colname="SBF0")
our <- merge(b, b0)
our$Depletion <- our$SB / our$SBF0

sb <- data.frame(Year=our$Year, pdiag10=pdiag10$SB, pdiag12=pdiag12$SB, pdiag=pdiag$SB, pgrid=pgrid$SB, web=web$SB, our=our$SB)
depletion <- data.frame(Year=our$Year, pdiag10=pdiag10$Depletion, pdiag12=pdiag12$Depletion, pdiag=pdiag$Depletion, pgrid=pgrid$Depletion, web=web$Depletion, our=our$Depletion)
round(sb)
round(depletion, 4)

matplot(sb[1], sb[-1], type="l", lty=1, lwd=3, ylim=lim(sb[-1]), xlab="Year", ylab="SB")
matplot(sb[1], sb[-1], type="l", lty=1, lwd=3, xlab="Year", ylab="SB (kt)", xlim=c(2010,2018), ylim=c(1700,2300))
abline(h=seq(1700,2300,by=100), lty=3, col="gray")
round(tail(sb,1))
xyplot(SB~Year, groups=Model, data=taf2long(sb, c("Year","Model","SB")), type="l", ylim=lim(sb[-1]), lwd=3, col=1:6)
xyplot(SB~Year, groups=Model, data=taf2long(sb, c("Year","Model","SB")), subset=Year>=2010, type="l", lwd=3, col=1:6)

matplot(depletion[1], depletion[-1], type="l", lty=1, lwd=3, ylim=lim(depletion[-1]), xlab="Year", ylab="SB/SBF0")

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


## 4  Examine Phases

p00 <- read.MFCLPar("z:/yft/2020/assessment/ModelRuns/Diagnostic/00.par")
p01 <- read.MFCLPar("z:/yft/2020/assessment/ModelRuns/Diagnostic/01.par")
p02 <- read.MFCLPar("z:/yft/2020/assessment/ModelRuns/Diagnostic/02.par")
p03 <- read.MFCLPar("z:/yft/2020/assessment/ModelRuns/Diagnostic/03.par")
p04 <- read.MFCLPar("z:/yft/2020/assessment/ModelRuns/Diagnostic/04.par")
p05 <- read.MFCLPar("z:/yft/2020/assessment/ModelRuns/Diagnostic/05.par")
p06 <- read.MFCLPar("z:/yft/2020/assessment/ModelRuns/Diagnostic/06.par")
p07 <- read.MFCLPar("z:/yft/2020/assessment/ModelRuns/Diagnostic/07.par")
p08 <- read.MFCLPar("z:/yft/2020/assessment/ModelRuns/Diagnostic/08.par")
p09 <- read.MFCLPar("z:/yft/2020/assessment/ModelRuns/Diagnostic/09.par")
p10 <- read.MFCLPar("z:/yft/2020/assessment/ModelRuns/Diagnostic/10.par")
p10a <- read.MFCLPar("z:/yft/2020/assessment/ModelRuns/Diagnostic/10a.par")
p11 <- read.MFCLPar("z:/yft/2020/assessment/ModelRuns/Diagnostic/11.par")
p12 <- read.MFCLPar("z:/yft/2020/assessment/ModelRuns/Diagnostic/12.par")
p12a <- read.MFCLPar("z:/yft/2020/assessment/ModelRuns/Diagnostic/12a.par")
p13 <- read.MFCLPar("z:/yft/2020/assessment/ModelRuns/Diagnostic/13.par")
p14 <- read.MFCLPar("z:/yft/2020/assessment/ModelRuns/Diagnostic/14.par")
pgrid <- read.MFCLPar("z:/yft/2020/assessment/ModelRuns/Grid/CondLen_M0.2_Size60_H0.8_Mix2/out.par")
pzip <- read.MFCLPar("https://raw.githubusercontent.com/PacificCommunity/ofp-sam-yft-2020-grid/main/Grid_Models/CondAgeGrowth_Size60_H0.8_Mix2/out.par")
p <- list(p01, p02, p03, p04, p05, p06, p07, p08, p09,
          p10, p10a, p11, p12, p12a, p13, p14, pgrid, pzip)
names(p) <- c("p01", "p02", "p03", "p04", "p05", "p06", "p07", "p08", "p09",
              "p10", "p10a", "p11", "p12", "p12a", "p13", "p14", "pgrid", "pzip")
ptable <- data.frame(Phase=substring(names(p), 2),
                     npar=sapply(p, n_pars),
                     logL=sapply(p, obj_fun))
rownames(ptable) <- ptable$Phase

r10 <- read.MFCLRep("z:/yft/2020/assessment/ModelRuns/Diagnostic/plot-10.par.rep")
r11 <- read.MFCLRep("z:/yft/2020/assessment/ModelRuns/Diagnostic/plot-11.par.rep")
r12 <- read.MFCLRep("z:/yft/2020/assessment/ModelRuns/Diagnostic/plot-12.par.rep")
r13 <- read.MFCLRep("z:/yft/2020/assessment/ModelRuns/Diagnostic/plot-13.par.rep")
r14 <- read.MFCLRep("z:/yft/2020/assessment/ModelRuns/Diagnostic/plot-14.par.rep")
rgrid <- read.MFCLRep("z:/yft/2020/assessment/ModelRuns/Grid/CondLen_M0.2_Size60_H0.8_Mix2/plot-out.par.rep")
rzip <- read.MFCLRep("https://raw.githubusercontent.com/PacificCommunity/ofp-sam-yft-2020-grid/main/Grid_Models/CondAgeGrowth_Size60_H0.8_Mix2/plot-out.par.rep")

r <- list(r10, r11, r12, r13, r14, rgrid, rzip)
names(r) <- c("r10", "r11", "r12", "r13", "r14", "rgrid", "rzip")
sblatest <- function(x) drop(tail(SBlatest(x), 1))
sbrecent <- function(x) drop(tail(SBrecent(x), 1))
sbsbf0 <- function(x) drop(tail(SBSBF0(x), 1))
rtable <- data.frame(Phase=substring(names(r), 2),
                     SBlatest=sapply(r, sblatest),
                     SBrecent=sapply(r, sbrecent),
                     SBSBF0=sapply(r, sbsbf0))
rownames(rtable) <- rtable$Phase
