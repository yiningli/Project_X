function [ NonDummySurfaceIndices] = getNonDummySurfaceIndices( optSystem )
%getNonDummySurfaceIndices Returns the surface array which are not dummy
surfaceArray = optSystem.getSurfaceArray;
nSurface = getNumberOfSurfaces(optSystem);
NonDummySurfaceIndices = [];
for kk = 1:nSurface
    if ~strcmpi(surfaceArray(kk).Type,'Dummy')
        NonDummySurfaceIndices = [NonDummySurfaceIndices,kk];
    end
end
end

