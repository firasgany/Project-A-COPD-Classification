%% COPD-Healthy CLASSIFICATION USING DEEP LEARNING
% In this part, we will train and test a neural network for
% a classification task.
clear; clc

%% Prepare data
validation_percent = 0.3;
[imdsTrain,imdsValidation] = CNNDataPrepareEachArea(validation_percent);

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
    'MiniBatchSize', 128, ...
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
[net] = trainNetwork(imdsTrain,layers,options);


%% Classify validation set

YPred = classify(net,imdsValidation);
YValidation = imdsValidation.Labels;

accuracy = sum(YPred == YValidation)/numel(YValidation)