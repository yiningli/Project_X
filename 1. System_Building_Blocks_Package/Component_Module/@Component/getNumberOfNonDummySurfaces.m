function [ nNonDummySurface ] = getNumberOfNonDummySurfaces( currentComponent )
    %GETNUMBEROFNONDUMMYSURFACES returns the number of non dummy surface
    %arrays
        nNonDummySurface = length(currentComponent.getNonDummySurfaceArray);
end

