I=single(rgb2gray(imread('1.bmp')));
I_canny=single(edge(I,'canny'));
I_dilate=single(I.*imdilate(I_canny,ones(3,3)));
imshow(uint8(I));
figure
imshow(I_canny);
figure
imshow(I_dilate);