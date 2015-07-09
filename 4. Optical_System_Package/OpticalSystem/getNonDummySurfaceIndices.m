function [ NonDummySurfaceIndices] = getNonDummySurfaceIndices( optSystem )
%getNonDummySurfaceIndices Returns the surface array which are not dummy
surfaceArray = getSurfaceArray(optSystem);
nSurface = getNumberOfSurfaces(optSystem);
NonDummySurfaceIndices = [];
for kk = 1:nSurface
    if ~strcmpi(surfaceArray(kk).Type,'Dummy')
        NonDummySurfaceIndices = [NonDummySurfaceIndices,kk];
    end
end
end

