function SpecExtractAndSave(RawSamples,Fs,COPDTrainFolder,windowLen)

for SampleInd=1:numel(RawSamples)
    
    CurrRawData=RawSamples{SampleInd};
   
%% Saving Spectrograms in Gray Scale
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    GrayScaleSpec(CurrRawData,windowLen,512,Fs); 
    set(gca,'XTick',[]) % Remove the ticks in the x axis!
    set(gca,'YTick',[]) % Remove the ticks in the y axis!
    set(gca,'Position',[0 0 1 1]) % Make the axes occupy the hole figure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    
%% Saving Spectrograms in Black and White (if used, u need to turn OFF GrayScaleSpec) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%       BlackAndWhiteSpec(CurrRawData);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    
    ImgName = sprintf('%d.png', SampleInd); 
    fullFileName = fullfile(COPDTrainFolder, ImgName);  
    saveas(gcf,fullFileName,'png')
    
    %% Editing the size of the saved Spectrograms
    CurrentPath= [COPDTrainFolder,'\', ImgName];
    I = imread(CurrentPath);
    J = imresize(I, 0.9);
    figure(2);
    imshow(J);
    fullFileName = fullfile(COPDTrainFolder, ImgName); 
    imwrite(J, fullFileName); 	
	
end

end

