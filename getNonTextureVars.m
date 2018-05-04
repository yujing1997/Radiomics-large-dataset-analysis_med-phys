% Helper function: Read in the non-texture features for a specified set of
% lesions for a specific imaging sequence 
function [nonTextureFeatures] = getNonTextureVars(patientList,energyLevel) % energyLevel entered directly by
% user which accesses the FEATURES file. 

load ('featureList');

patientNum = numel(patientList);
% featureList contained the list of all features (texture +| non-texture)
%load ('featureList');
nTypes =length(types); % the number of non-texture types. 

counter = 0;
%Non-texture for-loop
for l = 1:nTypes
    for m = 1:numel(typeNames{l})
        counter = counter + 1;
    end
end

nNonText=counter; 
y=nNonText; % the number of non-texture features. 

z=numel(patientList);

nonTextureFeatures = zeros(y,z);

% Loop through the set of lesions
for j = 1:patientNum
    % Create variable to keep track of the feature type number
    filename=['FEATURES\',patientList{j},'_CT_',num2str(energyLevel),'kev(tumor2D).CTscan.mat'];
    load(filename);
    
    counter = 0;
    for l = 1:nTypes
        for m = 1:numel(typeNames{l})
            counter = counter + 1;
            % fprintf('%i %i \n', l,m)
            if l==4
                nonTextureFeatures(counter,j) = radiomics.image.(types{l}).scale2_algoFBN_bin64.(typeNames{l}{m});
            elseif l==5
                nonTextureFeatures(counter,j) = radiomics.image.(types{l}).algoNone_bin64_minM500_max400.(typeNames{l}{m});
                
            else
                nonTextureFeatures(counter,j) = radiomics.image.(types{l}).scale2.(typeNames{l}{m});
            end
        end
    end
end
end
