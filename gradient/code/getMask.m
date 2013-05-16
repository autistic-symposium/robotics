% This code asks user to draw polygon around input image and then provides 
% a binary mask of  polygon and a chain of all interior boundary points.
% (from Derek Hoeim course), 2013

function [mask, poly] = getMask(im)

% input the polygon
disp('Draw polygon around source object in clockwise order, q to stop')
figure(1), hold off, imagesc(im), axis image;
sx = [];
sy = [];
while 1
    figure(1)
    [x, y, b] = ginput(1);
    if b=='q'
        break;
    end
    sx(end+1) = x;
    sy(end+1) = y;
    hold on, plot(sx, sy, '*-');
end

% create binary mask
mask = poly2mask(sx, sy, size(im, 1), size(im, 2));

% nargout returns the number of output specified in the call 
if nargout>1
    [poly.x, poly.y] = mask2chain(mask);
end
