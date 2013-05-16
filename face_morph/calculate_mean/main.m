%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   This program calculates the mean face from many
%   faces.
%
%   Marina von Steinkirch, spring/2013
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear

% choose what you want to calculate
DO_AVERAGE = true;
COMPUTE_IMG = true;
AVERAGE_PIXEL = true;


% define constants
NUMBER_OF_STUDENTS = 20;
NUMBER_OF_FRAMES = 1;
FOLDER = 'C:\Users\steinkirch\Desktop\mean\class\';   

IMG_ME_PTS = sprintf('steinkirch.txt');
IMG_ME_PATH_PTS = strcat(FOLDER,IMG_ME_PTS);
me_points = importdata(IMG_ME_PATH_PTS);
IMG_ME = sprintf('steinkirch.jpg');
IMG_ME_PATH = strcat(FOLDER, IMG_ME);
me_img = double(imread(IMG_ME_PATH))./255; 



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% compute the average shape
if DO_AVERAGE
    class_mean = me_points;
    for m = 1:NUMBER_OF_STUDENTS
        IMG_PTS = sprintf('%d.txt',m);
        IMG_PTS_PATH = strcat(FOLDER,IMG_PTS);
        target_pts = importdata(IMG_PTS_PATH);
        class_mean = (class_mean + target_pts)/2.0;
    end
    MEAN_POINT_FILES = strcat(FOLDER, 'mean_class.txt');
    save(MEAN_POINT_FILES, 'class_mean', '-ascii');
    fprintf('Average shape calculated.\n');
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% warp all faces to the average shape
if COMPUTE_IMG

    for m = 1:NUMBER_OF_STUDENTS
        IMG = sprintf('%d.jpg', m);
        IMG_PATH = strcat(FOLDER, IMG);
        source = double(imread(IMG_PATH))./255;  
        IMG_PTS = sprintf('%d.txt',m);
        IMG_PTS_PATH = strcat(FOLDER,IMG_PTS);
        origin_pts = importdata(IMG_PTS_PATH);
        class_mean = importdata(strcat(FOLDER,'mean_class.txt'));
    
        image = morph(source, source, origin_pts, class_mean, 1.0);
        image_layer = image{NUMBER_OF_FRAMES,1};
        
        Ig = imadjust(image_layer,stretchlim(image_layer),[]);
        OUTPUT_IMG = sprintf('mean_%d.jpg',m);
        OUTPUT_PATH = strcat(FOLDER, OUTPUT_IMG);
        imwrite(Ig ,OUTPUT_PATH);
    end   
    

    fprintf('Faces warped to the average shape.\n');
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% average the pixel intensity
if AVERAGE_PIXEL
    final_mean = zeros(size(me_img));
    
    for m = 1:NUMBER_OF_STUDENTS
        IMG = sprintf('mean_%d.jpg', m);
        IMG_PATH = strcat(FOLDER, IMG);
        source = double(imread(IMG_PATH))./255;  
        
        final_mean = source + final_mean;
    end
    
    final_mean = final_mean/NUMBER_OF_STUDENTS;
    Ig = imadjust(final_mean,stretchlim(final_mean),[]);
    
    OUTPUT_IMG = sprintf('mean.jpg',m);
    OUTPUT_PATH = strcat(FOLDER, OUTPUT_IMG);
    imwrite(Ig ,OUTPUT_PATH);
    fprintf('Mean face calculated.\n');

end

      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% average the pixel intensity
if AVERAGE_PIXEL
    final_mean = zeros(size(me_img));
    
    for m = 1:NUMBER_OF_STUDENTS
        IMG = sprintf('mean_%d.jpg', m);
        IMG_PATH = strcat(FOLDER, IMG);
        source = double(imread(IMG_PATH))./255;  
        
        final_mean = source + final_mean;
    end
    
    final_mean = final_mean/NUMBER_OF_STUDENTS;
    Ig = imadjust(final_mean,stretchlim(final_mean),[]);
    
    OUTPUT_IMG = sprintf('mean.jpg',m);
    OUTPUT_PATH = strcat(FOLDER, OUTPUT_IMG);
    imwrite(Ig ,OUTPUT_PATH);
    fprintf('Mean face calculated.\n');

end


    