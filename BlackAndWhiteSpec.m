function BlackAndWhiteSpec(CurrRawData)
     figure();
     Fs=4000;
     OverlapLength =30;
     WindowLength_inSamples=(25e-3*Fs); %window length in samples;
     curr_stft=abs(spectrogram(CurrRawData,WindowLength_inSamples,OverlapLength));
     imshow(20*db(curr_stft));
end