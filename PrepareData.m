function [AreaVec,PathVec,LabelVec,TrainOrValidationVec,RawSamples,PateintIDVec,LevelVec,Fs] = ...
         PrepareData(Min, FolderTrainCOPD, FolderValCOPD, FolderTrainHealthy, FolderValHealthy,windowLen)

PateintIDVec={};
LabelVec=[];
LevelVec=[]; %for healthy=-1, for COPD:0-4 (4=X)
TrainOrValidationVec=[];%Train=1, Validation=2
AreaVec={};
PathVec={};
RawSamples={};
RawSamplesCopdTrain={};
RawSamplesHealthyValidation={};
RawSamplesCopdValidation={};
RawSamplesHealthyTrain= {};

%% we need to return these values for the Save Spectogram for saving.
%% values: CopdSegmentsTrain,CopdSegmentsValidation

%% Train COPD
[tmpAreaVec,tmpPathVec,tmpLabelVec,tmpTrainOrValidationVec,tmpRawSamples,tmpPateintIDVec,tmpLevelVec,Fs] = ...
DataExtractorFromFolders(Min, FolderTrainCOPD,1,1);


%CopdSegmentsTrain = OverallCopdSegments;
%(because here we used the file FolderTrainCOPD)

PateintIDVec=[PateintIDVec;tmpPateintIDVec];
LabelVec=[LabelVec;tmpLabelVec];
LevelVec=[LevelVec;tmpLevelVec]; 
TrainOrValidationVec=[TrainOrValidationVec;tmpTrainOrValidationVec];
AreaVec=[AreaVec;tmpAreaVec];
PathVec=[PathVec;tmpPathVec];
AreaVecCopdTrain = [tmpAreaVec];
RawSamplesCopdTrain = [tmpRawSamples];

COPDTrainFolder = '..\CNNDATA\train\copd\'; 
SpecExtractAndSave(RawSamplesCopdTrain,Fs,COPDTrainFolder,windowLen)

save('Train COPD- little data.mat');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Validation COPD

[tmpAreaVec,tmpPathVec,tmpLabelVec,tmpTrainOrValidationVec,tmpRawSamples,tmpPateintIDVec,tmpLevelVec,Fs] = ...
DataExtractorFromFolders(Min,FolderValCOPD,2,1);

PateintIDVec=[PateintIDVec;tmpPateintIDVec];
LabelVec=[LabelVec;tmpLabelVec];
LevelVec=[LevelVec;tmpLevelVec]; 
TrainOrValidationVec=[TrainOrValidationVec;tmpTrainOrValidationVec];
AreaVec=[AreaVec;tmpAreaVec];
PathVec=[PathVec;tmpPathVec];
AreaVecCopdValidation = [tmpAreaVec];
RawSamplesCopdValidation = [tmpRawSamples];

COPDvalidationFolder='..\CNNDATA\validation\copd\';
SpecExtractAndSave(RawSamplesCopdValidation,Fs,COPDvalidationFolder,windowLen)

save('Validation COPD- little data.mat');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Train Healthy
[tmpAreaVec,tmpPathVec,tmpLabelVec,tmpTrainOrValidationVec,tmpRawSamples,tmpPateintIDVec,tmpLevelVec,Fs] =...
DataExtractorFromFolders(Min,FolderTrainHealthy,1,0);

PateintIDVec=[PateintIDVec;tmpPateintIDVec];
LabelVec=[LabelVec;tmpLabelVec];
LevelVec=[LevelVec;tmpLevelVec]; 
TrainOrValidationVec=[TrainOrValidationVec;tmpTrainOrValidationVec];
AreaVec=[AreaVec;tmpAreaVec];
PathVec=[PathVec;tmpPathVec];
AreaVecHealthyTrain = [tmpAreaVec];
RawSamplesHealthyTrain = [tmpRawSamples];

healthyTrainFolder='..\CNNDATA\train\healthy\';
SpecExtractAndSave(RawSamplesHealthyTrain,Fs,healthyTrainFolder,windowLen)

save('Train Healthy- little data.mat')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%validation Healthy. 

[tmpAreaVec,tmpPathVec,tmpLabelVec,tmpTrainOrValidationVec,tmpRawSamples,tmpPateintIDVec,tmpLevelVec,Fs] = ...
DataExtractorFromFolders(Min,FolderValHealthy,2,0);

PateintIDVec=[PateintIDVec;tmpPateintIDVec];
LabelVec=[LabelVec;tmpLabelVec];
LevelVec=[LevelVec;tmpLevelVec]; 
TrainOrValidationVec=[TrainOrValidationVec;tmpTrainOrValidationVec];
AreaVec=[AreaVec;tmpAreaVec];
PathVec=[PathVec;tmpPathVec];
AreaVecHealthyValidation = [tmpAreaVec];
RawSamplesHealthyValidation = [tmpRawSamples];


healthyValidationFolder='..\CNNDATA\validation\healthy\';
SpecExtractAndSave(RawSamplesHealthyValidation,Fs,healthyValidationFolder,windowLen)

save('validation Healthy- little data.mat')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




