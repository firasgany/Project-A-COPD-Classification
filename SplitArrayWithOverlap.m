function [RawSamples] = SplitArrayWithOverlap(CurrRawData,Min,NumberOfSamples,NumberOfSegments)


firstNumberofSamples = NumberOfSamples; 

if (CurrRawData ~= Min)
    if (mod((Min*NumberOfSegments-NumberOfSamples)/(NumberOfSegments-1), 1)==0)  
     overlap = (Min*NumberOfSegments-NumberOfSamples)/(NumberOfSegments-1);
      else 
       while (NumberOfSamples>0)
              NumberOfSamples=NumberOfSamples-1;
              if (mod((Min*NumberOfSegments-NumberOfSamples)/(NumberOfSegments-1), 1)==0)  
              break;    
              end     
       end 
       overlap = (Min*NumberOfSegments-NumberOfSamples)/(NumberOfSegments-1);  
      end  
    else      
      overlap = 0;
end  
                             
RawSamples={};

seg1=1;
seg2=Min;
NextSegment={};  
for Segment=1:NumberOfSegments
while seg1<seg2+1
   nextelement = CurrRawData(seg1);
   NextSegment = [NextSegment;nextelement];
   seg1 = seg1+1;
end
    

B = cell2mat(NextSegment);
RawSamples = [RawSamples;B];
 
seg1 = seg2-overlap;
seg2 = seg1 + Min -1; 
NextSegment = {};
end

end

