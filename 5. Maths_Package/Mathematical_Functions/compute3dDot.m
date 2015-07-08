function [ outVal ] = compute3dDot(vect1,vect2)
    % compute3dDot: computes the dot product of two 3xN vectors
    %   The function is also vectorized so if the inputs are array then 
    %   the output will also be array of the same size.    
    %   To replace the default cross function b/c it is faster
    % Input:
    %    vect1,vect2: 3xN vectors
    % Output:
    %    outVal : Nx1 the dot product
    
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
      
    outVal = vect1(1,:).*vect2(1,:) + vect1(2,:).*vect2(2,:)+ ...
        vect1(3,:).*vect2(3,:);   
end

