This program performs gradient-domain fusion between an image and a background with two techniques:
	
	1) Poisson Blending,
	2) Mixed Gradients.


It is composed of the folling modules:

	1) main.m: main module, where you select which thecnique you want to use.

	2) toy_reconstruct.m: perform the toy problem.	

		The error was 0+2.3631e-05i		

	3) poissonBlend.m: perform Poisson blending, using the following submodules:
		3.1) alignSource.m: align both mask and source image to the background.
		3.2) getMask.m: get the mask for the source image.

		The resulting compositions are in the folder results_poisson

	4) mixedBlend.m: perform mixed blending, using the following submodules:
		4.1) alignSource.m: align both mask and source image to the background.
		4.2) getMask.m: get the mask for the source image.

		The resulting compositions are in the folder results_mixed


Marina von Steinkirch, Stony Brook, 2013.