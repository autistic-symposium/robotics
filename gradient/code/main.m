%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code perform gradient-domain fusion between an image and a
% background with two techniques:
%   1) Poisson Blending,
%   2) Mixed Gradients.
%
%   This is homework for Tamara Berg's class. The code also includes 
%   an option for a toy model that just reconstruct the image from 
%   its gradient.
%   Marina von Steinkirch, Stony Brook, 2013.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Select the model you want:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DO_TOY = false;
DO_BLEND = false;
DO_MIXED  = true;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Case Poisson Blending
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if DO_BLEND
    
    % open images
    disp('Select a image for your target object...');
    [fileName, pathName] = uigetfile({'*.jpeg;*.jpg;*.tif;*.png;*.gif','All Image Files'; '*.*','All Files' },'Pick an Image for the Object:');
    im_object_name = strcat(pathName,fileName);
    im_object = imresize(im2double(imread(im_object_name)), 0.25, 'bilinear');
    
    disp('Select a image for your source background...');
    [fileName, pathName] = uigetfile({'*.jpeg;*.jpg;*.tif;*.png;*.gif','All Image Files'; '*.*','All Files' },'Pick an Image for the Background:');
    im_background_name = strcat(pathName,fileName);
    im_background = imresize(im2double(imread(im_background_name)), 0.5, 'bilinear');

    
    % get  mask from the user
    im_mask = getMask(im_object);                                                          % just a mask in the size of the im_object
    [im_object_aligned, im_mask_aligned] = alignSource(im_object, im_mask, im_background); % everything in size of the target image
    
    
    % perform Poisson blending and shows the final result 
    im_blend = poissonBlend(im_object_aligned, im_background, im_mask_aligned);
    figure(3), hold off, imshow(im_blend)
    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Case Mixed Gradients
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if DO_MIXED
    
    % open images
    disp('Select a image for your target object...');
    [fileName, pathName] = uigetfile({'*.jpeg;*.jpg;*.tif;*.png;*.gif','All Image Files'; '*.*','All Files' },'Pick an Image for the Object:');
    im_object_name = strcat(pathName,fileName);
    im_object = imresize(im2double(imread(im_object_name)), 0.75, 'bilinear');
    
    disp('Select a image for your source background...');
    [fileName, pathName] = uigetfile({'*.jpeg;*.jpg;*.tif;*.png;*.gif','All Image Files'; '*.*','All Files' },'Pick an Image for the Background:');
    im_background_name = strcat(pathName,fileName);
    im_background = imresize(im2double(imread(im_background_name)), 0.5, 'bilinear');

    
    % get  mask from the user
    im_mask = getMask(im_object);                                                          % just a mask in the size of the im_object
    [im_object_aligned, im_mask_aligned] = alignSource(im_object, im_mask, im_background); % everything in size of the target image
    
    
    % perform Poisson blending and shows the final result 
    im_mixed = mixedBlend(im_object_aligned, im_background, im_mask_aligned);
    figure(3), hold off, imshow(im_mixed)
    
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Case Toy Model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if DO_TOY 
    im_toy = im2double(imread('C:\Users\steinkirch\Desktop\gradient-domain_fusion\samples\toy_problem.png')); 
    im_out = toyReconstruct(im_toy);
    imshow(im_out)
end