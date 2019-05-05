function GrayScaleSpec(x,wLenInSamples,nfft,fs)

x = x(:, 1);                        % get the first channel
% define analysis parameters

hop = wLenInSamples/4;                       % hop size (recomended to be power of 2)
% nfft = 4096;                        % number of fft points (recomended to be power of 2)
% perform STFT
win = blackman(wLenInSamples, 'periodic');
[S, f, t] = spectrogram(x, win, hop, nfft, fs);
% calculate the coherent amplification of the window
C = sum(win)/wLenInSamples;
% take the amplitude of fft(x) and scale it, so not to be a
% function of the length of the window and its coherent amplification
S = abs(S)/wLenInSamples/C;
% correction of the DC & Nyquist component
if rem(nfft, 2)                     % odd nfft excludes Nyquist point
    S(2:end, :) = S(2:end, :).*2;
else                                % even nfft includes Nyquist point
    S(2:end-1, :) = S(2:end-1, :).*2;
end
% convert amplitude spectrum to dB (min = -120 dB)
S = 20*log10(S + 1e-6);
% plot the spectrogram

% 
% imagesc(t,f,S);
% t=colormap(gray);
% colormap(1-t);

figure(1)
surf(t, f, S)
shading interp

 axis tight
 view(0, 90)
 
 
 t=colormap(gray);
 colormap(1-t);
 
% set(gca, 'FontName', 'Times New Roman', 'FontSize', 14)
% xlabel('Time, s')
% ylabel('Frequency, Hz')
% title('Amplitude spectrogram of the signal')
% hcol = colorbar;
% set(hcol, 'FontName', 'Times New Roman', 'FontSize', 14)
% ylabel(hcol, 'Magnitude, dB')

end