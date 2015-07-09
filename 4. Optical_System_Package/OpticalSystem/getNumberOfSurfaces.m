function [ nSurface ] = getNumberOfSurfaces( optSystem )
    %GETNUMBEROFSURFACES returns the number of surfaces
    
    nSurface = length(getSurfaceArray(optSystem));
    
end

