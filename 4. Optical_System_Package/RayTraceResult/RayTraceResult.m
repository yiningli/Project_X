function traceResult = RayTraceResult(nRayPupil,nField,nWav,...
        RayIntersectionPoint,ExitRayPosition,SurfaceNormal,...
        IncidentRayDirection,IncidenceAngle,ExitRayDirection,ExitAngle,...
        NoIntersectionPoint,OutOfAperture,TotalInternalReflection,PathLength,OpticalPathLength,...
        GroupPathLength,TotalPathLength,TotalOpticalPathLength,TotalGroupPathLength,...
        RefractiveIndex,RefractiveIndexFirstDerivative,RefractiveIndexSecondDerivative,...
        GroupRefractiveIndex,CoatingJonesMatrix,CoatingPMatrix,CoatingQMatrix,TotalPMatrix,TotalQMatrix)
    % Assume all inputs are valid and of equal size
    if nargin == 0
        traceResult.RayIntersectionPoint = [0;0;0]*NaN;
        traceResult.ExitRayPosition = [0;0;0]*NaN;
        traceResult.SurfaceNormal  = [0;0;0]*NaN;
        traceResult.IncidentRayDirection = [0;0;0]*NaN;
        traceResult.IncidenceAngle = 0*NaN;
        traceResult.ExitRayDirection = [0;0;0]*NaN;
        traceResult.ExitAngle = 0*NaN;
        traceResult.PathLength = 0*NaN;
        traceResult.OpticalPathLength = 0*NaN;
        
        traceResult.GroupPathLength = 0*NaN;
        traceResult.TotalPathLength = 0*NaN;
        traceResult.TotalOpticalPathLength = 0*NaN;
        traceResult.TotalGroupPathLength = 0*NaN;
        
        traceResult.RefractiveIndex = 0*NaN;
        traceResult.RefractiveIndexFirstDerivative  = 0*NaN;
        traceResult.RefractiveIndexSecondDerivative  = 0*NaN;
        
        traceResult.GroupRefractiveIndex  = 0*NaN;
        
        traceResult.CoatingJonesMatrix  = eye(2)*NaN;
        traceResult.CoatingPMatrix  = eye(3)*NaN;
        traceResult.CoatingQMatrix  = eye(3)*NaN;
        traceResult.TotalPMatrix  = eye(3)*NaN;
        traceResult.TotalQMatrix  = eye(3)*NaN;
        
        % Failure cases
        traceResult.NoIntersectionPoint = 0*NaN;
        traceResult.OutOfAperture = 0*NaN;
        traceResult.TotalInternalReflection = 0*NaN;
        traceResult.ClassName = 'RayTraceResult'; 
    else
        % reshape each result to [nRayPupil,nField,nWav]
            traceResult.RayIntersectionPoint = reshape(RayIntersectionPoint,[3,nRayPupil,nField,nWav]);
            traceResult.ExitRayPosition = reshape(ExitRayPosition,[3,nRayPupil,nField,nWav]) ;
            traceResult.SurfaceNormal  = reshape(SurfaceNormal,[3,nRayPupil,nField,nWav]) ;
            traceResult.IncidentRayDirection = reshape(IncidentRayDirection,[3,nRayPupil,nField,nWav]) ;
            traceResult.IncidenceAngle = reshape(IncidenceAngle,[1,nRayPupil,nField,nWav]) ;
            traceResult.ExitRayDirection = reshape(ExitRayDirection,[3,nRayPupil,nField,nWav]) ;
            traceResult.ExitAngle = reshape(ExitAngle,[1,nRayPupil,nField,nWav]) ;
            traceResult.PathLength = reshape(PathLength,[1,nRayPupil,nField,nWav]) ;
            traceResult.OpticalPathLength = reshape(OpticalPathLength,[1,nRayPupil,nField,nWav]) ;
            
            traceResult.GroupPathLength = reshape(GroupPathLength,[1,nRayPupil,nField,nWav]) ;
            traceResult.TotalPathLength = reshape(TotalPathLength,[1,nRayPupil,nField,nWav]) ;
            traceResult.TotalOpticalPathLength = reshape(TotalOpticalPathLength,[1,nRayPupil,nField,nWav]) ;
            traceResult.TotalGroupPathLength = reshape(TotalGroupPathLength,[1,nRayPupil,nField,nWav]) ;
            
            % Failure cases
            traceResult.NoIntersectionPoint = reshape(NoIntersectionPoint,[1,nRayPupil,nField,nWav]) ;
            traceResult.OutOfAperture = reshape(OutOfAperture,[1,nRayPupil,nField,nWav]) ;
            traceResult.TotalInternalReflection = reshape(TotalInternalReflection,[1,nRayPupil,nField,nWav]) ;
            
            traceResult.RefractiveIndex = reshape(RefractiveIndex,[1,nRayPupil,nField,nWav]) ;
            traceResult.RefractiveIndexFirstDerivative  = reshape(RefractiveIndexFirstDerivative,[1,nRayPupil,nField,nWav]) ;
            traceResult.RefractiveIndexSecondDerivative  = reshape(RefractiveIndexSecondDerivative,[1,nRayPupil,nField,nWav]) ;
            
            traceResult.GroupRefractiveIndex  = reshape(GroupRefractiveIndex,[1,nRayPupil,nField,nWav]) ;
            
            if nargin > 23
                traceResult.CoatingJonesMatrix  = reshape(CoatingJonesMatrix,[3,3,nRayPupil,nField,nWav]) ;
                traceResult.CoatingPMatrix  = reshape(CoatingPMatrix,[3,3,nRayPupil,nField,nWav]) ;
                traceResult.CoatingQMatrix  = reshape(CoatingQMatrix,[3,3,nRayPupil,nField,nWav]) ;
                traceResult.TotalPMatrix  = reshape(TotalPMatrix,[3,3,nRayPupil,nField,nWav]) ;
                traceResult.TotalQMatrix  = reshape(TotalQMatrix,[3,3,nRayPupil,nField,nWav]) ;
            end
            traceResult.ClassName = 'RayTraceResult'; 
            
        % Preallocate the array object
