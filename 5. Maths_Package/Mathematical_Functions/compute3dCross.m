function [ outVect ] = compute3dCross(vect1,vect2)
    % compute3dCross: computes the cross product of two 1X3 vectors(Originaly). 
    % The function is vectorized so it can work on
    % multiple inputs once at the same time.
    %   To replace the default cross function b/c it is faster
    % Input:
    %    vect1,vect2: (3XN) vectors
    % Output:
    %    outVect : the cross product
    
	% <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
	%   Written By: Worku, Norman Girma  
	%   Advisor: Prof. Herbert Gross
	%   Part of the RAYTRACE_TOOLBOX V3.0 (OOP Version)
	%	Optical System Design and Simulation Research Group
	%   Institute of Applied Physics
	%   Friedrich-Schiller-University of Jena   
							 
	% <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
	% Date----------Modified By ---------Modification Detail--------Remark
	% Jan 18,2014   Worku, Norman G.     Original with Vectorized inputs and outputs

	% <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    outVect = [vect1(2,:).*vect2(3,:) - vect1(3,:).*vect2(2,:);...
        vect1(3,:).*vect2(1,:) - vect1(1,:).*vect2(3,:);...
        vect1(1,:).*vect2(2,:) - vect1(2,:).*vect2(1,:)];   
end

