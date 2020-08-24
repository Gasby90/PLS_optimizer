# PLS_optimizer
This script can help choosing the right combination of pre-processing algorithms for multivariate regression (i.e. Partial Least Squares  regressions)  problems and an appropriate number of latent variables.
For each preprocessing combination nc models are calibrated (with nc being the number of latent variables; default value is set from 1 to 4).
Regreession results are stored in a cell (i.e. 'Pre-processing comb., LV, Bias and RMSEC).
The PLS_otimizer works only with PLS_toolbox (Ver. 8.2.1 or above) in MATLAB® (MATLAB R2019a or above). 

INPUT
X_cal= dataset X (matrix of predictors)
Y_cal= dataset Y (matrix of dependent variables)

OUTPUT
results= cell: 'Pre-processing comb., LV, Bias and RMSEC
