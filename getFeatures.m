%% Getting patient files converted into the new format - getFeaturesnew (function name should be the same as the matlab file name)

% energy level - analogue of the nriSequence 

% what this function should do: 

% take a energy level, save a matrix of size (x,y,z). 
% x = number of ways each texture is extracted
% y= number of features (texture + non-texture)
% z= number of patients

function [] = getFeatures(energyLevel)
load('patientList');
z=numel(patientList);

load ('extractionType');
x=length(extractionType);

load ('featureList');
counter = 0;
% number of texture type. 
nTextType =length(textType); 

% texture for-loop
% loop over texture type cells. 
for l = 1:nTextType
    for m = 1:numel(textName{l})
        counter = counter + 1;
    end
end
% nText = number of texture names. (94)
nText=counter;
% at this point, counter is still 94 (reason why nText takes over to be the number of texture names.)

%Non-texture for-loop, looping over non-texture feature types
nTypes =length(types);
for l = 1:nTypes
    for m = 1:numel(typeNames{l})
        counter = counter + 1;
    end
end
%after this loop, counter is now the TOTAL number of feature and
%non-feature names. (counter = feature names + non-feature names). 

%nNonText - number of non-texture feature names
nNonText=counter-nText; 
y=counter; 
% now we've determined x,y, and z. 
% x = number of ways each texture is extracted
% y= number of features (texture + non-texture)
% z= number of patients

variable1 = getTextureVars(patientList,energyLevel); %will be of size (x,nText,z)

%only 1 way of calculation for nontexture - 2 Dimension
variable2 = getNonTextureVars(patientList,energyLevel); %will be of size (nNonText,z)  

% since variable 1 and variable 2 have different dimensions, need to create
% variable 3 so that it has the same dimension as variable 1; variable 3 is
% a copy of variable 2 along the x dimension (every x has a fixed value for the same y and z)
variable3 = zeros(x,nNonText,z);                         
                        
for i = 1:x
    for j = 1:nNonText
        for k = 1:z
            % this is where we copy variable 2 into variable 3 along
            % the x dimension. 
            variable3(i,j,k) = variable2(j,k); 
            save('variable3');
        end
    end
end
features = horzcat(variable1,variable3);   % horzcat concatenates variable1 and variable3 together. 
save(sprintf('features_%i',energyLevel),'features');
