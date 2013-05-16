function [best_match_color_figure_index] = loop_over_color(gray_image, N_IMG_COLOR)

TOTAL_IMAGE = N_IMG_COLOR +1;

clear param;
clear distance_array;
clear gist;

param.imageSize = [256 256]; %set a normalized image size, eg [256 256]
param.orientationsPerScale = [8 8 8 8]; % number of orientations per scale
param.numberBlocks = 4;
param.fc_prefilt = 4;
Nfeatures = sum(param.orientationsPerScale)*param.numberBlocks^2;

gist = zeros([TOTAL_IMAGE Nfeatures]); 
distance_array = [N_IMG_COLOR];

% gist descriptor for the query image
[gist(1, :), param] = LMgist(gray_image, '', param); 

% Loop over color images
for i = 1:N_IMG_COLOR
   FOLDER_COLOR = ['C:\Users\steinkirch\Desktop\homework1\data\faces\trainset\' int2str(i) '.jpg'];
   color_image = imread(fullfile(FOLDER_COLOR));
   gist(i+1, :) = LMgist(color_image, '', param); 
   distance_array(i) = sum((gist(1)-gist(i+1).^2));
end

[value, index] = min(reshape(distance_array, numel(distance_array), 1));
[i,best_match_color_figure_index] = ind2sub(size(distance_array), index);

