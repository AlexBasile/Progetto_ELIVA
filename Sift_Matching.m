function [ sim ] = Sift_Matching( desc_1, desc_2 )
%SIFT_MATCHING Summary of this function goes here
%   Detailed explanation goes here
desc_1 = double(desc_1);
desc_2 = double(desc_2);
[ra,ca] = size(desc_1);
[rb,cb] = size(desc_2);

distanze = zeros(ca,cb);
for i = 1:ca
    col=desc_1(:,i);
    parfor j = 1:cb
        distanze(i,j)=norm(col-desc_2(:,j));
    end
end

soglia = 2.8850e+03;
sim = 1 - (distanze/soglia);



max(max(sim))
min(min(sim))
mean(mean(sim))
end

function [media] = w_mean(pesi, valori)

end
