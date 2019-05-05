function [FeaturesVec] = featuresExtraction(OverlapLength,RawSamples,Fs )

FeaturesVec={};

for SampleInd=1:numel(RawSamples)
    CurrRawData=RawSamples{SampleInd};
     WindowLength_inSamples=(25e-3*Fs); %window length in samples;
    %WindowLength_in_MS = WindowLength_inSamples/(10e-3*Fs);  %window length in mili seconds
    curr_stft=abs(spectrogram(CurrRawData,WindowLength_inSamples,OverlapLength));
    FeaturesVec=[FeaturesVec;curr_stft];
end

end

