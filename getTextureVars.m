% Helper function: Read in the texture features for a specified set of
% lesions for a specific imaging sequence 

function [textureFeatures] = getTextureVars(patientList, energyLevel)
load('patientList');
patientNum = numel(patientList);
% featureList contained the list of all features (texture +| non-texture)
load ('featureList');
% extractionType is the list of ways to extract texture features
load('extractionType')
nTextType =length(textType);
x=length(extractionType);

counter = 0;
% texture for-loop
for l = 1:nTextType
    for m = 1:numel(textName{l})
        counter = counter + 1;
    end
end
nText=counter;
y=nText;

z=numel(patientList);

textureFeatures = zeros(x,y,z);

for i = numel (patientNum)
    filename=['FEATURES\',patientList{i},'_CT_',num2str(energyLevel),'kev(tumor2D).CTscan.mat'];
    load(filename);
    
    % loop over the different ways of extracting texture features.
    for k = 1:length(extractionType)
        
        % Create variable to keep track of the feature type number
        counter = 0;
        for l = 1:nTextType
            for m = 1:numel(textName{l})
                counter = counter + 1;
                textureFeatures(k,counter,i)=radiomics.image.texture.(textType{l}).(extractionType{k}).(textName{l}{m});              
            end % m
        end % l
    end % k
end % i
    
