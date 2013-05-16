%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code align a source image and a mask to a target image
%  based from Derek Hoeim's code, 2013
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [im_s2, mask2] = alignSource(im_s, mask, im_t)

figure(1), hold off, imagesc(im_s), axis image % source
figure(2), hold off, imagesc(im_t), axis image % target

% find the nonzero elements of the mask
[y, x] = find(mask);   

% find limits from mask
y1 = min(y)-1; 
y2 = max(y)+1; 
x1 = min(x)-1; 
x2 = max(x)+1;

% crete an image array with the size of the target, with zeros
im_s2 = zeros(size(im_t));

% collect from the user the position in the target image
disp('choose target bottom-center location')
[tx, ty] = ginput(1);

% change coordinates for the background,
% first for the range of indices of the mask as a square
yind = (y1:y2);
xind = (x1:x2);
yind2 = yind - max(y) + round(ty);
xind2 = xind - round(mean(x)) + round(tx);
% then for mask, as the poligon
y = y - max(y) + round(ty);
x = x - round(mean(x)) + round(tx);

% create index for the mask
ind = y + (x-1)*size(im_t, 1) ;

% makes everything in the new mask be 0
mask2 = false(size(im_t, 1), size(im_t, 2));

% makes the place where the image is be true
mask2(ind) = true;

% Change the indices for the image source
im_s2(yind2, xind2, :) = im_s(yind, xind, :);

% replicates the mask aray for 1x1x3 dimenstions in the the right
% indices of image source (cut paste to the target)
newmask = repmat(mask2, [1 1 3]);
im_t(newmask) = im_s2(newmask) ;

figure(1), hold off, imagesc(im_s2), axis image;
figure(2), hold off, imagesc(im_t), axis image;
%figure(5), hold off, imagesc(newmask), axis image;
drawnow;
