function [imdsTrain,imdsValidation] = CNNDataPrepareEachArea(CNNOnCurrArea)

%% Load Dataset

% set dataset path
CurrAreaPath = ['..\CNNDATA - BY AREA\' ,CNNOnCurrArea, '\validation'];

 imdsValidation = imageDatastore(CurrAreaPath ...
     ,'IncludeSubfolders',true,'labelSource','foldernames');
 
 CurrAreaPath = ['..\CNNDATA - BY AREA\' ,CNNOnCurrArea, '\train'];

 imdsTrain = imageDatastore(CurrAreaPath ...
     ,'IncludeSubfolders',true,'labelSource','foldernames');
 

end

