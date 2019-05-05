function [PacientsLoss,LossVector] = COPDClassificationEachArea(CNNOnCurrArea,AreaIndex,PacientsLoss,LossVector,UniquePatientIDs,ValidationSetIDVec) 

[imdsTrain,imdsValidation] = CNNDataPrepareEachArea(CNNOnCurrArea);

temp1 = imdsValidation.Labels;
imdsValidation.Files =  natsortfiles(imdsValidation.Files);
imdsValidation.Labels =temp1; 

temp2 = imdsTrain.Labels;
imdsTrain.Files =  natsortfiles(imdsTrain.Files);
imdsTrain.Labels =temp2; 

%% Set model options
options = trainingOptions('sgdm', ...
    'InitialLearnRate', 0.001, ...    
    'MaxEpochs',50, ...
    'L2Regularization',0.05, ...
    'ValidationData',imdsValidation, ... \\{Xval,Yval}
    'ValidationFrequency',10, ...
    'Verbose',true, ...
    'VerboseFrequency', 50, ...
    'Plots','training-progress');
%'MiniBatchSize', 64, ...
img = readimage(imdsTrain,1); %% read an arbitary image from train to know the current size
 
%% Layers 
%%we should do a for loop for every possible image size.

layers = [
imageInputLayer(size(img))
convolution2dLayer(3,32,'Stride', 2, 'Padding', 'same' ) %[3,3] filter size. 32 filters.
batchNormalizationLayer %%we use it between Covolution layer and non-linearity.
reluLayer
dropoutLayer(0.3)
maxPooling2dLayer(2,'Stride',1) %%PoolSize [2,2], Stride [2,2]
convolution2dLayer(3,64,'Stride',2 , 'Padding', 2) %% [3,3] filter size. 64 filters.
convolution2dLayer(3,128,'Stride',2 , 'Padding', 2) %% [3,3] filter size. 64 filters.
maxPooling2dLayer(2,'Stride',2) %%PoolSize [2,2], 
fullyConnectedLayer(2)
softmaxLayer
classificationLayer

]


%% Train network

[net, traininfo] = trainNetwork(imdsTrain,layers,options);

save('net');
save('traininfo');

 % for the weights vector:
 %we are interested in the Loss of Validation.
 meanArealLoss=traininfo.ValidationLoss(end);
 % we took the last element because we want the number that describes
 % where we stopped the training. 
 LossVector(AreaIndex)=meanArealLoss;
%% Classify validation set
%load ('net');
[Ypred,tmp] = classify(net,imdsValidation);
%we take now the first row, (why?).
%left column are scores for COPD, right column are scores for Healthy.
scores=tmp(:,1);

for PatientInd=1:numel(UniquePatientIDs)
CurrPatientId = UniquePatientIDs{PatientInd};
currRelevantFramesInd=find(strcmp(ValidationSetIDVec,CurrPatientId));
PacientsLoss(PatientInd,AreaIndex) = sum(scores(currRelevantFramesInd))/numel(currRelevantFramesInd);
end

YValidation = imdsValidation.Labels; 
accuracy = sum(Ypred == YValidation)/numel(YValidation);

%in order not to get floating point error, scores must be 1 column (left one)
  [X,Y] = perfcurve(YValidation, scores, 'copd');
  plot(X,Y);
% STFTwindowLen =120; %this is only an example, later we enter WindowLen As parameter.
% disp(sprintf('accuracy for window length %g is : %g\n', STFTwindowLen, accuracy));

%%
AucVector = {} ; 

[xx,yy,th,auc] = perfcurve(imdsValidation.Labels,scores,'copd'); %auc= area under the curve, The maximum AUC is 1, which corresponds to a perfect classifier. 
AucVector  = [AucVector ; auc]; 
set(0,'UserData',[th,xx,yy]);
rocFig = figure(); plot(xx,yy)
xlabel('False positive rate') 
ylabel('True positive rate')
title(sprintf('for Area %s: ROC for Classification (area under the curve = %g)',CNNOnCurrArea,auc));
dcm = datacursormode( gcf);
dcm.UpdateFcn = @updateDataCursor;



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
end