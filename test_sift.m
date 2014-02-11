clc; clear; close all;
Im1 = imread('test_img/1.jpg');

Images = cell(1,15);

for index = 2:16
    Images{1, index-1} = imread(strcat('test_img/',num2str(index),'.jpg'));
end

sim = SIFT_Similarity(Im1,Images);
figure;
subplot(4,4,1);
imshow(Im1);
title('Immagine originale "1.jpg"');
for index = 2:16
    subplot(4,4,index);
    imshow(Images{1, index-1});
    title(strcat('Immagine  "',num2str(index),'.jpg" con sim = ',num2str(sim(index-1))));
end
