clc; clear; close all;

%carico le librerie in memoria
run('vlfeat-0.9.18/toolbox/vl_setup')

num_cluster = 8;
canny=1;
sel_img=16;

Images = cell(1,16);
for index = 1:16
    Images{1, index} = imread(strcat('test_img/',num2str(index),'.jpg'));
end

colors = ['b.';'m.';'c.';'r.';'g.';'w.';'y.';'k.'];

figure;