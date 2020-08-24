%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PLS_optimizer v.0.1 %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% Riccardo Gasbarrone (August 2020)%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script can help choosing the right combination of pre-processing
% algorithms for multivariate regression (i.e. Partial Least Squares  regressions) 
% problems and an appropriate number of latent variables.
% For each preprocessing combination nc models are calibrated 
%(with nc being the number of latent variables; default value is set from 1 to 4).
%Regreession results are stored in a cell (i.e. 'Pre-processing comb., LV, Bias and RMSEC)
%%%The PLS_otimizer works only with PLS_toolbox (Ver. 8.2.1 or above) in 
%MATLAB® (MATLAB R2019a or above). 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%INPUT
%X_cal= dataset X (matrix of predictors)
%Y_cal= dataset Y (matrix of dependent variables)
%%OUTPUT
%results= cell: 'Pre-processing comb., LV, Bias and RMSEC
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
options=pls('option');
options.display='off';
options.plots='none';
list = preprocess('initcatalog')
k=1;
disp(['n.' '	' 'r-prepro' '	'	'NC' '	' 'bias' '	' 'rmsec' ' ' 'r2c']);
for rp=1:22; % rows of the preprocessing combinations.
    for nc=1:4; % number of latent variables of the model.
        if rp==1
            rpt='Mean Center'; % Remove mean offset from each variable.
        end
        if rp==2
            rpt='MSC (Mean, w/intercept)';% Multiplicative Signal Correction - weighted normalization and baseline removal.
        end
        if rp==3
            rpt='Detrend'; % Remove mean offset from each sample (row).
        end
        if rp==4
            rpt='SNV'; % Standard Normal Variate scaling of samples (weighted normalization)
        end
        if rp==5
            rpt='First Derivative (order: 2, window: 15 pt, tails: polyinterp)'; % Savitzky-Golay first derivatives.
        end
        if rp==6
            rpt='Second Derivative (order: 2, window: 15 pt, tails: polyinterp)'; % Savitzky-Golay second derivatives.
        end
        if rp==7
            rpt='Baseline (Automatic Weighted Least Squares)'; % Weighted Least Squares automatic baseline removal.
        end
        if rp==8
            rpt='First derivative + Mean Center';% 1st Derivative (order: 2, window: 15 pt, tails: polyinterp) + Mean Center.
        end
        if rp==9
            rpt='Second derivative + Mean Center';% 2nd Derivative (order: 2, window: 15 pt, tails: polyinterp) + Mean Center.
        end
        if rp==10
            rpt='Baseline + Mean Center'; % Baseline (Automatic Weighted Least Squares, order=2) + Mean Center.
        end
        if rp==11
            rpt='SNV + Mean Center'; % SNV + Mean Center.
        end
        if rp==12
            rpt='SNV + Detrend + Mean Center'; % SNV + Detrend + Mean Center.
        end
        if rp==13
            rpt='SNV + first derivative + Mean Center'; % SNV + 1st Derivative (order: 2, window: 15 pt, tails: polyinterp) + Mean Center.
        end
        if rp==14
            rpt='SNV + second derivative + Mean Center'; % SNV + 2nd Derivative (order: 2, window: 15 pt, tails: polyinterp) + Mean Center.
        end
        if rp==15
            rpt='msc + Mean Center'; % MSC (Mean, w/intercept) + Mean Center.
        end
        if rp==16
            rpt='msc + first derivative + Mean Center'; % MSC (Mean, w/intercept) + 1st Derivative (order: 2, window: 15 pt, tails: polyinterp) + Mean Center.
        end
        if rp==17
            rpt='MSC + smooth + Mean Center'; % MSC (Mean, w/intercept) + Smoothing (order: 0, window: 15 pt, tails: polyinterp) + Mean Center.
        end
        if rp==18
            rpt='OSC + Mean Center'; % OSC (Orthogonal Signal Correction) + Mean Center.
        end
        if rp==19
            rpt='PQN + Mean Center'; % PQN + Mean Center.
        end
        if rp==20
            rpt='PQN + smooth + Mean Center'; % PQN + Smoothing (order: 0, window: 15 pt, tails: polyinterp) + Mean Center.
        end
        if rp==21
            rpt='PQN + first derivative + Mean Center'; % PQN + 1st Derivative (order: 2, window: 15 pt, tails: polyinterp) + Mean Center.
        end
        if rp==22
            rpt='PQN + second derivative + Mean Center'; % PQN + 2nd Derivative (order: 2, window: 15 pt, tails: polyinterp) + Mean Center.
        end
        
        options.preprocessing={[rpt] ['autoscale']};
        model=pls(X_cal, Y_cal, nc, options);
        numberc(k,1)=(nc);
        bias(k,1)=model.bias(1,nc);
        rmsec(k,1)=model.rmsec(1,nc);
        r2c(k,1)=model.r2c(1,nc);
        prep(k,1)={[rpt]};
        % results(k,1)={[k, rpt, bias(k,1), rmsec(k,1), r2c(k,1)]};
        disp([int2str(k) ' ' rpt ' ' int2str(nc) ' ' num2str(bias(k,1)) ' ' num2str(rmsec(k,1)) ' ' num2str(r2c(k,1))]);
        k=k+1;
    end
end	

results={ 'Pre-processing comb.',	'LV', 'Bias', 'RMSEC', 'r__2_C'; prep, numberc, bias, rmsec, r2c}; % shows the results.
clear 'model'  'numberc'  'bias'  'rmsec'  'r2c' 'prep'