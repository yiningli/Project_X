function [ newScalarRay ] = XXScalarRay( pos,dir,wav )
    %XXSCALARRAY Summary of this function goes here
    %   Detailed explanation goes here
    
              if nargin == 0
                % Empty constructor
                newScalarRay.Position = [0;0;0]; % default position
                newScalarRay.Direction = [0;0;1]; % default dirction
                newScalarRay.Wavelength = 0.55*10^-6; % default
                newScalarRay.Vignated = 0;
                newScalarRay.ClassName = 'ScalarRay';
            else
                if nargin == 1
                    dir = [0;0;1]; % default dirction
                    wav = 0.55*10^-6;  % default
                elseif nargin == 2
                    wav = 0.55*10^-6; % default
                else
                end
                
                % If the inputs are arrays the newRay becomes object array
                % That is when dir, pos  = 3 X N matrix
                
                % Determine the size of each inputs
                nPos = size(pos,2);
                nDir = size(dir,2);
                nWav = size(wav,2);
                % The number of array to be initialized is maximum of all inputs
                nMax = max([nPos,nDir,nWav]);
                
                % Set vignated properties to 0 for all rays
                vig = zeros(1,nMax);
                
                % Fill the smaller inputs to have nMax size by repeating their
                % last element
                if nPos < nMax
                    pos = cat(2,pos,repmat(pos(:,end),[1,nMax-nPos]));
                end
                if nDir < nMax
                    dir = cat(2,dir,repmat(dir(:,end),[1,nMax-nDir]));
                end
                if nWav < nMax
                    wav = cat(2,wav,repmat(wav(end),[1,nMax-nWav]));
                end
                
                % Preallocate object array
                newScalarRay(nMax) = ScalarRay;
                for kk = 1:nMax
                    newScalarRay(kk).Position = pos(:,kk);
                    newScalarRay(kk).Direction = dir(:,kk);
                    newScalarRay(kk).Wavelength = wav(kk);
                    newScalarRay(kk).Vignated = vig(kk);
                    newScalarRay(kk).ClassName = 'ScalarRay';
                end
              end  
            
end

