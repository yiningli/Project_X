function [ yf,uf ] = paraxialRayTracer( optSystem,yi,ui,initialSurf,finalSurf,wavlenInM )
%PARAXIALRAYTRACER performs paraxial ray trace through optical system using
%yni algorithm. 

% Determine the start and end indeces in non dummy surface array
nSurface = optSystem.getNumberOfSurfaces;
nNonDummySurface = optSystem.getNumberOfNonDummySurfaces;
NonDummySurfaceArray = optSystem.getNonDummySurfaceArray;
NonDummySurfaceIndices = optSystem.getNonDummySurfaceIndices;
	if initialSurf==finalSurf
		yf=yi;
		uf=ui;
	elseif initialSurf < finalSurf
        y = yi;
		u = ui;
		%forward trace
        indicesAfterStartSurf = find(NonDummySurfaceIndices>=initialSurf);
        startNonDummyIndex = indicesAfterStartSurf(1);
        indicesBeforeEndSurf = find(NonDummySurfaceIndices<=finalSurf);
        endNonDummyIndex = indicesBeforeEndSurf(end);
        reverseTracing = 0;        
        
		for surfIndex = startNonDummyIndex+1:1:endNonDummyIndex
            
            indexBefore = getRefractiveIndex(NonDummySurfaceArray(surfIndex-1).Glass,wavlenInM);
            indexAfter = getRefractiveIndex(NonDummySurfaceArray(surfIndex).Glass,wavlenInM);
            surface = NonDummySurfaceArray(surfIndex);
            
            % translate the paraxial ray for next trace            
            t = NonDummySurfaceArray(surfIndex-1).Thickness; 
            if t > 10^10
                t = 10^10;
            end
            yBefore = y + t*u;
            uBefore = u;            
            [ yAfter,uAfter ] = getExitParaxialRay( ...
                surface,yBefore,uBefore,reverseTracing,indexBefore,indexAfter );
            y = yAfter;
            u = uAfter;
            
%             yPrev = yNext;
%             uPrev = uNext;
% 			t=thick(surfIndex);
% 			c=curv(surfIndex+1);
% 			n=refIndex(surfIndex);
% 			nPrime=refIndex(surfIndex+1);
% 			
% 			if t~=Inf
% 				y=y+t*u;
% 			end
% 			paI=u+y*c; %The yui method generates the paraxial angles of incidence 
% 			% during the trace and is probably the most common method used in computer programs.
% 			u=u+((n/nPrime)-1)*paI;
		end
		yf = y;
		uf = u;
	elseif initialSurf > finalSurf
        y = yi;
		u = -ui;
		%reverse trace
        indicesAfterEndSurf = find(NonDummySurfaceIndices>=finalSurf);
        endNonDummyIndex = indicesAfterEndSurf(1);
        indicesBeforeStartSurf = find(NonDummySurfaceIndices<=initialSurf);
        startNonDummyIndex = indicesBeforeStartSurf(end);
        reverseTracing = 1;        
        
		for surfIndex = startNonDummyIndex:-1:endNonDummyIndex+1
            indexBefore = getRefractiveIndex(NonDummySurfaceArray(surfIndex-1).Glass,wavlenInM);
            indexAfter = getRefractiveIndex(NonDummySurfaceArray(surfIndex).Glass,wavlenInM);
            surface = NonDummySurfaceArray(surfIndex);
            yAfter = y;
            uAfter = u;
            [ yBefore,uBefore ] = getExitParaxialRay( ...
                surface,yAfter,uAfter,reverseTracing,indexBefore,indexAfter );
            
            % translate the paraxial ray to prev surface
            t = NonDummySurfaceArray(surfIndex-1).Thickness;  
            if t > 10^10
            	t = 0;
            end
            y = yBefore + t*uBefore;
            u = uBefore;
%             yPrev = yNext;
%             uPrev = uNext;
		end        
        yf = y;
		uf = -u;
        
% 		y=yi;
% 		u=-ui;    
% 		for surfIndex=initialSurf:-1:1+finalSurf
% 			t=thick(surfIndex-1);
% 			c=-curv(surfIndex);
% 			indexBefore=refIndex(surfIndex);
% 			indexAfter=refIndex(surfIndex-1);
% 
% 			paI=u+y*c;
% 			u=(u+((indexBefore/indexAfter)-1)*paI);
% 			if t~=Inf
% 			   y=y+t*u;
% 			end
% 		end  
% 		yf=y;
% 		uf=-u;    
	else
		
	end

end

