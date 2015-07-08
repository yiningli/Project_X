classdef HarmonicFieldSource
    %SOURCE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % Source definitions
        % Ray tracing field points
        %         RayFieldType % Type of field specified either 'ObjectHeight' or 'Angle'
        %         RayFieldPointMatrix % matrix of X field, Y field & Weight
        % (either object height or angle)
        
        % Position, orientation and Dimensions
        LateralPosition % [X;Y] position
        Direction % direction cosine in the direction. The field will be
        % defined in the plane perpendicular to this direction
        
        DistanceToInputPlane
        FieldSizeSpecification % 'Relative' to the lateral profile or 'Absolute'
        
        % For 'Relative' to the lateral profil, the boarder shape is taken
        % directly and the size is scaled with size factor
        RelativeFieldSizeFactor % for relative dimenssioning
        % for absolute dimensioning
        AbsoluteBoarderShape % 'Elliptical' or 'Rectangular'
        AbsoluteFieldSize % [size x , size y]
        
        % additional edge width
        EdgeSizeSpecification % 'Relative' or 'Absolute'
        RelativeEdgeSizeFactor % for relative dimenssioning
        AbsoluteEdgeSize % for absolute
        
        % Source sampling
        SamplingPoints
        SamplingDistance
        AdditionalBoarderSamplePoints
        
        % Spatial parameters
        SpatialProfileType
        SpatialProfileParameter
        
        % Spectral parameter
        SpectralProfileType
        SpectralProfileParameter
        
        % Polarization
        PolarizationType % Linear, Circular or JonesVector
        PolarizationParameter % Angle or Direction or JonesVector
    end
    
    methods
        function newHarmonicFieldSource = HarmonicFieldSource()
            
            newHarmonicFieldSource.LateralPosition = [0,0]';% [X;Y] position
            newHarmonicFieldSource.Direction = [0,0,1]';% direction cosine in the direction. The field will be
            % defined in the plane perpendicular to this direction
            
            newHarmonicFieldSource.DistanceToInputPlane = 10*10^-3;
            newHarmonicFieldSource.FieldSizeSpecification = 'Relative'; % 'Relative' to the lateral profile or 'Absolute'
            
            % For 'Relative' to the lateral profil, the boarder shape is taken
            % directly and the size is scaled with size factor
            newHarmonicFieldSource.RelativeFieldSizeFactor = 1; % for relative dimenssioning
            % for absolute dimensioning
            newHarmonicFieldSource.AbsoluteBoarderShape = 'Elliptical' ;% 'Elliptical' or 'Rectangular'
            newHarmonicFieldSource.AbsoluteFieldSize = [1,1]'; % [size x , size y]
            
            % additional edge width
            newHarmonicFieldSource.EdgeSizeSpecification = 'Relative'; % 'Relative' or 'Absolute'
            newHarmonicFieldSource.RelativeEdgeSizeFactor = 0.1; % for relative dimenssioning
            newHarmonicFieldSource.AbsoluteEdgeSize = 1; % for absolute
            
            % Source sampling
            newHarmonicFieldSource.SamplingPoints = [64,64]';
            newHarmonicFieldSource.SamplingDistance = [10^-6,10^-6]';
            newHarmonicFieldSource.AdditionalBoarderSamplePoints = 5;
            
            % Spatial parameters
            spatialProfPar.Type = 'HermiteGaussianMode';
            spatialProfPar.Order = [0,0];
            spatialProfPar.CentralWavelength = 550*10^-9;
            spatialProfPar.WaistRadius = [10^-3;10^-3];
            spatialProfPar.WaistDistance = [0;0];
            newHarmonicFieldSource.SpatialProfileType = 'GaussianWaveProfile';
            newHarmonicFieldSource.SpatialProfileParameter = spatialProfPar;
            
            % Spectral parameter
            powerSpectProfPar = struct();
            powerSpectProfPar.CentralWavelength = 550*10^-9;
            powerSpectProfPar.HalfWidthHalfMaxima = 20*10^-9;
            powerSpectProfPar.NumberOfSamplingPoints = 20;
            powerSpectProfPar.CutoffPowerFactor = 0.01;
            
            newHarmonicFieldSource.SpectralProfileType = 'GaussianPowerSpectrum';
            newHarmonicFieldSource.SpectralProfileParameter = powerSpectProfPar;
            
            % Polarization
            linPolPar = struct();
            linPolPar.Angle = 0;
            newHarmonicFieldSource.PolarizationType = 'LinearPolarization'; % Linear, Circular or JonesVector
            newHarmonicFieldSource.PolarizationParameter = linPolPar;% Angle or Direction or JonesVector
        end
    end
    
end

