clc; clear; close all;

%carico le librerie in memoria
run('vlfeat-0.9.18/toolbox/vl_setup')

num_cluster = 8;
canny=0;

Images = cell(1,16);
for index = 1:16
    Images{1, index} = imread(strcat('test_img/',num2str(index),'.jpg'));
end

colors = ['b.';'m.';'c.';'r.';'g.';'w.';'y.';'k.'];

for j = 1:16
    subplot(4,4,j);
    imshow(Images{1,j});
end

figure;
titolo=strcat('Akula con num_cluster = ',num2str(num_cluster),' canny = ',num2str(canny));
name(titolo);

for i = 1:16
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
for i = 1:16
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
for i = 1:16
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