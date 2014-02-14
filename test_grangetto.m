clc; clear; close all;
run('vlfeat-0.9.17/toolbox/vl_setup')

I = imread('test_img/1.jpg');
I_bn = rgb2gray(I);
I_edge = edge(I_bn, 'canny');
imshow(I_edge);

I_dl = imdilate(I_edge, ones(5,5));
I_fn = I_bn .* uint8(I_dl);
imshow(I_fn);

[fa,da] = vl_sift(single(I_fn));
h1_b = vl_plotframe(fa);
h2_b = vl_plotframe(fa);

set(h1_b,'color','k','linewidth',3) ;
set(h2_b,'color','y','linewidth',2) ;


figure;
[fb,db] = vl_sift(single(I_bn));
h1_b = vl_plotframe(fb);
h2_b = vl_plotframe(fb);

set(h1_b,'color','k','linewidth',3) ;
set(h2_b,'color','y','linewidth',2) ;