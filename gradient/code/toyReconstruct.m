%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reconstruct a image from its gradient values in three ways (e.g. plus
% some integer number of pixel of intensity).
%
% marina von steinkirch, spring/2013
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function im_out = toyReconstruct(im_toy)

% calculate number of pixels e a matrix for index them

[imh, imw] = size(im_toy);
n_pixels = imw*imh;
A = spalloc(n_pixels, n_pixels, n_pixels*5);
i = 1;
for c = 1 : imw;
    for r = 1 : imh;   
        img2var(c,r) = i;
        b(i) = 0;
        v(i) = 0;
        i = i + 1;
    end
end

% create system of equations
DO_1 = false;
DO_2 = false;
DO_3 = true;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% problem 1
if DO_1
    e = 1;
    for c = 1 : imw-1;
        for r = 1 : imh-1;
            A(e, img2var(c,r+1))= -1;
            A(e, img2var(c,r)) = 1;     
            b(e) = im_toy(r+1,c) - im_toy(r, c);
            e = e + 1;
        end
    end
    v = lscov( A ,b(:));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% problem 2
if DO_2
    e = 1;
    for c = 1 : imw-1;
        for r = 1 : imh-1;
            A(e, img2var(c+1,r))= -1;
            A(e, img2var(c,r)) = 1;     
            b(e) = im_toy(r, c+1) - im_toy(r, c);
            e = e + 1;
        end
    end
end
v = lscov( A ,b(:));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% problem 3
if DO_3
    e = 1;
    for c = 1 : imw-1;
        for r = 1 : imh-1;
            A(e, img2var(1,1))= -1;   
            b(e) = im_toy(1, 1);
        end
    end
end
v = lscov( A ,b(:));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% recover the image
im_out = zeros(size(im_toy));
i = 1;
for c=1:imw-1
    for r=1:imh-1
        im_out(r, c) = im_toy(r, c) + v(i);
        i = i +1;
    end
end

