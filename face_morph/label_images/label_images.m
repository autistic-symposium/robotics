%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This module perform is a tool to label points in a
% picture and save them in a txt file.
%   Marina von Steinkirch, Stony Brook, 2013.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear

DO_CPSELECT = true;
DO_GINPUT = false;
NUMBER_OF_POINTS = 3;
FOLDER = 'C:\Users\steinkirch\Desktop\face_morph\label_images\';

[imgName, pathName] = uigetfile({'*.jpeg;*.jpg;*.tif;*.png;*.gif','All Image Files'; '*.*','All Files' },'Select the image to label the points:');
input = strcat(pathName,imgName);

if DO_GINPUT
    figure(1), hold off, imshow(input)
    [x,y] = ginput(NUMBER_OF_POINTS)
end

if DO_CPSELECT
    [x,y] = cpselect(input, input, 'Wait', true);
end

pts = [x(:) y(:)]
output = strcat(FOLDER,'points.txt');
save(output, 'pts', '-ascii')   