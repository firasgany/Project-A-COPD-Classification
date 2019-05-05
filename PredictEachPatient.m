function [PredictionsVec] = PredictEachPatient(AveragedScoresVec,UniqueIDS,ValCopdIdVecLength,ValHealthyIdVecLength);


PredictionsVec = {};
%%first we create a label vector for Validation Set which in the future
%%Test Val.

labelVec={};
OverAllCopdIds=0;

lastCopdId = ValidationSetIDVec(ValCopdIdVecLength);

for uniqeIndex = 1: numel(UniqueIDS)
    OverAllCopdIds = OverAllCopdIds +1 ;  
    if (strcmp(UniqueIDS(uniqeIndex),lastCopdId)==1)
        break;
    end
end     


%%now we build the label vector

LabelIDvec ={};

for uniqeIndex = 1: OverAllCopdIds
    LabelIDvec = [LabelIDvec ;  'copd'];
end

for uniqeIndex = OverAllCopdIds: numel(UniqueIDS)-1
    LabelIDvec = [LabelIDvec ;  'healthy'];
end

PredictionVec = horzcat(LabelIDvec,UniqueIDS,AveragedScoresVec);


end 