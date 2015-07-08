function [ nSurface ] = getNumberOfSurfaces( currentComponent )
    %GETNUMBEROFSURFACES returns the number of surfaces
    
    nSurface = length(currentComponent.getSurfaceArray);
    
end

