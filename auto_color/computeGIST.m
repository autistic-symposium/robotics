function computeGIST(folderPath,savename)
% Computes GIST descriptors for a folder of images and saves the
% descriptors in a .mat file. (Run this before you call fillImage.m.)
%
% Input:
% folderPath = path to a folder of images
% savename = name for the .mat file of GIST descriptors
%
% K. A. Ehinger, Nov 2012

% GIST parameters
param.imageSize = 256;
param.numberBlocks = 8;
param.orientationsPerScale = [8 6 6 4];
param.fc_prefilt = 4;
param.color = 1;

% Color transform structure for sRGB->L*a*b*
cform = makecform('srgb2lab');

% Check if the .mat file already exists
if exist([savename '.mat'],'file')
    disp([savename '.mat already exists and will be overwritten.']);
    flag = 0;
    while flag == 0
        s = input('Do you wish to continue? (y/n)', 's');
        if strcmp(lower(s),'n')
            return;
        elseif strcmp(lower(s),'y')
            flag = 1;
        end
    end
end

% Find the image files in the specified folder
files = dir(folderPath);
filenames = {};
for i = 1:length(files)
    [~,ext] = strtok(files(i).name,'.');
    if ~isempty(find(strcmp(lower(ext),{'.jpg','.jpeg','.png'})))
        filenames = vertcat(filenames,files(i).name);
    end
end
disp(['Computing GIST descriptors for ' int2str(length(filenames)) ' images']);

% Compute a GIST descriptor for each image in the folder and stack the
% descriptors into one large matrix
Nimages = length(filenames);
Nfeatures = sum(param.orientationsPerScale)*(param.numberBlocks^2);
if param.color == 1
    GIST = zeros(Nimages,3*Nfeatures);
    for i = 1:Nimages
        disp([int2str(i) '/' int2str(length(filenames))]);
        img = imread([folderPath '/' filenames{i}]);
        imgLab = applycform(img,cform);
        g = zeros(1,3*Nfeatures);
        for j = 1:3
            [des,~] = LMgist(imgLab(:,:,j), '', param);
            g(1,(Nfeatures*(j-1))+1:Nfeatures*j) = des;
        end
        GIST(i,:) = g;
    end
else
    GIST = zeros(Nimages,Nfeatures);
    for i = 1:Nimages
        disp([int2str(i) '/' int2str(length(filenames))]);
        img = imread([folderPath '/' filenames{i}]);
        [des,~] = LMgist(img, '', param);
        GIST(i,:) = des;
    end
end

% Save the GIST descriptors and image filenames
eval(['save ' savename ' GIST param folderPath filenames']);