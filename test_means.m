clc; clear; close all;

I = imread('test_img/1.jpg');
I_bn = single(rgb2gray(I));
%I_bn = single(edge(I_bn, 'canny'));
[fa,da] = vl_sift(I_bn);

fa(5,:) = max(abs(da));
[B, IX] = sort(fa(5,:), 'descend');

Kp_sel = fa(:,IX(1:300));

imshow(I);
h1 = vl_plotframe(Kp_sel(1:4,:));
h2 = vl_plotframe(Kp_sel(1:4,:));

set(h1,'color','k','linewidth',3);
set(h2,'color','y','linewidth',2);
figure;

imshow(I);
hold on;
cord = Kp_sel(1:2,:);

[centers, assignments] = vl_kmeans(cord, 8);
colors = ['b.';'m.';'c.';'r.';'g.';'w.';'y.';'k.'];

for index = 1:size(centers,2)
    colors(index,:)
    plot(centers(1,index), centers(2,index), colors(index,:),'MarkerSize',50);
    ind = find(assignments == index);
    plot(Kp_sel(1,ind), Kp_sel(2,ind), colors(index,:),'MarkerSize',25);
    
    %{
    for p = 1:length(ind)
        plot(Kp_sel(1,ind(p)), Kp_sel(2,ind(p)), colors(index),'MarkerSize',50);
       
    end
    %}
end    



