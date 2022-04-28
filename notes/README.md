Page 18 in the YFT stock assessment report:

95 length classes (10 to 200 cm in 2 cm bins)

200 weight classes (1 to 200 kg in 1 kg bins)

---

Nick mentioned that it would be good to check if `parest flag 387` was set in
the YFT 2020 assessment, where values 0 and 1 would specify parameter scaling.
This is relevant when switching from the old (2020) to the current (2022) model
executable.

It doesn't look like `parest flag 387` was used in the 2020 assessment.

---

Plots of SB and SBF0:

```{r}
library(FLR4MFCL)
rep17 <- read.MFCLRep("c:/x/yft/2017/YFT_2017_basecase/plot-14.par.rep")
rep20 <- read.MFCLRep("c:/git/PacificCommunity/ofp-sam/yft-2020-runs/Grid_Models/diagnostic_matt/run/End/plot-10.par.rep")
xyplot(data~year|area, group=qname,
       data=FLQuants(qts(adultBiomass_nofish(rep20)), qts(adultBiomass(rep20))),
       type="l", as.table=TRUE, main="2020 assessment")
dev.new()
xyplot(data~year|area, group=qname,
       data=FLQuants(qts(adultBiomass_nofish(rep17)), qts(adultBiomass(rep17))),
       type="l", as.table=TRUE, main="2017 assessment")
```

<img src="ssb_2017.png" width="600px">
<img src="ssb_2020.png" width="600px">

Compared to the 2017 assessment, the 2020 assessment estimates that there is/was
substantial biomass in regions 5 and 6. These southern regions have always had
low catches.
