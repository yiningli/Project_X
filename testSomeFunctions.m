% 
% % %% computeLinePlaneIntersection
% % linePoint = [0,0,-2]';lineVector=[0,cosd(45),cosd(45)]';planePoint=[0,0,0]';planeNormalVector=[0,0,1]';
% % [linePlaneIntersection,distance] = computeLinePlaneIntersection(linePoint,lineVector,planePoint,planeNormalVector)
% %%
% c = 299792458;
% % fOpticalSystemName = which ('TestGratingPair.mat');  
% % fOpticalSystemName = which ('SingleSurface.mat'); 
% 
% fOpticalSystemName = which ('GratingStrecherImportedFromZMX.mat');  
% % fOpticalSystemName = which ('GratingCompressorImportedFromZMX.mat'); 
% 
% 
% optSystem = OpticalSystem(fOpticalSystemName);
% 
% fieldIndex = 1;
% delta_wav = 10*10^-9;
% wav0 = optSystem.getPrimaryWavelength;
% wavelengthVectorInM = [wav0, wav0 + delta_wav];
% [ geometricalOpticalGroupPathLength ] = ...
%     computePathLengths( optSystem, fieldIndex, wavelengthVectorInM)
% 
% deltaTfromPath = -(geometricalOpticalGroupPathLength(1,2)-geometricalOpticalGroupPathLength(2,2))/(c);
% 
% delta_x0 = 0;
% delta_y0 = 0;
% delta_dx0 = 0;
% delta_dy0 = 0;
% delta_t0 = 0;
% delta_f0 = -(c/wav0^2)*delta_wav;
% [ delta_x,delta_y, delta_dx,delta_dy,delta_t,delta_f ] = ...
%     compute3DRayPulseVector(optSystem,delta_x0,delta_y0,delta_dx0,delta_dy0,...
%     delta_t0,delta_f0);
% deltaTfromPath
% delta_t
% delta_f0
% gdd1 = deltaTfromPath/(2*pi*delta_f0)
% gdd2 = delta_t/(2*pi*delta_f0)


% %% Test using number, string and struct to switch statement
% % Result: Struct is readable and as fast as number
% % Number: Very fast
% % String: Very slow 
% SystemApertureTypes2 = struct();
% SystemApertureTypes2.ENPD  = 1; % 'Enterance Pupil Diameter'
% SystemApertureTypes2.OBNA  = 2;% 'Object Space NA'
% SystemApertureTypes2.OBFN  = 3;% 'Object Space F#'
% SystemApertureTypes2.IMNA  = 4;% 'Image Space NA'
% SystemApertureTypes2.IMFN  = 5;% 'Image Space F#'
% 
% n = 10000000;
% aperttype = 'ENPD';
% tic
% for kk = 1:n
%     if strcmpi(aperttype,'ENPD')
%     end
% end
% toc
% 
% aperttype = 1;
% tic
% for kk = 1:n
%     if aperttype == 2
%     end
% end
% toc
% 
% aperttype = 1;
% tic
% for kk = 1:n
%     if aperttype == SystemApertureTypes2.ENPD
%     end
% end
% toc

%% Test using Object and structures programmed in object oriented approach
% Creation
warning off
n = 10000;
tic
for kk = 1:n
    surf = Surface('Standard');
    surf.Stop = 1;
    [ radius ] = getRadiusOfCurvature( surf );
end
toc

tic
for kk = 1:n
     surf = SurfaceStruct('Standard');
%     surf = struct(Surface('Standard'));
    surf.Stop = 1;
    [ radius ] = getRadiusOfCurvatureStruct( surf );
end
toc