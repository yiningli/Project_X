function [ spotRadiusInX,spotRadiusInY ] = getSpotRadius( gaussianBeamArray )
%GETSPOTRADIUS Returns the spot radius of the beam at z = DistanceFromWaist
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
[ rayleighRangeInX,rayleighRangeInY ] = getRayleighRange(gaussianBeamArray);
spotRadiusInX = [(gaussianBeamArray.WaistRadiusInX)].*...
    sqrt(1+([gaussianBeamArray.DistanceFromWaist]./rayleighRangeInX).^2);
spotRadiusInY = ([gaussianBeamArray.WaistRadiusInY]).*...
    sqrt(1+([gaussianBeamArray.DistanceFromWaist]./rayleighRangeInY).^2);
end

