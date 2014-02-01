clear; clc;

%carico le librerie in memoria
run('vlfeat-0.9.17/toolbox/vl_setup')

%carico l'immagine di partenza e la visualizzo
%I = vl_impattern('roofs1');
%image(I);
I = imread('roofs1.jpg');
imshow(I);
%La trasformo in Scala di Grigi in precisione singola in modo da
%avere un intervallo tra [0, 255] per i valori
I = single(rgb2gray(I));

%calcolo i descrittori di SIFT
% F = contengono le informazioni di ciascuno dei keypoint:
%     f[1] = x; f[2] = y;
%     f[3] = scalatura
%     f[4] = orientamento in radianti

% D = contiene i descrittore delle aree adiacenti ai keypont
% ovvero 8 Matrici, 4x4, dei gradienti
[f, d] = vl_sift(I);

% Stampo 50 keypoint casuali tra quelli trovati
perm = randperm(size(f,2)) ;
sel = perm(1:50) ;
h1 = vl_plotframe(f(:,sel)) ;
h2 = vl_plotframe(f(:,sel)) ;
set(h1,'color','k','linewidth',3) ;
set(h2,'color','y','linewidth',2) ;

% Stampo i descrittori dei keypoint trovati
h3 = vl_plotsiftdescriptor(d(:,sel),f(:,sel)) ;
set(h3,'color','g') ;










