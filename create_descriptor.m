function [ A, dA ] = create_descriptor(center, assignments, di)
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
if nargin > 2
    complete = 1;
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
        for j = 1:length(elems)
            %sommo tutti vettori colonna dei descrittori
            dA(:,index) = dA(:,index) + di_b(:,elems(j));
        end
        %faccio la media dividendo per il numero di elementi nel cluster
        dA(:,index) = dA(:,index)/length(elems); 
    end
end

if nargout > 1
    dA = uint8(round(dA));
end
    
end

