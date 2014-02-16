clc; clear; close all;

%carico le librerie in memoria
run('vlfeat-0.9.18/toolbox/vl_setup')

%%%Variabili del programma settabile dall'utente
%%num_cluster = numero di cluster da ricercare nelle immagini
num_cluster = 8;
%%canny = se vale 0 verrá lanciato lo script con l'algoritmo base fornito
%%da Akula, se vale 1 verrá lanciato con l'algoritmo di Canny base, se vale
%%2 verrá lanciato con Canny + dilatazione dei bordi 
canny=1;
%%sel_img = identificativo dell'immagine da prendere come query per il
%%programma
sel_img=16;
%%num_images = numero totale delle immagini presente nella cartella
%%test_img
num_images=32;
%%%

%%caricamento delle immagini nel workspace
Images = cell(1,num_images);
for index = 1:num_images
    Images{1, index} = imread(strcat('test_img/',num2str(index),'.bmp'));
end

colors = ['b.';'m.';'c.';'r.';'g.';'w.';'y.';'k.'];

figure;