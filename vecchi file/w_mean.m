function [ media ] = w_mean( valori )
%W_MEAN Summary of this function goes here
%   Detailed explanation goes here
quant = round(valori .* 200)./200;
[singolo] = unique(quant);
num = size(singolo);
parfor index=1:length(singolo)
    num(index)=length(find(quant==singolo(index)))*singolo(index);
end
media=sum(num)/length(valori);



end

