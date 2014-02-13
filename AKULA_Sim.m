function [sim] = AKULA_Sim( A1,A2, dA1, dA2 )
%AKULA_SIM
%   Calcola la similarita' tra due descrittori AKULA, se sono passati in 
%   ingresso anche i descrittori aggiuntivi medi, viene calcolata la
%   similarita' pesata;
%{
    INPUT:
    A1 = Primo descrittore AKULA;
    A2 = Secondo descrittore AKULA;
    dA1 = Descrittore medio e pesato dei cluster di A1;
    dA2 = Descrittore medio e pesato dei cluster di A2;

    OUTPUT:
    sim = valore [0;1] di somiglianza;
%}

complete = 0;
p=1;
if nargin == 4
    complete = 1;
    p=0.5;
end

num_cluster = size(A1,2);
distA1=0;
for index = 1:num_cluster
    %calcolo le distanze sulle diverse coordinate
    dif_x = (A1(1,index) - A2(1,:)).^2;
    dif_y = (A1(2,index) - A2(2,:)).^2;
    dist = sqrt( dif_x + dif_y );
    [dist_ord, ind] = sort(dist);
    w=A1(3,index)+A2(3,ind(1));
    
    distA1=distA1+dist_ord(1)*w;
end
distA2=0
d_w=zeros(num_cluster);
        
for index = 1:num_cluster
    %calcolo le distanze sulle diverse coordinate
    dif_x = (A2(1,index) - A1(1,:)).^2;
    dif_y = (A2(2,index) - A1(2,:)).^2;
    dist = sqrt( dif_x + dif_y );
    [dist_ord, ind] = sort(dist);
    w=A2(3,index)+A1(3,ind(1));
    
    distA2=distA2+dist_ord(1)*w;

    if complete
        for j=1:num_cluster
            d_w(index,j)=norm(dA1(:,index)-dA2(:,j));
        end
    end
end

d1 = (distA1+distA2) / num_cluster;
d2=0;
if complete
    d2=1-sum(sum(d_w)) / (num_cluster^2*2885);
end
sim = p*d1 + (1-p)*d2;
end

