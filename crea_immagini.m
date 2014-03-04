I=imread('test_img/1.bmp');
run('vlfeat-0.9.18/toolbox/vl_setup')
colors = ['b.';'m.';'c.';'r.';'g.';'w.';'y.';'k.'];
num_cluster=8


[centers, assignments, fi, di] = SIFT_AKULA(I,2,num_cluster);
[centers_ord,ind] = sort(centers(1,:));
imshow(I)
hold on;
[A, dA] = create_descriptor(centers(:,ind), assignments, di);
for index = 1:size(centers,2)
    plot(centers(1,index), centers(2,index), colors(index,:),'MarkerSize',50);
    ind = find(assignments == index);
    plot(fi(1,ind), fi(2,ind), colors(index,:),'MarkerSize',25);
end
