function [centers, assignments, fi, di] = SIFT_AKULA( image, type, num_cluster)
%SIFT_AKULA 
%   Image  = immagine di input
%   type = 0/1/2
%          0 = calcolo i keypoint standard di SIFT
%          1 = applico il filtro di canny
%          2 = applico il filtro di canny e filtro morfologico di
%          dilatazione

if nargin < 2
    type = 0;
    num_cluster = 8;
elseif nargin < 3
    num_cluster = 8;
end


I_bn = single(rgb2gray(image));
if type==1
    I_bn = single(edge(I_bn, 'canny'));
elseif type ==2
    I_bn=single(I_bn.*imdilate(edge(I_bn, 'canny'),ones(3,3)));
end

%calcolo SIFT
[fa,da] = vl_sift(I_bn);

%calcolo le norm infinito dei vettori dei descrittori
%aggiungo il vettore riga alla matrice fa ed ordino
%condiero solo le prime 300 colonne della matrice ordinata
fa(5,:) = max(abs(da));
[B, IX] = sort(fa(5,:), 'descend');

if length(IX) < 300
    Kp_sel = fa(:, IX(1:end));
else
    Kp_sel = fa(:,IX(1:300));
end

%considero le coordinate dei keypoint
cord = Kp_sel(1:2,:);

%calcolo i centroidi dei K cluster
[centers, assignments] = vl_kmeans(cord, num_cluster);

if nargout > 2
    fi = Kp_sel;
    di = da(:,IX(1:end));
end

end

