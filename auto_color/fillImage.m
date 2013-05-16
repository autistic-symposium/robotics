function fillImage(img,mask,GISTmatfile)
% Fill in missing pixels of an image using data from a neighboring image in
% GIST space. Before you run this, you must set up a GIST database by
% running computeGIST.m.
%
% Input:
% img = an image matrix
% mask = a binary mask the same height and width as the image (1 = image
% pixel, 0 = missing pixel that should be filled in)
% GISTmatfile = the name of the .mat file created by computeGIST.m
%
% K. A. Ehinger, Nov 2012

% Check that mask is the same size as image
if (size(mask,1) ~= size(img,1))||(size(mask,2) ~= size(img,2))
    display('ERROR: The mask must be the same width/height as the image');
end

% Load the precomputed GIST descriptors and GIST parameters
try
    load(GISTmatfile);
catch
    disp(['ERROR: Could not load the .mat file ' GISTmatfile]);
    return;
end

% Color transform structure for sRGB->L*a*b*
cform = makecform('srgb2lab');

% Compute GIST descriptor for the query image
if param.color == 1
    imgLab = applycform(img,cform);
    g = zeros(1,3*Nfeatures);
    for j = 1:3
        [des,~] = LMgist(imgLab(:,:,j), '', param);
        g(1,(Nfeatures*(j-1))+1:Nfeatures*j) = des;
    end
else
    [g,~] = LMgist(img, '', param);
end

% Make sure the mask is 2d and in the range 0-1
mask = double(mask);
if size(mask,3) > 1
    mask = mean(mask,3);
end
mask = (mask-min(mask(:))) / (max(mask(:))-min(mask(:)));

% Crop both the query image and the mask to the central square portion used
% to compute the GIST descriptor
m = min([size(img,1) size(img,2)]);
s = floor(([size(img,1) size(img,2)]-m)/2);
img = img(s(1)+1:s(1)+m,s(2)+1:s(2)+m,:);
mask = mask(s(1)+1:s(1)+m,s(2)+1:s(2)+m);
mask_sm = imresize(mask,[param.imageSize param.imageSize]);

% GIST weights are the average value of mask pixels within each block
s = floor(linspace(0,param.imageSize,param.numberBlocks+1));
blockWeight = zeros(param.numberBlocks);
for y = 1:param.numberBlocks
    for x = 1:param.numberBlocks
        block = mask_sm(s(y)+1:s(y+1),s(x)+1:s(x+1));
        blockWeight(y,x) = mean(block(:));
    end
end
blockWeight = repmat(blockWeight(:)',[1 sum(param.orientationsPerScale)]);

% Calculate weighted Euclidean distance
dist = GIST - repmat(g,[size(GIST,1) 1]);
dist = repmat(blockWeight,[size(GIST,1) 1]).*dist;
dist = sum(dist.^2,2);

% Get 5 nearest images and use them to fill in missing pixels of query
% image; display results
Nresults = 5;
[~,ind] = sort(dist,'ascend');
k = find(mask == 0);
for i = 1:Nresults
    dbImg = imread([folderPath '/' filenames{ind(i)}]);
    % Resize and crop the retrieved image to match the query image size
    m = min([size(dbImg,1) size(dbImg,2)]);
    s = floor(([size(dbImg,1) size(dbImg,2)]-m)/2);
    dbImg = dbImg(s(1)+1:s(1)+m,s(2)+1:s(2)+m,:);
    dbImg = imresize(dbImg,[size(img,1) size(img,2)]);
    % Replace missing pixels with pixels from retrieved image
    filledImg = img;
    for j = 1:length(y)
        filledImg(y(j),x(j),:) = dbImg(y(j),x(j),:);
    end
    % Display figure
    figure;
    for j = 1:length(y)
        img(y(j),x(j),1) = 255; img(y(j),x(j),2) = 0; img(y(j),x(j),3) = 255;
    end
    subplot(2,2,1); imshow(img); title('Query image (magenta = missing)')
    subplot(2,2,2); imshow(dbImg);
    title([int2str(i) '. ' filenames{ind(i)} ', GIST distance = ' num2str(dist(ind(i)))]);
    subplot(2,2,3); imshow(uint8(filledImg)); title('Filled image')
    
end