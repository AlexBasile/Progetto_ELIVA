function [ A, dA ] = create_descriptor(center, assignments, di, fi)
%CREATE_DESCRIPTOR 
%   Crea il descrittore compatto per l'algortimo AKULA.
%
%   Se vengono passati tutti i descrittori dei keypoint allora si calcola
%   la varsione completa che in aggiunta al descrittore calcola anche il
%   media dei descrittori dei Keypoint SIFT appartenenti al cluster,
%   assegnandola al centroide corrispondente;
%{
   INPUT:
   center = coordinate dei centroidi;
   assignments = vettori di corrispondenze tra i keypoint ed i cluster
                 rispettivamente assegnati;
   fi = coordinate di tutti i keypoints consdierati;
   di = descrittori dei keypoints considerati;

   OUTPUT:
   A = Descrittore compatto di AKULA;
    -  A(1,:) = X dei centroidi
    -  A(2,:) = Y dei centroidi
    -  A(3,:) = Numero di keypoint appartenenti al cluster il cui
                centroide e' in (X,Y)
   dA = matrice dei descrittori riassuntivi dei centroidi
    -  dA(:,1:128) = media dei descrittori dei punti appartenti al cluster
                il cui centroide e' in (X,Y) 
%}
complete = 0;
pesato = 0;
if nargin == 3
    complete = 1;
    di_b = double(di);
elseif nargin == 4
    pesato = 1;
    di_b = double(di);
end


dA = zeros(128,size(center,2));
A = zeros(3,size(center,2));
%ciclo su tutti i centroidi trovati
for index = 1:size(center,2)
    A(1,index) = center(1,index);   %imposto la X
    A(2,index) = center(2,index);   %imposto la Y
    
    %trovo gli eoggetti che fanno parte del cluster 
    elems = find(assignments == index);
    A(3,index) = length(elems);     %imposto gli elementi del cluster
    
    %se sono stati passati i descrittori allora calcolo il A completo
    if complete
        dA(:,index) = sum(di_b(:,elems),2) / length(elems);
    elseif pesato
        weights = zeros (size(elems));
        for j = 1 :length(elems)
            dist = sqrt((fi(1,elems(j))-center(1,:)).^2+(fi(2,elems(j))-center(2,:)).^2);
            dist_ord = sort(dist);
            %considero soltanto le prime 40% distanze dagli altri cluster
            k = dist_ord(1)/sum( dist_ord( 2 : uint8( 4/10 * length(center) ) ));
            weights(j) = 1-k;
        end
        dA(:,index) = sum(di_b(:,elems).*(ones(128,1)*weights),2)/sum(weights);
    end 
end

if nargout > 1
    dA = uint8(round(dA));
end
    
end

