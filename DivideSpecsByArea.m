% this function should be applied only on files that were saved.
function DivideSpecsByArea(windowLen)
%each time we do load for 
%Train COPD- little data - tmpAreaVec we 
%get in the workSpace tmpAreaVec
CurrAreaSamples = {};
%for Train COPD
% 
% load('Train COPD- little data.mat');
%load('Train COPD');

%for letter = 'A':'N'
    letter = 'A';
    Fs=4000;
    windowLen=128;
Index = find(contains(tmpAreaVec,letter));
 for CurrIndex = 1:numel(Index);
     CurrAreaSamples= [CurrAreaSamples; RawSamplesCopdTrain(Index(CurrIndex))];
 end 
 
COPDTrainFolder = ['..\CNNDATA - BY AREA\' ,letter,'\train','\copd'];
SpecExtractAndSave(CurrAreaSamples,Fs,COPDTrainFolder,windowLen);

CurrAreaSamples = {};
%end

%TrainCopdCurrIDVec = PateintIDVec(Index);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load('Train Healthy');
for letter = 'A':'N'
Index = find(contains(tmpAreaVec,letter));
 for CurrIndex = 1:numel(Index);
     CurrAreaSamples= [CurrAreaSamples; RawSamplesHealthyTrain(Index(CurrIndex))];
 end 
 
COPDTrainFolder = ['..\CNNDATA - BY AREA\' ,letter,'\train','\healthy'];
SpecExtractAndSave(CurrAreaSamples,Fs,COPDTrainFolder,windowLen);

CurrAreaSamples = {};
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('Validation COPD');
for letter = 'A':'N'
    %letter = 'A'; 
Index = find(contains(tmpAreaVec,letter));
 for CurrIndex = 1:numel(Index);
     CurrAreaSamples= [CurrAreaSamples; RawSamplesCopdValidation(Index(CurrIndex))];
 end 
 
COPDTrainFolder = ['..\CNNDATA - BY AREA\' ,letter,'\validation','\copd'];
SpecExtractAndSave(CurrAreaSamples,Fs,COPDTrainFolder,windowLen);

CurrAreaSamples = {};
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


load('validation Healthy');
for letter = 'A':'N'
Index = find(contains(tmpAreaVec,letter));
 for CurrIndex = 1:numel(Index);
     CurrAreaSamples= [CurrAreaSamples; RawSamplesHealthyValidation(Index(CurrIndex))];
 end 
 
COPDTrainFolder = ['..\CNNDATA - BY AREA\' ,letter,'\validation','\healthy'];
SpecExtractAndSave(CurrAreaSamples,Fs,COPDTrainFolder,windowLen);

CurrAreaSamples = {};

ValIdVector={};
ValIdVector = [ValIdVector;tmpPateintIDVec(Index)];

% 
% letter ='A';
% Index = find(contains(AreaVec,letter));
% ValIDVec = PateintIDVec(Index);


end



%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


end


