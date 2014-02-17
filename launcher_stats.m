clc; clear; close all;

%carico le librerie in memoria
run('vlfeat-0.9.18/toolbox/vl_setup')

%%%Variabili del programma settabile dall'utente
%%%

    %%mode = 
    %% 0 se si vuol lanciare Akula in modo semplice
    %% 1 se si vuol lanciare Akula con la funzione di somiglianza che tenga 
    %%conto anche dei descrittori dei cluster calcolati come una media
    %% 2 se si vuol lanciare Akula con la funzione di somiglianza che tenga 
    %%conto anche dei descrittori dei cluster calcolati attraverso la
    %%pesatura deikeypoint facenti parte il cluster facendo attenzione a
    %%diminuire i keypoint contesi tra i cluster
    mode = 2;

    %%canny = 
    %% 0 verrá lanciato lo script con l'algoritmo base fornito da Akula
    %% 1 verrá lanciato con l'algoritmo di Canny base
    %% 2 verrá lanciato con Canny + dilatazione dei bordi 
    canny = 2;

    %%num_cluster = numero di cluster da ricercare nelle immagini
    num_cluster = 8;

    %%sel_img = identificativo dell'immagine da prendere come query per il
    %%programma
    sel_img=16;

    %%num_images = numero totale delle immagini presente nella cartella
    %%test_img
    num_images = 32;

%%% Fine variabili
%%%

%%caricamento delle immagini nel workspace
Images = cell(1,num_images);
for index = 1:num_images
    Images{1, index} = imread(strcat('test_img/',num2str(index),'.bmp'));
end

colors = ['b.';'m.';'c.';'r.';'g.';'w.';'y.';'k.'];

figure;

if mode==0
    [centers1, assignments1] = SIFT_AKULA(Images{1,sel_img},canny,num_cluster);
else
    [centers1, assignments1, fi1, di1] = SIFT_AKULA(Images{1,sel_img},canny,num_cluster);
end;
[centers_ord,ind1] = sort(centers1(1,:));

if mode == 0
    [A1] = create_descriptor(centers1(:,ind1), assignments1);
elseif mode == 1
    [A1, dA1] = create_descriptor(centers1(:,ind1), assignments1, di1);
else
    [A1, dA1] = create_descriptor(centers1(:,ind1), assignments1, di1,fi1);
end;

sim=zeros(1,num_images);
d=zeros(1,num_images);

for i=1:num_images
    subplot(4,2,mod(i,8)+1);
    imshow(Images{1,i});
    
    if mode==0
        [centers2, assignments2] = SIFT_AKULA(Images{1,sel_img},canny,num_cluster);
    else
        [centers2, assignments2, fi2, di2] = SIFT_AKULA(Images{1,sel_img},canny,num_cluster);
    end;
    [centers_ord,ind2] = sort(centers2(1,:));

    if mode == 0
        [A2] = create_descriptor(centers2(:,ind2), assignments2);
    elseif mode == 1
        [A2, dA2] = create_descriptor(centers2(:,ind2), assignments2, di2);
    else
        [A2, dA2] = create_descriptor(centers2(:,ind2), assignments2, di2,fi2);
    end;
    if mode==0
        [sim(i)] = AKULA_Sim( A1,A2 );
    else
        [sim(i), d(i)] = AKULA_Sim( A1,A2,dA1,dA2 );
    end
    
    hold on
    for index = 1:size(centers2,2)
        plot(centers2(1,index), centers2(2,index), colors(index,:),'MarkerSize',50);
        if mode ~= 0
            ind = find(assignments2 == index);
            plot(fi2(1,ind), fi2(2,ind), colors(index,:),'MarkerSize',25);
        end
    end
    if mod(i,8)==0 && i~=num_images
        figure;
    end
end

sim=1-sim / max(sim);
d=1-d / max(d);

if mode == 0
    l=sim;
else
    l=sim*0.5+0.5*d;
end
[l,i]=sort(l,'descend')