from PIL import Image
import colorsys
import numpy as np
import argparse

def get_lightness(filename):
	'''
	Obtains the average lightness value of an image. Lightness value
	falls in the range 0 (extremely dark) - 256 (extremely bright).

	To do so, this function converts the image with name filename into 
	an HLS image, then extracts the lightness component for each 
	pixel. Then it returns the average lightness value across all 
	pixels in the image.
	'''
	hls_pixels = []

	im = Image.open(filename)
	for i in range(im.size[0]):
		for j in range(im.size[1]):
			hls_pixels.append(colorsys.rgb_to_hls(*im.load()[i, j]))
	return np.average([pix[1] for pix in hls_pixels])


if __name__ == "__main__":
	'''
	Take in a filename of an image as a command line argument.
	Print out the average lightness value of the image with the filename
	referenced from the command line argument.
	'''
	parser = argparse.ArgumentParser(description="Obtain average lightness value of an image file.")
	parser.add_argument("filename", help="The filename of the image.")

	args = parser.parse_args()
	print(get_lightness(args.filename))