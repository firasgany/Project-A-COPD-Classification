function [AveragedScoresVec] = AvgSegmentsScores(scores,ValidationSetIDVec);


CurrSum = 0;
SegmentCount =0; 
AveragedScoresVec={};

uniqres = unique(ValidationSetIDVec,'stable');
for UniqIndex = 1: numel (uniqres);
    for ValidationIDVecIndex =1:numel(ValidationSetIDVec)
         if (strcmp(uniqres(UniqIndex),ValidationSetIDVec(ValidationIDVecIndex))==1)
             SegmentCount = SegmentCount+1;
             CurrSum = CurrSum + scores(ValidationIDVecIndex);
             if(ValidationIDVecIndex == numel(ValidationSetIDVec))
                CurrAvg = CurrSum/SegmentCount;
                 AveragedScoresVec=[AveragedScoresVec ; CurrAvg];
             end    
                 
         else
             if (CurrSum==0 | SegmentCount ==0) 
                 continue;
             end    
             CurrAvg = CurrSum/SegmentCount;
             AveragedScoresVec=[AveragedScoresVec ; CurrAvg];
             CurrAvg=0;
             SegmentCount =0;
             CurrSum=0;
             break;
         end  
    end
end    
             
             



end
