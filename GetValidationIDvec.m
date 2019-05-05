function [ValidationSetIDVec] = GetValidationIDvec(CNNOnCurrArea)

% this function helps us know get a vector that includes the indexes 
% of the Spectrogram segments that are related to each area

load('validation Healthy');

ValHealthyTmpAreaVec = tmpAreaVec;
ValHealthyTmpIDvec = tmpPateintIDVec;

load('Validation COPD');

ValCOPDTmpAreaVec = tmpAreaVec;
ValCOPDTmpIDVec = tmpPateintIDVec;

%save ('ValidationAreaIDvecs', 'ValHealthyTmpAreaVec','ValHealthyTmpIDvec', 'ValCOPDTmpAreaVec', 'ValCOPDTmpIDVec');
%load ('ValidationAreaIDvecs');

ValCOPDIndexes = find(contains(ValCOPDTmpAreaVec,CNNOnCurrArea));
%first we concatenate the COPD.
ValCOPDIdVec = ValCOPDTmpIDVec(ValCOPDIndexes);
ValCopdIdVecLength = numel(ValCOPDIdVec);

ValHealthyIndexes = find(contains(ValHealthyTmpAreaVec,CNNOnCurrArea));
%second we concatenate the Healthy. 
ValHealthyVec = ValHealthyTmpIDvec(ValHealthyIndexes);
ValHealthyIdVecLength = numel(ValHealthyVec);

%% in the future this will be the TestSet:
ValidationSetIDVec = [ValCOPDIdVec ; ValHealthyVec]; 



end


