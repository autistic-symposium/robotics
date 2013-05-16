%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

In this project we demonstrate the technique of face morphing by creating a sequence of simultaneously warped and cross-dissolved image. Extra tools calculate mean values for many images and perform funny results and transformations on face images.

Marina von Steinkirch, spring/2013

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Modules:


1) label_images/label_images.m
Allows the user to save in a txt file the points that should be correlated between images. 


2) morph_two_pictures/main.m
Perform the face morphism between to images with the labeled points from the last step.


3) calculate_mean/main.m
Compute the average shape among many images and warp all the face images to an average shape, averaging the pixel intensity.


4) some_fun/
Playing with the previous modules to produce funny results.


5) latex/
Documentation.

