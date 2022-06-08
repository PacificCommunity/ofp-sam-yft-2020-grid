library(TAF)
library(FLR4MFCL)

rep <- read.MFCLRep("z:/yft/2020/assessment/ModelRuns/Diagnostic/plot-14.par.rep")

taf.png("sb_2020", width=1200)
xyplot(data~year|area, group=qname,
       data=FLQuants(qts(adultBiomass_nofish(rep)/1000), qts(adultBiomass(rep)/1000)),
       type="l", as.table=TRUE, main="2020 assessment", ylab="SB (kt)")
dev.off()
