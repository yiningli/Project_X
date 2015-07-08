function [ divergenceHalfAngleInX,divergenceHalfAngleInY ] = getDivergenceHalfAngle( gaussianBeamArray )
%GETDIVERGENCEHALFANGLE Returns the divergence half angle of the beam as
% the beam propagates along Z.
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
centralRay = [gaussianBeamArray.CentralRay];
divergenceHalfAngleInX = ([centralRay.Wavelength])./...
    (pi*([gaussianBeamArray.WaistRadiusInX]));
divergenceHalfAngleInY = ([centralRay.Wavelength])./...
    (pi*([gaussianBeamArray.WaistRadiusInY]));
end

