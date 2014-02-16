clc; clear; close all;

%carico le librerie in memoria
run('vlfeat-0.9.18/toolbox/vl_setup')

%%%Variabili del programma settabile dall'utente
%%%

    %%mode = 
    %% 0 se si vuol lanciare Akula in modo semplice
    %% 1 se si vuol lanciare Akula con la funzione di somiglianza che tenga 
    %%conto anche dei descrittori dei cluster
    mode = 0;

    %%canny = se vale 0 verr� lanciato lo script con l'algoritmo base fornito
    %%da Akula, se vale 1 verr� lanciato con l'algoritmo di Canny base, se vale
    %%2 verr� lanciato con Canny + dilatazione dei bordi 
    canny=1;

    %%num_cluster = numero di cluster da ricercare nelle immagini
    num_cluster = 8;

    %%sel_img = identificativo dell'immagine da prendere come query per il
    %%programma
    sel_img=16;

    %%num_images = numero totale delle immagini presente nella cartella
    %%test_img
    num_images=32;

%%% Fine variabili
%%%

%%caricamento delle immagini nel workspace
Images = cell(1,num_images);
for index = 1:num_images
    Images{1, index} = imread(strcat('test_img/',num2str(index),'.bmp'));
end

colors = ['b.';'m.';'c.';'r.';'g.';'w.';'y.';'k.'];

figure;

if mode
    [centers1, assignments] = SIFT_AKULA(Images{1,sel_img},canny,num_cluster);
else
    [centers1, assignments, fi, di] = SIFT_AKULA(Images{1,sel_img},canny,num_cluster);
end;
[centers_ord,ind1] = sort(centers1(1,:));
if mode
[A1] = create_descriptor(centers1(:,ind1), assignments);
else
[A1, dA1] = create_descriptor(centers1(:,ind1), assignments);
end;

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