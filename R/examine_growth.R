library(FLR4MFCL)

condage <- read.MFCLBiol("../Grid_Models/CondAgeGrowth_Size60_H0.8_Mix2/out.par")
growth(condage)
growth_devs_age(condage)

modal <- read.MFCLBiol("../Grid_Models/ModalGrowth_Size60_H0.8_Mix2/out.par")
growth(modal)
growth_devs_age(modal)

otolith <- read.MFCLBiol("../Grid_Models/OtolithGrowth_Size60_H0.8_Mix2/out.par")
growth(otolith)
growth_devs_age(otolith)
