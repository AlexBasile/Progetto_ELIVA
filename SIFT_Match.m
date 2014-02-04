clc; clear; close all;
%carico le immagini
Ia = imread('test_img/1.jpg');
Ib = imread('test_img/16.jpg');
imshow(Ia);
%le converto in scala di grigi in singola precisione
Ia = single(rgb2gray(Ia));

[fa, da] = vl_sift(Ia);
h1 = vl_plotframe(fa);
h2 = vl_plotframe(fa);

set(h1,'color','k','linewidth',3) ;
set(h2,'color','y','linewidth',2) ;



figure; imshow(Ib);
Ib = single(rgb2gray(Ib));

[fb, db] = vl_sift(Ib);
h1_b = vl_plotframe(fb);
h2_b = vl_plotframe(fb);

set(h1_b,'color','k','linewidth',3) ;
set(h2_b,'color','y','linewidth',2) ;

%effettuo il matching tra i descrittori (128 dimensioni)
%(viene calcolata la distanza euclidea fra i vettori)

[ra, ca] = size(da);
[rb, cb] = size(db);
%{
if cb > ca
    [matches, score] = vl_ubcmatch(da, db, 1.1);
    sim = length(score)/ca;
else
    [matches, score] = vl_ubcmatch(db, da, 1.1);
    sim = length(score)/cb;
end



[matches, score] = vl_ubcmatch(da, db,  1);

score_s = score./(max(score)*1.5);
quant = round(score_s * 20)/20;
[unique] = unique(quant);
num = 0; 
for index = 1:length(unique)
    num = num + length(find(quant == unique(index)))* unique(index)
end

media_p = num/length(score);


%}

sim = Sift_Matching(da,db);

media_p=w_mean(sim(:))

