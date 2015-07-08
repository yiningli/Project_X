function [ complexIFFT2DofE ] = computeIFFT2D( complexE )
%COMPUTEFFT2D returns the FFT2 of complex E
complexIFFT2ofE = ifftshift(ifft2(ifftshift(complexE)));
end

