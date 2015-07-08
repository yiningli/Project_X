function [ nSurface ] = getNumberOfSurfaces( optSystem )
    %GETNUMBEROFSURFACES returns the number of surfaces
    
    nSurface = length(optSystem.getSurfaceArray);
    
end

