function [GlobalMin] = FindMin(FolderCOPDTrain,FolderHealthyTrain,FolderCOPDValidation,FolderHealthyValidation)

%%find min for COPD Train
min1 = 100000000;
    numofWaves = 0; 
    dirlist=dir(FolderCOPDTrain);
    for FolderInd=3:numel(dirlist)
        CurrentLevelFolderDirlist=dir([FolderCOPDTrain,'\',dirlist(FolderInd).name]);
        for SampleInd=3:numel(CurrentLevelFolderDirlist)
            CurrentPath=[CurrentLevelFolderDirlist(SampleInd).folder,'\',CurrentLevelFolderDirlist(SampleInd).name];
            if ~strcmp(CurrentPath(end-2:end),'wav')
                continue;
            end
            numofWaves=numofWaves+1;
            
             [rawdata,Fs]=audioread(CurrentPath);
             
        temp = numel(rawdata);
        if temp < min1
           min1 = temp;
        end                 
           
        end
    end
    
    
%% find min for COPD Validation
min2 = 100000000;
    numofWaves = 0; 
    dirlist=dir(FolderCOPDValidation);
    for FolderInd=3:numel(dirlist)
        CurrentLevelFolderDirlist=dir([FolderCOPDValidation,'\',dirlist(FolderInd).name]);
        for SampleInd=3:numel(CurrentLevelFolderDirlist)
            CurrentPath=[CurrentLevelFolderDirlist(SampleInd).folder,'\',CurrentLevelFolderDirlist(SampleInd).name];
            if ~strcmp(CurrentPath(end-2:end),'wav')
                continue;
            end
            numofWaves=numofWaves+1;
            
             [rawdata,Fs]=audioread(CurrentPath);
             
        temp = numel(rawdata);
        if temp < min2
           min2 = temp;
        end                 
           
        end
    end
    
    
    
  %% find min for Healthy Train  
  
 min3 = 100000000;
    numofWaves = 0; 
    dirlist=dir(FolderHealthyTrain);
 
    for SampleInd=3:numel(dirlist)
        CurrentPath=[dirlist(SampleInd).folder,'\',dirlist(SampleInd).name];

            numofWaves=numofWaves+1;   
             [rawdata,Fs]=audioread(CurrentPath);
             
        temp = numel(rawdata);
        if temp < min3
           min3 = temp;
        end                 
 
    end   
    
  
    
 %% find mind for Healthy Validation
   
 min4 = 100000000;
    numofWaves = 0; 
    dirlist=dir(FolderHealthyValidation);
 
    for SampleInd=3:numel(dirlist)
        CurrentPath=[dirlist(SampleInd).folder,'\',dirlist(SampleInd).name];

            numofWaves=numofWaves+1;   
            [rawdata,Fs]=audioread(CurrentPath);
        temp = numel(rawdata);
        if temp < min4
           min4 = temp;
        end                 

    end   
    
  
    
    
if min1<min2
    FirstMin = min1; 
else 
    FirstMin = min2;
end    



if min3<min4
    SecondMin = min3; 
else 
    SecondMin = min4;
end    



if FirstMin<SecondMin
   GlobalMin = FirstMin;
else 
   GlobalMin = SecondMin; 

end


end 
    
    
     