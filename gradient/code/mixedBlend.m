%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This module calculates the Poisson blending.
%  Marina von Steinkirch, spring, 2013
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [im_mixed] = mixedBlend(im_object, im_background, im_mask)


% calculate number of pixels.
n_pixels = size(im_background, 1) * size(im_background, 2);


% create matrices that contains the indexes
ind_1D = zeros(size(im_background, 1), size(im_background, 2));
i = 1;
for c = 1 : size(im_background, 2);
    for r = 1 : size(im_background, 1);
        ind_1D(r, c) = i;
        i = i + 1;
    end
end


% initialize sparse matrix and vector field
A = spalloc(n_pixels, n_pixels, n_pixels * 5);
b = zeros(n_pixels, 3);


% create system of equations
for c=1:size(im_background, 2)
    for r=1:size(im_background, 1)
        row = ind_1D(r, c);

        if im_mask(r, c) == 0
            A(row, row) = 1;
            b(row, 1) = 0;
            b(row, 2) = 0;
            b(row, 3) = 0;
        else
            for ind_channel = 1 : 3
                im_object_Laplacian = 4 * im_object(r, c, ind_channel) ...
                    - im_object(r + 1, c, ind_channel) ...
                    - im_object(r - 1, c, ind_channel) ...
                    - im_object(r, c + 1, ind_channel) ...
                    - im_object(r, c - 1, ind_channel);

                
                im_background_Laplacian = 4 * im_background(r, c, ind_channel) ...
                    - im_background(r + 1 , c, ind_channel) ...
                    - im_background(r - 1, c, ind_channel) ...
                    - im_background(r, c + 1, ind_channel) ...
                    - im_background(r, c - 1, ind_channel);
                
                b(row, ind_channel) = im_object_Laplacian - im_background_Laplacian;
            end
            if im_object_Laplacian > im_object_Laplacian
                A(row, row) = 4;
                A(row, row + 1) = -1;
                A(row, row - 1) = -1;
                A(row, row + size(im_background, 1)) = -1;
                A(row, row - size(im_background, 1)) = -1;        
            else
                A(row, row) = 4;
                A(row, row + 1) = -1;
                A(row, row - 1) = -1;
                A(row, row + size(im_object, 1)) = -1;
                A(row, row - size(im_object, 1)) = -1;
            end
        end
    end
end


% solve system of equations for each channel
tic;
xr = A \ b(:, 1);
xg = A \ b(:, 2);
xb = A \ b(:, 3);
toc;


% full gradient-domain composite from solution.
im_mixed = zeros(size(im_background));
i = 0;
for c=1:size(im_background, 2)
    for r=1:size(im_background, 1)
        i = i+1;
        % add each color composite to residual to obtain the gradient-domain composite.
        im_mixed(r, c, 1) = im_background(r, c, 1) + xr(i);
        im_mixed(r, c, 2) = im_background(r, c, 2) + xg(i);
        im_mixed(r, c, 3) = im_background(r, c, 3) + xb(i);
    end
end