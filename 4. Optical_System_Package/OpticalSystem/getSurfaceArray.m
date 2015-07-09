function [ surfaceArray ] = getSurfaceArray( optSystem,surfIndex )
    %GETSURFACEARRAY Summary of this function goes here
    %   Detailed explanation goes here
    if nargin == 1
        surfIndex = 0;
    end
    if IsComponentBased(optSystem)
        componentArray = optSystem.ComponentArray;
        nComponent = getNumberOfComponents(optSystem);
        totalSurfaceArray = [];
        for tt = 1:nComponent
            currentSurfaceArray = getComponentSurfaceArray(componentArray(tt));
            stopSurfaceInComponentIndex = componentArray(tt).StopSurfaceIndex;
            if stopSurfaceInComponentIndex
                currentSurfaceArray(stopSurfaceInComponentIndex).Stop = 1;
            end
            totalSurfaceArray = [totalSurfaceArray,currentSurfaceArray];
        end
        tempSurfaceArray = totalSurfaceArray;
    else
        tempSurfaceArray = optSystem.SurfaceArray;
    end
    updatedSurfaceArray = updateSurfaceCoordinateTransformationMatrices(tempSurfaceArray);
    
    if surfIndex
        % Return the required surface
        surfaceArray = updatedSurfaceArray(surfIndex);
    else
        surfaceArray = updatedSurfaceArray;
    end
end

