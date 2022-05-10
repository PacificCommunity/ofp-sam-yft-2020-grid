# Progress Towards Diagnostic Model

(that we can run and extend)

## Three Sources of the Diagnostic Model

Source             |         MB | doitall | Phases   | par     | rep              | Notes                              | To Run on WSL
------------------ | ---------- | ------- | -------- | ------- | ---------------- | ---------------------------------- | -----------------------------------------------------------------------------
Penguin diagnostic |       2892 | Full    | 12       | 14.par  | plot-14.par.rep  | Penguin diagnostic                 | Remove PATH, export MFCL, remove cd, comment out 'exit' calls
Penguin grid       |        377 | Minimal | Only one | out.par | plot-out.par.rep | Penguin grid, quite similar to web | Remove PATH, export MFCL, remove cd
Web zip file       |         16 | Minimal | Only one | out.par | plot-out.par.rep | From the web                       | Add yft.age_length and mfclo64, dos2unix, remove PATH, export MFCL, remove cd
Our Condor run     |  21 -> 442 | Full    | 12       | 10.par  | plot-10.par.rep  | Under current development          | We're running on Condor

Penguin diagnostic = `Z:\yft\2020\assessment\ModelRuns\Diagnostic`

Penguin grid = `Z:\yft\2020\assessment\ModelRuns\Grid\CondLen_M0.2_Size60_H0.8_Mix2`

Web zip file = https://oceanfish.spc.int/en/ofpsection/sam/sam/216-yellowfin-assessment-results#2020

Our Condor run =
https://github.com/PacificCommunity/ofp-sam-yft-2020-grid/tree/main/Our_Runs/diagnostic_matt
(input) and
https://github.com/PacificCommunity/ofp-sam-yft-2020-grid/releases/download/runs/diagnostic_matt.zip
(output)
