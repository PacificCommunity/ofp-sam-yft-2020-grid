library(TAF)
library(FLR4MFCL)

rep <- read.MFCLRep("z:/yft/2017/assessment/RefCase/plot-14.par.rep")

taf.png("sb_2017", width=1200)
xyplot(data~year|area, group=qname,
       data=FLQuants(qts(adultBiomass_nofish(rep)/1000), qts(adultBiomass(rep)/1000)),
       type="l", as.table=TRUE, main="2017 assessment", ylab="SB (kt)")
dev.off()
