function [gray_image_rgb]=gray2rgb(gray_image)
%Gives a grayscale image an extra dimension (m x n x 3)in order to use color within it.

[m n] = size(gray_image);
rgb = zeros(m,n,3);
rgb(:,:,1)= gray_image;
rgb(:,:,2)= rgb(:,:,1);
rgb(:,:,3)= rgb(:,:,1);

gray_image_rgb = rgb/255;
