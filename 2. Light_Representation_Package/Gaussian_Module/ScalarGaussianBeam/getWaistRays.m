function [ waistRayInX,waistRayInY ] = getWaistRays( gaussianBeamArray )
%GETWAISTRAYS Gives the waist rays used to trace the given gaussian beam
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
waistRayInX = [gaussianBeamArray.CentralRay];
waistRayInY = [gaussianBeamArray.CentralRay];
centralRay = [gaussianBeamArray.CentralRay];
centerRayDirection  = [centralRay.Direction];

% Compute waist ray intersection with the reference plane just before the
% 2nd surface (1st surface next to object surface)
waistRayInXIntersection = [centralRay.Position] + ...
    repmat([gaussianBeamArray.WaistRadiusInX],[3,1]).*[gaussianBeamArray.LocalXDirection];
waistRayInYIntersection =  [centralRay.Position] + ...
    repmat([gaussianBeamArray.WaistRadiusInY],[3,1]).*[gaussianBeamArray.LocalYDirection];

% Convert to cell array for assigning to multimple rays at the same time
allWaistRayInXIntersection = mat2cell(waistRayInXIntersection,[3],[ones(1,length(gaussianBeamArray))]);
allWaistRayInYIntersection = mat2cell(waistRayInYIntersection,[3],[ones(1,length(gaussianBeamArray))]);

[waistRayInX.Position] = allWaistRayInXIntersection{:};
[waistRayInY.Position] = allWaistRayInYIntersection{:};
end

