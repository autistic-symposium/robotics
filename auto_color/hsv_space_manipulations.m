function [final_picture] = hsv_space_manipulations(gray_image, best_match_color_image, NUMBER)

clear best_match_color_image_hsv;
clear best_match_color_image_hsv_hue;
clear best_match_color_image_hsv_saturation
clear best_match_color_image_hsv_value
clear gray_image_hsv
clear gray_image_hsv_hue
clear gray_image_hsv_saturation
clear gray_image_hsv_value
clear gray_image_hsv_final
clear gray_image_rgb_final

% convert the matched color image from rgb to hsv
best_match_color_image_hsv = rgb2hsv(best_match_color_image);

% divide the matched color in the 3 dimensions 
best_match_color_image_hsv_hue = best_match_color_image_hsv(:,:,1); % hue
best_match_color_image_hsv_saturation = best_match_color_image_hsv(:,:,2);  % saturation
best_match_color_image_hsv_value = best_match_color_image_hsv(:,:,3);   % value

% add 3 dimensions to the gray image and then convert it from rgb to hsv
gray_image_hsv = rgb2hsv(gray2rgb(gray_image));

% divide the matched color in the 3 dimensions 
gray_image_hsv_hue = gray_image_hsv(:,:,1); % hue
gray_image_hsv_saturation = gray_image_hsv(:,:,2);  % saturation
gray_image_hsv_value = gray_image_hsv(:,:,3);   % value

% add the values for hue and saturation for the two images
gray_image_hsv_final =  gray_image_hsv;
gray_image_hsv_final(:,:,1)  = gray_image_hsv_final(:,:,1) + best_match_color_image_hsv(:,:,1);
gray_image_hsv_final(:,:,2)  = gray_image_hsv_final(:,:,2) + best_match_color_image_hsv(:,:,2);

% convert the final image from hsv to rgb
gray_image_rgb_final = hsv2rgb(gray_image_hsv_final);

% save all
FIG_FINAL = ['C:\Users\steinkirch\Desktop\homework1\final\' int2str(NUMBER) '.jpg'];
imwrite(gray_image_rgb_final, FIG_FINAL);

% for ilustration, save all the steps
if (NUMBER == 3) 

    FIG_EXAMPLE = ['C:\Users\steinkirch\Desktop\homework1\latex\example\test_img_' int2str(NUMBER) '.jpg'];
    imwrite(gray_image, FIG_EXAMPLE);
    
    FIG_EXAMPLE = ['C:\Users\steinkirch\Desktop\homework1\latex\example\test_img_' int2str(NUMBER) '_hsv.jpg'];
    imwrite(gray_image_hsv, FIG_EXAMPLE);
    
    FIG_EXAMPLE = ['C:\Users\steinkirch\Desktop\homework1\latex\example\test_img_' int2str(NUMBER) '_hue.jpg'];
    imwrite(gray_image_hsv_hue, FIG_EXAMPLE);
    
    FIG_EXAMPLE = ['C:\Users\steinkirch\Desktop\homework1\latex\example\test_img_' int2str(NUMBER) '_saturation.jpg'];
    imwrite(gray_image_hsv_saturation, FIG_EXAMPLE);
    
    FIG_EXAMPLE = ['C:\Users\steinkirch\Desktop\homework1\latex\example\test_img_' int2str(NUMBER) '_value.jpg'];
    imwrite(gray_image_hsv_value, FIG_EXAMPLE);
    
    FIG_EXAMPLE = ['C:\Users\steinkirch\Desktop\homework1\latex\example\train_img_' int2str(NUMBER) '.jpg'];
    imwrite(best_match_color_image, FIG_EXAMPLE);
    
    FIG_EXAMPLE = ['C:\Users\steinkirch\Desktop\homework1\latex\example\train_img_' int2str(NUMBER) '_hsv.jpg'];
    imwrite(best_match_color_image_hsv, FIG_EXAMPLE);
    
    FIG_EXAMPLE = ['C:\Users\steinkirch\Desktop\homework1\latex\example\train_img_' int2str(NUMBER) '_hue.jpg'];
    imwrite(best_match_color_image_hsv_hue, FIG_EXAMPLE);
    
    FIG_EXAMPLE = ['C:\Users\steinkirch\Desktop\homework1\latex\example\train_img_' int2str(NUMBER) '_saturation.jpg'];
    imwrite(best_match_color_image_hsv_saturation, FIG_EXAMPLE);
    
    FIG_EXAMPLE = ['C:\Users\steinkirch\Desktop\homework1\latex\example\train_img_' int2str(NUMBER) '_value.jpg'];
    imwrite(best_match_color_image_hsv_value, FIG_EXAMPLE);
    
end




