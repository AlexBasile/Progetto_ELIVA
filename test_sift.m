
Im1 = imread('test_img/1.jpg');

Images = cell(1,15);

for index = 2:16
    Images{1, index-1} = imread(strcat('test_img/',num2str(index),'.jpg'));
end

sim = SIFT_Similarity(Im1,Images);
sim