function [sim] = SIFT_Similarity( Im1, Images )
%SIFT_SIMILARITY Summary of this function goes here
%   Detailed explanation goes here

%{ 
   (255^2) * 128 / 1.5
    255^2 --> Quadrato della distanza euclidea
              con 255 il massimo valore della distanza tra due descrittori
    128   --> Feature del vettore di descrittori
    1.5   --> Soglia massima per la funzione distanza di ubcmatch di SIFT
%}
soglia_max = 5548800;

%paramentro per la pesatura delle similarita'
p = 0;



%estraggo descrittori dall'immagine in input
Im_1 = single(rgb2gray(Im1));
Im_1 = edge(Im_1, 'canny'); 
imshow(Im_1);

[f1,d1] = vl_sift(single(Im_1));
h1 = vl_plotframe(f1);
h2 = vl_plotframe(f1);
set(h1,'color','k','linewidth',3);
set(h2,'color','y','linewidth',2);
figure;



[f1_r, f1_c] = size(f1);

%csotruisco la struttura per memorizzare le similarita'
[r,c] = size(Images);
sim = zeros(1,c);
%ciclo sull'insieme di immagini calcolando
%   -  Descrittore di sift temporaneo
%   -  Similarita' con immagine data 
for index = 1 : c
    Im_t = single(rgb2gray(Images{1,index}));
    Im_t = edge(Im_t, 'canny');
    imshow(Im_t);
    [ft, dt] = vl_sift(single(Im_t));
    h1 = vl_plotframe(ft);
    h2 = vl_plotframe(ft);
    set(h1,'color','k','linewidth',3);
    set(h2,'color','y','linewidth',2);
    figure;
    
    [matches, score] = vl_ubcmatch(d1, dt);
    
    %match parziale
    [ft_r, ft_c] = size(ft);
    m_p = length(matches)/max([ft_c, f1_c]);
    
    %media score
    m_s = 1 - (min(score)/soglia_max);
    
    %calcolo della funzione similarita'
    sim(index) = (p*m_p) + (1-p)*m_s;
    %sim(index) = m_p*m_s;
    
end

%{
    TO-DO:
        -  Similarita' rispetto alle texture;
        -  Compressione del descrittore;
%}

end

