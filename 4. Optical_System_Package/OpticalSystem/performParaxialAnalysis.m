function performParaxialAnalysis(optSystem,wavLen,showOptions,textHandle)
    % performParaxialAnalysis: Performs paraxial analysis on the given optical
    % system and displays results in the textHandle based on the showOptions
    % structure.
    
    % Default variables
    if nargin < 1
        disp('Error: The performParaxialAnalysis needs atleat the optical system.');
        return;
    elseif nargin == 1
        wavLen = getPrimaryWavelength(optSystem);
        % Show all results to the command window
        dispInTextHandle = 0;
        showOptions.TotalNumberOfSurfaces = 1;
        showOptions.StopSurfaceIndex = 1;
        showOptions.SystemTotalTrack = 1;
        showOptions.EffectiveFocalLength = 1;
        showOptions.BackFocalLength = 1;
        showOptions.AngularMagnification = 1;
        showOptions.EntrancePupilDiameter = 1;
        showOptions.EntrancePupilLocation = 1;
        showOptions.ExitPupilDiameter = 1;
        showOptions.ExitPupilLocation = 1;
        showOptions.ObjectSpaceNA = 1;
        showOptions.ImageSpaceNA = 1;
    elseif nargin == 2
        % Show all results to the command window
        dispInTextHandle = 0;
        showOptions.TotalNumberOfSurfaces = 1;
        showOptions.StopSurfaceIndex = 1;
        showOptions.SystemTotalTrack = 1;
        showOptions.EffectiveFocalLength = 1;
        showOptions.BackFocalLength = 1;
        showOptions.AngularMagnification = 1;
        showOptions.EntrancePupilDiameter = 1;
        showOptions.EntrancePupilLocation = 1;
        showOptions.ExitPupilDiameter = 1;
        showOptions.ExitPupilLocation = 1;
        showOptions.ObjectSpaceNA = 1;
        showOptions.ImageSpaceNA = 1;
    elseif nargin == 3
        % Show the selected results to the command window
        dispInTextHandle = 0;
    elseif nargin == 4
        % Show the selected results to the given text window
        dispInTextHandle = 1;
    end
    
    nSurfaces = getNumberOfSurfaces(optSystem);
    stopIndex = getStopSurfaceIndex(optSystem);
    effectiveFocalLength = getEffectiveFocalLength(optSystem);
    totalTrack = getTotalTrack(optSystem);
    
    angularMagnification = getAngularMagnification(optSystem,wavLen);
    objectNA = getObjectNA(optSystem,wavLen);
    entrancePupilDiameter = getEntrancePupilDiameter(optSystem,wavLen);
    entrancePupilLocation = getEntrancePupilLocation(optSystem,wavLen);
    exitPupilLocation = getExitPupilLocation(optSystem,wavLen);
    exitPupilDiameter = getExitPupilDiameter(optSystem,wavLen);
    backFocalLength = getBackFocalLength(optSystem,wavLen);
    imageNA = getImageNA(optSystem,wavLen);
    
    textResult = char('','<<<<<<<<<< Paraxial Analysis Results >>>>>>>>>>>','');
    if showOptions.TotalNumberOfSurfaces
        textResult = char(textResult,['Number of Surfaces:      ',num2str(nSurfaces)]);
    end
    if showOptions.StopSurfaceIndex
        textResult = char(textResult,['Stop Surface Index:      ',num2str(stopIndex)]);
    end
    if showOptions.SystemTotalTrack
        textResult = char(textResult,['System Total Track:      ',num2str(totalTrack,'%f')]);
    end
    if showOptions.EffectiveFocalLength
        textResult = char(textResult,['Effective Focal Length:  ',num2str(effectiveFocalLength,'%f')]);
    end
    if showOptions.BackFocalLength
        textResult = char(textResult,['Back Focal Length:       ',num2str(backFocalLength,'%f')]);
    end
    if showOptions.AngularMagnification
        textResult = char(textResult,['Angular Magnification:   ',num2str(angularMagnification,'%f')]);
    end
    if showOptions.EntrancePupilDiameter
        textResult = char(textResult,['Entrance Pupil Diameter: ',num2str(entrancePupilDiameter,'%f')]);
    end
    if showOptions.EntrancePupilLocation
        textResult = char(textResult,['Entrance Pupil Location: ',num2str(entrancePupilLocation,'%f')]);
    end
    if showOptions.ExitPupilDiameter
        textResult = char(textResult,['Exit Pupil Diameter:     ',num2str(exitPupilDiameter,'%f')]);
    end
    if showOptions.ExitPupilLocation
        textResult = char(textResult,['Exit Pupil Location:     ',num2str(exitPupilLocation,'%f')]);
    end
    if showOptions.ObjectSpaceNA
        textResult = char(textResult,['Object Space NA:         ',num2str(objectNA,'%f')]);
    end
    if showOptions.ImageSpaceNA
        textResult = char(textResult,['Image Space NA:          ',num2str(imageNA,'%f')]);
    end
    
    if dispInTextHandle
        set(textHandle,'String',textResult);
    else
        disp(textResult);
    end
    
    
end
