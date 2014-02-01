clc; clear; close all;
%carico le immagini
Ia = imread('roofs1.jpg');
Ib = imread('roofs_r.jpg');
imshow(Ia);
figure; imshow(Ib);

%le converto in scala di grigi in singola precisione
Ia = single(rgb2gray(Ia));
Ib = single(rgb2gray(Ib));

%calcolo i keypoint e le i descrittori di SIFT
[fa, da] = vl_sift(Ia);
[fb, db] = vl_sift(Ib);

%effettuo il matching tra i descrittori (128 dimensioni)
%(viene calcolata la distanza euclidea fra i vettori)
[matches, score] = vl_ubcmatch(da, db);







