function NewSurface = Surface(surfType)
    if nargin == 0
        % Make single surface component by default
        surfType = 'Standard';
    end
    NewSurface.ObjectSurface = 0;
    NewSurface.ImageSurface = 0;
    NewSurface.Stop = 0;
    NewSurface.Comment = '';
    NewSurface.Type = surfType;
    NewSurface.Thickness = 5;
    NewSurface.Glass = Glass();
    [fieldNames,fieldFormat,defaultUniqueParamStruct] = getSurfaceUniqueParameters(surfType);
    NewSurface.UniqueParameters = defaultUniqueParamStruct;
    NewSurface.ExtraData  = [];
    NewSurface.Aperture = Aperture();
    NewSurface.Coating = Coating();
    NewSurface.TiltDecenterOrder = {'Dx','Dy','Dz','Tx','Ty','Tz'};
    NewSurface.Tilt = [0 0 0];
    NewSurface.Decenter = [0 0];
    NewSurface.TiltMode = 'DAR';
    % TM = transformation Matrix
    NewSurface.SurfaceCoordinateTM = ...
        [1 0 0 0;0 1 0 0;0 0 1 0;0 0 0 1];
    NewSurface.ReferenceCoordinateTM = ...
        [1 0 0 0;0 1 0 0;0 0 1 0;0 0 0 1];
    NewSurface.GlassBefore  = Glass();
    
    NewSurface.SurfaceColor = '';
    NewSurface.Hidden = 0;
    NewSurface.Ignored = 0;
    NewSurface.ClassName = 'Surface';
end