%         nRay = size(RayIntersectionPoint,2);
%         traceResult(nRay) = RayTraceResult;
%         for kk = 1:nRay
%             traceResult(kk).RayIntersectionPoint = RayIntersectionPoint(:,kk);
%             traceResult(kk).ExitRayPosition = ExitRayPosition(:,kk);
%             traceResult(kk).SurfaceNormal  = SurfaceNormal(:,kk);
%             traceResult(kk).IncidentRayDirection = IncidentRayDirection(:,kk);
%             traceResult(kk).IncidenceAngle = IncidenceAngle(:,kk);
%             traceResult(kk).ExitRayDirection = ExitRayDirection(:,kk);
%             traceResult(kk).ExitAngle = ExitAngle(kk);
%             traceResult(kk).PathLength = PathLength(kk);
%             traceResult(kk).OpticalPathLength = OpticalPathLength(kk);
%             
%             traceResult(kk).GroupPathLength = GroupPathLength(kk);
%             traceResult(kk).TotalPathLength = TotalPathLength(kk);
%             traceResult(kk).TotalOpticalPathLength = TotalOpticalPathLength(kk);
%             traceResult(kk).TotalGroupPathLength = TotalGroupPathLength(kk);
%             
%             % Failure cases
%             traceResult(kk).NoIntersectionPoint = NoIntersectionPoint(kk);
%             traceResult(kk).OutOfAperture = OutOfAperture(kk);
%             traceResult(kk).TotalInternalReflection = TotalInternalReflection(kk);
%             
%             traceResult(kk).RefractiveIndex = RefractiveIndex(kk);
%             traceResult(kk).RefractiveIndexFirstDerivative  = RefractiveIndexFirstDerivative(kk);
%             traceResult(kk).RefractiveIndexSecondDerivative  = RefractiveIndexSecondDerivative(kk);
%             
%             traceResult(kk).GroupRefractiveIndex  = GroupRefractiveIndex(kk);
%             
%             if nargin > 20
%                 traceResult(kk).CoatingJonesMatrix  = CoatingJonesMatrix(:,:,kk);
%                 traceResult(kk).CoatingPMatrix  = CoatingPMatrix(:,:,kk);
%                 traceResult(kk).CoatingQMatrix  = CoatingQMatrix(:,:,kk);
%                 traceResult(kk).TotalPMatrix  = TotalPMatrix(:,:,kk);
%                 traceResult(kk).TotalQMatrix  = TotalQMatrix(:,:,kk);
%             end
%             traceResult(kk).ClassName = 'RayTraceResult'; 
%         end
    end
end



