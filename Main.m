% clc;
% clear all;
% 
%% Load raw data + labels:
% %% big data
% FolderTrainCOPD='..\DATACompressed\COPDtrain\';
% FolderValCOPD='..\DATACompressed\COPDvalidation\';
% 
% FolderTrainHealthy='..\DATACompressed\healthyTrain\';
% FolderValHealthy='..\DATACompressed\healthyValidation\';
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %% little data
FolderTrainCOPD='..\DATACompressed - little data\COPDtrain\';
FolderValCOPD='..\DATACompressed - little data\COPDvalidation\';
FolderTrainHealthy='..\DATACompressed - little data\healthyTrain\';
FolderValHealthy='..\DATACompressed - little data\healthyValidation\';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Min = FindMin(FolderTrainCOPD,FolderTrainHealthy,FolderValCOPD,FolderValHealthy);
windowLen = [64, 128 , 256, 512, 1024, 2048];
SimIndex=2; % we ran over all parameters and saw that WindowLen = 128 is the best. 

%%pre-proccessing
[AreaVec,PathVec,LabelVec,TrainOrValidationVec,RawSamples,PateintIDVec,LevelVec,Fs] =...
PrepareData(Min,FolderTrainCOPD, FolderValCOPD, FolderTrainHealthy, FolderValHealthy, windowLen(SimIndex));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Code for performing the CNN all areas:
load('Train COPD');
load('Train Healthy');
load('validation Healthy');
load('Validation COPD');

validation_percent = 0.4;
windowLen = [64, 128 , 256, 512, 1024, 2048];
SimIndex=2; %best window length that we found.
COPDTrainFolder = '..\CNNDATA\train\copd\';
SpecExtractAndSave(RawSamplesCopdTrain,Fs,COPDTrainFolder,windowLen(SimIndex));

COPDvalidationFolder='..\CNNDATA\validation\copd\';
SpecExtractAndSave(RawSamplesCopdValidation,Fs,COPDvalidationFolder,windowLen(SimIndex))

healthyTrainFolder = '..\CNNDATA\train\healthy\';
SpecExtractAndSave(RawSamplesHealthyTrain,Fs,healthyTrainFolder,windowLen(SimIndex))

healthyValidationFolder='..\CNNDATA\validation\healthy\';
SpecExtractAndSave(RawSamplesHealthyValidation,Fs,healthyValidationFolder,windowLen(SimIndex))

COPDClassificationAllAreas(validation_percent);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                     

%% Code for performing the CNN on each Area:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear all;
% pre-proccessing
windowLen = [64, 128 , 256, 512, 1024, 2048];
validation_percent = 0.3;
index=2; 
DivideSpecsByArea(windowLen(index));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[ValidationSetIDVec] = GetValidationIDvec('A'); 
%random letter in order to get number of patients "lengthofPatientsIDVec"
%later we run a for loop for all Areas.
UniquePatientIDs=unique(ValidationSetIDVec,'stable');
lengthofPatientsIDVec= numel(UniquePatientIDs);
%save('NumOfValPatients','lengthofPatientsIDVec');


NumOfAreas = 14; 
load('NumOfValPatients');
PacientsLoss=zeros(lengthofPatientsIDVec,NumOfAreas);
%save ('PatientLossByArea' ,'PacientsLoss');
LossVector=zeros(NumOfAreas,1);


AreaIndex = 1;
for CNNOnCurrArea = 'G':'G' 
    [ValidationSetIDVec] = GetValidationIDvec(CNNOnCurrArea);
    UniquePatientIDs=unique(ValidationSetIDVec,'stable');
    [PacientsLoss,LossVector]=COPDClassificationEachArea(CNNOnCurrArea,AreaIndex,PacientsLoss,LossVector,UniquePatientIDs,ValidationSetIDVec);
    AreaIndex = AreaIndex+1;
end    

save('PacientsLoss');
save('LossVector');

%weight vector
load('LossVector');
LossVectorEffect =1-LossVector; 
%we normalize but the sum of the vector so we get LossVectorEffect with 
%sum=1
LossVectorEffect = LossVectorEffect./sum(LossVectorEffect);
sum(LossVectorEffect)

%PatientPredictCell: a vector of predictions for each person!
 PatientPredictCell = {};
 for PacientsLossRow = 1: numel(PacientsLoss(:,1)) 
 PatientPredictCell=([PatientPredictCell; dot((LossVectorEffect') ,  PacientsLoss(PacientsLossRow,:))]);
 end 

   C = {'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
        'copd'
      ;'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
       'healthy'
      };

   labevector = categorical(C);
   [X,Y] = perfcurve(labevector, cell2mat(PatientPredictCell), 'copd');
   plot(X,Y); 
 
 
[xx,yy,th,auc] = perfcurve(labevector,cell2mat(PatientPredictCell),'copd'); %auc= area under the curve, The maximum AUC is 1, which corresponds to a perfect classifier. 
set(0,'UserData',[th,xx,yy]);
rocFig = figure(); plot(xx,yy)
xlabel('False positive rate') 
ylabel('True positive rate')
title(sprintf('for all Areas : ROC for Classification (area under the curve = %g)',auc));
dcm = datacursormode( gcf);
dcm.UpdateFcn = @updateDataCursor;

%%

numericalLabels= strcmp(cellstr(imdsValidation.Labels),'copd');

ValidationPatientsLabel=numericalLabels;
TotalPredictionsScores=scores;

Hist1Fig = figure(); 
Patients0Inds=find(ValidationPatientsLabel==0);
HealthyScores=TotalPredictionsScores(Patients0Inds);
Patients1Inds=find(ValidationPatientsLabel==1);
COPDScores=TotalPredictionsScores(Patients1Inds);
GridVec=linspace(-1,1,50);
[c0,x0]=hist(HealthyScores,GridVec);
[c1,x1]=hist(COPDScores,GridVec);
plot(GridVec,c0/length(c0),'b');hold on;
plot(GridVec,c1/length(c1),'r');hold on;
legend('Healthy','COPD');
title('for Area %s : Scores distribution for Healthy and COPD');

%another way:
Hist2Fig = figure(); 
h1 = histogram(HealthyScores,GridVec);
hold on
h2 = histogram(COPDScores,GridVec);
legend('Healthy','COPD');
title('for Area %s : Scores distribution for Healthy and COPD');


% disp(sprintf('-----------------------------'));
% disp(sprintf('FINISHED SIMULATION!'));
% disp(sprintf('-----------------------------'));

