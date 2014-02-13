clc, clear; close all;

I = imread('test_img/1.jpg');
I_bn = rgb2gray(I);

imshow(I);



%estraggo i keypoint dall'immagine direttamente
[f, d] = vl_sift(single(I_bn));
h1 = vl_plotframe(f);
h2 = vl_plotframe(f);

set(h1,'color','k','linewidth',3);
set(h2,'color','y','linewidth',2);
figure;


%estraggo i punti si sift considerando solo i contorni dell'immagine
BW = edge(I_bn, 'canny');
imshow(BW);

[fa, da] = vl_sift(single(BW));
h3 = vl_plotframe(fa);
h4 = vl_plotframe(fa);

set(h3,'color','k','linewidth',3);
set(h4,'color','y','linewidth',2);
figure;

%considero l'immagine di confronto
I2 = imread('test_img/8.jpg');
imshow(I2);
I2_bn = rgb2gray(I2);

BW2 = edge(I2_bn, 'canny');
[fb, db] = vl_sift(single(BW2));
dist1 = Sift_Matching(da, db);

I3 = imread('test_img/16.jpg');
BW3 = edge(rgb2gray(I3), 'canny');
[fc, dc] = vl_sift(single(BW3));
dist2 = Sift_Matching(da, dc);

I4 = imread('test_img/3.jpg');
BW4 = edge(rgb2gray(I4), 'canny');
[fd, dd] = vl_sift(single(BW4));
dist3 = Sift_Matching(da, dd);

soglia = max(max(max(max(dist1)), max(max(dist2))), max(max(dist3)));
sim1 = 1 - (dist1/soglia);
sim2 = 1 - (dist2/soglia);
sim3 = 1 - (dist3/soglia);

s1_mx = max(max(sim1))
s1_mn = min(min(sim1))
s1_md = mean(mean(sim1))
s1_median = median(median(sim1))
s1_moda = mode(mode(sim1))


s2_mx = max(max(sim2))
s2_mn = min(min(sim2))
s2_md = mean(mean(sim2))
s2_median = median(median(sim2))
s2_moda = mode(mode(sim2))


s3_mx = max(max(sim3))
s3_mn = min(min(sim3))
s3_md = mean(mean(sim3))
s3_median = median(median(sim3))
s3_moda = mode(mode(sim3))














