function [AreaVec,PathVec,LabelVec,TrainOrValidationVec,RawSamples,PateintIDVec,LevelVec,Fs] =...
         DataExtractorFromFolders(Min,FolderToExtractData,TrainOrValidationFlag,LabelFlag)
%
PateintIDVec={};
LabelVec=[];
LevelVec=[]; %for healthy=-1, for COPD:0-4 (4=X)
TrainOrValidationVec=[];%Train=1, Validation=2
AreaVec={};
PathVec={};
RawSamples={};
if LabelFlag==1
    OverallCopdSegments=0;
    dirlist=dir(FolderToExtractData);
    for FolderInd=3:numel(dirlist)
        CurrentLevelFolderDirlist=dir([FolderToExtractData,'\',dirlist(FolderInd).name]);
        for SampleInd=3:numel(CurrentLevelFolderDirlist)
            CurrentPath=[CurrentLevelFolderDirlist(SampleInd).folder,'\',CurrentLevelFolderDirlist(SampleInd).name];
            if ~strcmp(CurrentPath(end-2:end),'wav')
                continue;
            end
            
             [rawdata,Fs]=audioread(CurrentPath);
            NumberOfSamples = numel(rawdata); 
            NumberOfSegments = ceil((NumberOfSamples/Min));
%             fprintf("number of segments COPD: %g\n",NumberOfSegments);
            
%        tmp1= strfind(CurrentPath,'\'); tmp2= strfind(CurrentPath,' ');
%        %PateintIDVec=[PateintIDVec(:);CurrentPath(tmp1(end)+1:tmp2(end))];
%        B = cell2mat(PateintIDVec)



         for SplitIndex=1:NumberOfSegments

             AreaVec=[AreaVec;CurrentPath(end-4)];
             PathVec=[PathVec;CurrentPath];
             tmp1= strfind(CurrentPath,'\'); tmp2= strfind(CurrentPath,' ');
             PateintIDVec=[PateintIDVec(:);CurrentPath(tmp1(end)+1:tmp2(end))];
             LabelVec=[LabelVec;LabelFlag];
             if dirlist(FolderInd).name(end)~='X'
                LevelVec=[LevelVec;str2num(dirlist(FolderInd).name(end))];
             else
                LevelVec=[LevelVec;4];
             end
             TrainOrValidationVec=[TrainOrValidationVec;TrainOrValidationFlag];
            
        end  
      
     OverallCopdSegments = OverallCopdSegments + NumberOfSegments;  
      
   rawdata = SplitArrayWithOverlap(rawdata,Min,NumberOfSamples,NumberOfSegments);
   RawSamples=[RawSamples;rawdata];
        
        
        end
    end
    

%     fprintf("num of overallcopdSegments %g\n",OverallCopdSegments);
else
    
    OverallHealthySegments = 0;
    dirlist=dir(FolderToExtractData);
    for SampleInd=3:numel(dirlist)
        CurrentPath=[dirlist(SampleInd).folder,'\',dirlist(SampleInd).name];
        if ~strcmp(CurrentPath(end-2:end),'wav')
            continue;
        end
        
      [rawdata,Fs]=audioread(CurrentPath);
       NumberOfSamples = numel(rawdata); 
      NumberOfSegments = ceil((NumberOfSamples/Min));
     % fprintf("number of segments Healthy: %g\n",NumberOfSegments);

      
       %  fprintf("ID is %s\n",dirlist(FolderInd).name);

    for SplitIndex=1:NumberOfSegments

        AreaVec=[AreaVec;CurrentPath(end-4)];
        PathVec=[PathVec;CurrentPath];
        
        tmp1= strfind(CurrentPath,'\'); tmp2= strfind(CurrentPath,' ');
        PateintIDVec=[PateintIDVec(:);CurrentPath(tmp1(end)+1:tmp2(end))];
        LabelVec=[LabelVec;LabelFlag];
        LevelVec=[LevelVec;-1];
        TrainOrValidationVec=[TrainOrValidationVec;TrainOrValidationFlag];
      end  
        
        
   OverallHealthySegments = OverallHealthySegments+NumberOfSegments;    
   rawdata = SplitArrayWithOverlap(rawdata,Min,NumberOfSamples,NumberOfSegments);
   RawSamples=[RawSamples;rawdata];

        
    end
    
%         fprintf("num of OverallHealthySegments %g\n",OverallHealthySegments);

end

end