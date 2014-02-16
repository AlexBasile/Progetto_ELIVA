clc; clear; close all;

%carico le librerie in memoria
run('vlfeat-0.9.18/toolbox/vl_setup')

num_cluster = 8;
canny=1;
sel_img=16;
num_images=32;

Images = cell(1,num_images);
for index = 1:num_images
    Images{1, index} = imread(strcat('test_img/',num2str(index),'.bmp'));
end

colors = ['b.';'m.';'c.';'r.';'g.';'w.';'y.';'k.'];

figure;