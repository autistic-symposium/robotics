***********************************************************************
				OVERVIEW
***********************************************************************

In this program, we automatically "colorize" a set of grayscale face images using a large data base of color face images.



***********************************************************************
				IMPLEMENTATION
***********************************************************************

(I) (Choice of image descriptor) We compute image descriptors for 100 grayscale query images and 30,181 color training images:

- We use tiny image descriptors, computing for all query and all color training images.

- We use gist image descriptors, computing for all query and all color training images.

- We compute a combined score, averaging the tiny image score and the gist score. 



(II) (Choice of image similarity measure) We retrieve the training image that is most similar to the query:

- We compare the sum of squared distances (SSD) between two images. Each image is normalized to have zero mean and unit norm, index the images using the first 19 principal components.
	


(III) (Choice of color space for transfer) After identifying a matching training image, we transfer color from the matched training image to the query image, to colorize the grayscale query image:

- We convert the query image and the best training image both to HSV.

- We separate these HSV images on 3 dimensions, hue, saturation, and value (the grayscale image does not have any data in hue or saturation when converted to the HSV space). 

- We copy the hue and saturation values from the matching training image, adding the resulting hue, saturation, and value in 3 dimensions . 
	
- We convert the resulting HSV image back to RGB space.