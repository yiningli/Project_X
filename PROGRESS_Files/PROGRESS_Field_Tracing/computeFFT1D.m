function [ complexFFT1DofE ] = computeFFT1D( complexE,delta,dim )
%COMPUTEFFT returns the FFT of complex E
complexFFT1DofE = fftshift(fft(fftshift(complexE),[],dim))*delta;
end

