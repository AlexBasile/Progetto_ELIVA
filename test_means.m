clc; clear; close all;

%carico le librerie in memoria
run('vlfeat-0.9.18/toolbox/vl_setup')

num_cluster = 8;
canny=1;
sel_img=16;
num_images=32;


Images = cell(1,num_images);
for index = 1:num_images
    Images{1, index} = imread(strcat('test_img/',num2str(index),'.jpg'));
end

colors = ['b.';'m.';'c.';'r.';'g.';'w.';'y.';'k.'];

figure;
for j = 1:num_images
    subplot(4,4,j);
    imshow(Images{1,j});
end

figure;
%titolo=strcat('Akula con num_cluster = ',num2str(num_cluster),' canny = ',num2str(canny));
%name(titolo);

'similarity tra akula senza descrittori dei cluster'
[centers1, assignments] = SIFT_AKULA(Images{1,sel_img},canny,num_cluster);
[centers_ord,ind1] = sort(centers1(1,:));
[A1] = create_descriptor(centers1(:,ind1), assignments);

for i=1:num_images
    [centers2, assignments] = SIFT_AKULA(Images{1,i},canny,num_cluster);
    [centers_ord,ind2] = sort(centers2(1,:));
    [A2] = create_descriptor(centers2(:,ind2), assignments);
    [sim(i) d(i)] = AKULA_Sim( A1,A2 );
    
end

sim=1-sim / max(sim);

l=sim;
[l,i]=sort(l,'descend')


'similarity tra akula con descrittori dei cluster'

[centers1, assignments, fi, di] = SIFT_AKULA(Images{1,sel_img},canny,num_cluster);
[centers_ord,ind1] = sort(centers1(1,:));
[A1, dA1] = create_descriptor(centers1(:,ind1), assignments);

for i=1:num_images
    subplot(4,2,mod(i,8)+1);
    imshow(Images{1,i});
    
    [centers2, assignments, fi, di] = SIFT_AKULA(Images{1,i},canny,num_cluster);
    [centers_ord,ind2] = sort(centers2(1,:));
    [A2, dA2] = create_descriptor(centers2(:,ind2), assignments,di,fi);
    [sim(i) d(i)] = AKULA_Sim( A1,A2,dA1,dA2 );
    
    hold on
    for index = 1:size(centers2,2)
        plot(centers2(1,index), centers2(2,index), colors(index,:),'MarkerSize',50);
        ind = find(assignments == index);
        plot(fi(1,ind), fi(2,ind), colors(index,:),'MarkerSize',25);
    end
    if i==8
        figure;
    end
end

sim=1-sim / max(sim);
d=1-d / max(d);

l=sim*0.5+0.5*d;
[l,i]=sort(l,'descend')

canny=2;
figure;
'similarity tra akula con descrittori dei cluster e dilatazione di canny'

[centers1, assignments, fi, di] = SIFT_AKULA(Images{1,sel_img},canny,num_cluster);
[centers_ord,ind1] = sort(centers1(1,:));
[A1, dA1] = create_descriptor(centers1(:,ind1), assignments);

for i=1:num_images
    subplot(4,2,mod(i,8)+1);
    imshow(Images{1,i});
    
    [centers2, assignments, fi, di] = SIFT_AKULA(Images{1,i},canny,num_cluster);
    [centers_ord,ind2] = sort(centers2(1,:));
    [A2, dA2] = create_descriptor(centers2(:,ind2), assignments,di,fi);
    [sim(i) d(i)] = AKULA_Sim( A1,A2,dA1,dA2 );
    
    hold on
    for index = 1:size(centers2,2)
        plot(centers2(1,index), centers2(2,index), colors(index,:),'MarkerSize',50);
        ind = find(assignments == index);
        plot(fi(1,ind), fi(2,ind), colors(index,:),'MarkerSize',25);
    end
    if i==8
        figure;
    end
end

sim=1-sim / max(sim);
d=1-d / max(d);

l=sim*0.5+0.5*d;
[l,i]=sort(l,'descend')
%{

for i = 1:num_images
    subplot(2,4,mod(i,8)+1);

    imshow(Images{1,i});
    [centers, assignments, fi, di] = SIFT_AKULA(Images{1,i},canny,num_cluster);
    [A, dA] = create_descriptor(centers, assignments);
    
    hold on
    for index = 1:size(centers,2)
        plot(centers(1,index), centers(2,index), colors(index,:),'MarkerSize',50);
        ind = find(assignments == index);
        plot(fi(1,ind), fi(2,ind), colors(index,:),'MarkerSize',25);
    end
    if i==8
        figure;
        title(titolo)
    end
end





figure;
for i = 1:num_images
    subplot(2,4,mod(i,8)+1);
    imshow(Images{1,i});
    [centers, assignments, fi, di] = SIFT_AKULA(Images{1,i},canny,num_cluster);
    [A, dA] = create_descriptor(centers, assignments,di);
    
    hold on
    for index = 1:size(centers,2)
        plot(centers(1,index), centers(2,index), colors(index,:),'MarkerSize',50);
        ind = find(assignments == index);
        plot(fi(1,ind), fi(2,ind), colors(index,:),'MarkerSize',25);
    end
    if i==8
        figure;
    end
end

figure;
for i = 1:num_images
    subplot(2,4,mod(i,8)+1);
    imshow(Images{1,i});
    [centers, assignments, fi, di] = SIFT_AKULA(Images{1,i},canny,num_cluster);
    [A, dA] = create_descriptor(centers, assignments,di,fi);
    
    hold on
    for index = 1:size(centers,2)
        plot(centers(1,index), centers(2,index), colors(index,:),'MarkerSize',50);
        ind = find(assignments == index);
        plot(fi(1,ind), fi(2,ind), colors(index,:),'MarkerSize',25);
    end
    if i==8
        figure;
    end
end
%}