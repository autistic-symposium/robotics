%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   This program performs the face morphism between two images 
%   from their correspondence points.
%
%   Marina von Steinkirch, spring/2013
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear

NUMBER_OF_FRAMES = 21;
GENERATE_SAVED_FIGURES = true;

FOLDER = 'C:\Users\steinkirch\Desktop\transformations\';    
ORIGIN_IMG = 'prebf.jpg';
DESTINATION_IMG = 'posbf.jpg';
ORIGIN_IMG_PTS = 'points_src.txt';
DESTINATION_IMG_PTS = 'points_tg.txt';


% define paths for images and their label points
ORIGIN_IMG_PATH = strcat(FOLDER,ORIGIN_IMG);
DESTINATION_IMG_PATH = strcat(FOLDER,DESTINATION_IMG);
ORIGIN_IMG_PATH_PTS = strcat(FOLDER,ORIGIN_IMG_PTS);
DESTINATION_IMG_PATH_PTS = strcat(FOLDER,DESTINATION_IMG_PTS);


% load images for morphing
source = double(imread(ORIGIN_IMG_PATH))./255;      
target = double(imread(DESTINATION_IMG_PATH))./225;


% load corresponding points
origin_pts = importdata(ORIGIN_IMG_PATH_PTS);
target_pts = importdata(DESTINATION_IMG_PATH_PTS);


% define morph factor 
% (anything outside [0,1] defines caricature)
warp_frac= zeros(NUMBER_OF_FRAMES, 1);	
for n = 1:NUMBER_OF_FRAMES
    frac = (n-1)/(NUMBER_OF_FRAMES - 1);
    warp_frac(n, 1) = frac; 
end


% perform the face morphism
morphed_im = morph(source, target, origin_pts, target_pts, warp_frac);


% write image files
if GENERATE_SAVED_FIGURES
    for m = 1:length(morphed_im)
        image = morphed_im{m, 1};
        file = sprintf('zombie_bf_%2.2d.jpg',m);
        DESTINATION_IMG_PATH_PTS = strcat(FOLDER,file);
        imwrite(image,DESTINATION_IMG_PATH_PTS);
    end
end