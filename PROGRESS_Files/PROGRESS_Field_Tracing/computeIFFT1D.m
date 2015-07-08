function [ complexIFFT1DofE ] = computeIFFT1D( complexE )
%COMPUTEFFT returns the FFT of complex E
complexIFFT1DofE = ifftshift(ifft(ifftshift(complexE)));
end

