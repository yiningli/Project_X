function [ divergenceRayInX,divergenceRayInY  ] = getDivergenceRays( gaussianBeamArray )
%GETDIVERGENCERAYS Gives the divergence rays used to trace the given gaussian beam
% The code is also vectorized. Multiple inputs and outputs are possible.

    % <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %   Written By: Worku, Norman Girma
    %   Advisor: Prof. Herbert Gross
    %   Part of the RAYTRACE_TOOLBOX
    %	Optical System Design and Simulation Research Group
    %   Institute of Applied Physics
    %   Friedrich-Schiller-University of Jena
    
    % <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
    % Date----------Modified By ---------Modification Detail--------Remark
    % Nov 07,2014   Worku, Norman G.     Original Version       
    
    
    % <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% Copy all ray data from central ray and then change the positions to shift
divergenceRayInX  = [gaussianBeamArray.CentralRay];
divergenceRayInY  = [gaussianBeamArray.CentralRay];
centralRay = [gaussianBeamArray.CentralRay];
[ divergenceHalfAngleInX,divergenceHalfAngleInY ] = ...
    getDivergenceHalfAngle(gaussianBeamArray);

divergenceRayInXDirection = ...
    (repmat(cos(divergenceHalfAngleInX),[3,1]).*([centralRay.Direction])) + ...
    (repmat(sin(divergenceHalfAngleInX),[3,1]).*([gaussianBeamArray.LocalXDirection]));
divergenceRayInYDirection = ...
    (repmat(cos(divergenceHalfAngleInY),[3,1]).*([centralRay.Direction])) + ...
    (repmat(sin(divergenceHalfAngleInY),[3,1]).*([gaussianBeamArray.LocalYDirection]));

% Convert to cell array for assigning to multimple rays at the same time
allDivergenceRayInXDirection = mat2cell(divergenceRayInXDirection,[3],[ones(1,length(gaussianBeamArray))]);
allDivergenceRayInYDirection = mat2cell(divergenceRayInYDirection,[3],[ones(1,length(gaussianBeamArray))]);

[divergenceRayInX.Direction] = allDivergenceRayInXDirection{:};
[divergenceRayInY.Direction] = allDivergenceRayInYDirection{:};

% Intersection of the divergence rays with the 2nd surface (1st surface
% after the object surface)
% All divergence rays intersect the surface at the centr ray intersection point
divergenceRayIntersection = [centralRay.Position];
allPositionInX = mat2cell(divergenceRayIntersection,[3],[ones(1,length(gaussianBeamArray))]);
allPositionInY = allPositionInX; 
[divergenceRayInX.Position] = allPositionInX{:};
[divergenceRayInY.Position] = allPositionInY{:};
end

