

windowLen = [64, 128 , 256, 512, 1024, 2048]; % length in mili seconds
validation_percent = 0.4;


%add for for preparedata with different windows length 


for SimIndex = 2:6 

% %windowLen = [10, 15, 20, 25, 30, 50, 70, 90]; % length in mili seconds
% windowLen = [64, 128 , 256, 512, 1024, 2048];
% SimIndex=5;
COPDTrainFolder = '..\CNNDATA\train\copd\';
SpecExtractAndSave(RawSamplesCopdTrain,Fs,COPDTrainFolder,windowLen(SimIndex))

COPDvalidationFolder='..\CNNDATA\validation\copd\';
SpecExtractAndSave(RawSamplesCopdValidation,Fs,COPDvalidationFolder,windowLen(SimIndex))


healthyTrainFolder = '..\CNNDATA\train\healthy\';
SpecExtractAndSave(RawSamplesHealthyTrain,Fs,healthyTrainFolder,windowLen(SimIndex))


healthyValidationFolder='..\CNNDATA\validation\healthy\';
SpecExtractAndSave(RawSamplesHealthyValidation,Fs,healthyValidationFolder,windowLen(SimIndex))

% validation_percent=0.3;
% windowLen = [10, 15, 20, 25, 30, 50, 70, 90]; % length in mili seconds
% SimIndex=1;
COPDClassificationDL(windowLen(SimIndex),validation_percent);

end
