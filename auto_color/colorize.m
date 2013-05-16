%
%   Program that automatically colorize automatically "colorize" a set of 
%   grayscale face images(query images) using a large database of color face images
%   (training images).
%
%   First we compute image descriptors for the grayscale query image and
%   for the 30,181 color training images, scoring them. Then we compare
%   their descriptors to find the nearest match. Finally, we transfer color 
%   from the matched training image to the query image.
%
%   Marina von Steinkirch, spring/2013
%


% set global variables and parameters
clear all;
close all;
clc;


% global variables
N_GRAY_IMAGE = 3;% 100;
N_IMG_COLOR = 10;% 30,181;


% Loop over the gray query images
for i = 3:N_GRAY_IMAGE
    
    % load query gray figure
    FOLDER_GRAY = ['C:\Users\steinkirch\Desktop\homework1\data\faces\testset\' int2str(i) '.jpg'];
    gray_image = imread(fullfile(FOLDER_GRAY));
    
    % function that compute gist descriptor for gray and color images and find best match
    best_match_color_image_index = loop_over_color(gray_image, N_IMG_COLOR)
    
    % load best match color figure
    COLOR_MATCHED = ['C:\Users\steinkirch\Desktop\homework1\data\faces\trainset\' int2str(best_match_color_image_index) '.jpg'];
    best_match_color_image =  imread(fullfile(COLOR_MATCHED));
    
    % Calculate and save results over the gray query images in the HSV space
    hsv_space_manipulations(gray_image, best_match_color_image, i);

end



