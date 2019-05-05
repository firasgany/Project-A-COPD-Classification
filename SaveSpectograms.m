function SaveSpectograms(FeaturesVecTrain,FeaturesVecValidation,LenOfRawSamplesCopdTrain,LenOfRawSamplesCopdValidation)
 
COPDTrainFolder = '..\Data\trainSpectograms\copd\';
COPDvalidationFolder='..\Data\validationSpectograms\copd\';
healthyTrainFolder='..\Data\trainSpectograms\healthy\';
healthyValidationFolder='..\Data\validationSpectograms\healthy\';
 
%save Copd train Spectograms
for CopdInd =1:LenOfRawSamplesCopdTrain
      im = FeaturesVecTrain(CopdInd);
      tempMat = cell2mat(im);
      ImgName = sprintf('Copd Train %d.png', CopdInd); 
      fullFileName = fullfile(COPDTrainFolder, ImgName); 
      imwrite(tempMat, fullFileName); 
end
 
%save Healthy train Spectograms
for HealthyInd =LenOfRawSamplesCopdTrain+1:numel(FeaturesVecTrain)
      im = FeaturesVecTrain(HealthyInd);
      tempMat = cell2mat(im);
      ImgName = sprintf('Healthy Train %d.png', HealthyInd); 
      fullFileName = fullfile(healthyTrainFolder, ImgName); 
      imwrite(tempMat, fullFileName); 
end
 
%save Copd validation Spectograms
for CopdInd =1:LenOfRawSamplesCopdValidation
      im = FeaturesVecValidation(CopdInd);
      tempMat = cell2mat(im);
      ImgName = sprintf('Copd Validation %d.png', CopdInd); 
      fullFileName = fullfile(COPDvalidationFolder, ImgName); 
      imwrite(tempMat, fullFileName); 
end
 
%save Healthy validation Spectograms
for HealthyInd =LenOfRawSamplesCopdValidation+1:numel(FeaturesVecValidation)
      im = FeaturesVecValidation(HealthyInd);
      tempMat = cell2mat(im);
      ImgName = sprintf('Healthy Validation %d.png', HealthyInd); 
      fullFileName = fullfile(healthyValidationFolder, ImgName); 
      imwrite(tempMat, fullFileName); 
end