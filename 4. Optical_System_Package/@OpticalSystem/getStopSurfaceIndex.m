function [stopIndex, specified] = getStopSurfaceIndex(optSystem)
    % getStopIndex: gives the stop index surface set by user
    stopIndex = 0;
    specified = 0;
    for kk=1:1:optSystem.getNumberOfSurfaces
        if optSystem.getSurfaceArray(kk).Stop
            stopIndex = kk;
            specified = 1;
            return;
        end
    end
    
    specified = 0;
    
    if stopIndex == 0
        % If stop index not given by user then compute it
        refIndex = zeros(1,optSystem.getNumberOfSurfaces);
        thick = zeros(1,optSystem.getNumberOfSurfaces);
        curv = zeros(1,optSystem.getNumberOfSurfaces);
        clearAperture = zeros(1,optSystem.getNumberOfSurfaces);
        
        for kk=1:1:optSystem.getNumberOfSurfaces
            refIndex(kk) = optSystem.getSurfaceArray(kk).Glass...
                .getRefractiveIndex(optSystem.PrimaryWavelengthIndex);
            thick(kk) = optSystem.getSurfaceArray(kk).Thickness;
            try
                curv(kk) = 1/(optSystem.getSurfaceArray(kk).OtherStandardData.Radius);
            catch
                % If the surface doesn't have Radius data then consider as
                % plane
                curv(kk) = 0;
            end
            
            % clearAperture(kk) = optSystem.getSurfaceArray(kk).getClearAperture;
            [ minApertureRadius ] = getMinimumApertureRadius( optSystem.getSurfaceArray(kk).Aperture );
            clearAperture(kk) = minApertureRadius;
        end
        
        % For -ve thickness refindex should also be negative
        refIndex = refIndex.*sign(thick);
        % Replace zero index with 1 to avoid division by zero
        refIndex(refIndex==0) = 1;
        
        if abs(thick(1))>10^10
            thick(1)=10^10;
            obj = 'I';
        else
            obj = 'F';
        end
        if optSystem.ImageAfocal
            img = 'I';
        else
            img = 'F';
        end
        obj_img = [obj,img];
        
        [ stopIndex] = computeSystemStopIndex...
            (stopIndex,refIndex,thick,curv,clearAperture,obj_img);
    end
end