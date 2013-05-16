%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   This program performs the face morphism between two images 
%   from their correspondence points.
%
%   Marina von Steinkirch, spring/2013
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear

NUMBER_OF_FRAMES = 3 ;
GENERATE_SAVED_FIGURES = true;



FOLDER = 'C:\Users\steinkirch\Desktop\mean_me\';    %face_morph\morph_two_pictures\';
ORIGIN_IMG = 'steinkirch.jpg';
ORIGIN_IMG_PATH = strcat(FOLDER,ORIGIN_IMG);
source = double(imread(ORIGIN_IMG_PATH))./255;      



ORIGIN_IMG_PTS = 'steinkirch.txt';
ORIGIN_IMG_PATH_PTS = strcat(FOLDER,ORIGIN_IMG_PTS);        
origin_pts = importdata(ORIGIN_IMG_PATH_PTS);


% define morph factor 
% (anything outside [0,1] defines caricature)
warp_frac= zeros(NUMBER_OF_FRAMES, 1);	
for n = 1:NUMBER_OF_FRAMES
    frac = (n-1)/(NUMBER_OF_FRAMES - 1);
    warp_frac(n, 1) = frac; 
end



% write image files
if GENERATE_SAVED_FIGURES
    for m = 1:20
        
        % load corresponding points

        
        DESTINATION_IMG_PTS = sprintf('class/%d.txt',m);
        DESTINATION_IMG_PATH_PTS = strcat(FOLDER,DESTINATION_IMG_PTS);
        target_pts = importdata(DESTINATION_IMG_PATH_PTS);
        
       
        file = sprintf('fun_%2.2d.jpg',m);
        

        morphed_im = morph(source, source, origin_pts, target_pts, warp_frac);
        image = morphed_im{2, 1};     
        
        Ig = imadjust(image,stretchlim(image),[]);
        
        
        DESTINATION_IMG_PATH_PTS = strcat(FOLDER,file);
        imwrite(Ig,DESTINATION_IMG_PATH_PTS);
    end
end

