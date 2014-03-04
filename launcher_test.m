clc; clear; close all;

%carico le librerie in memoria
run('vlfeat-0.9.18/toolbox/vl_setup')

sel_img=[1,14];
num_iter=10;
canny=[0,1,2,0,1,2];
mode=[0,0,0,2,2,2];

for j=1:length(sel_img);
    parfor i=1:length(mode)
        launcher_stats(sel_img(j),num_iter,canny(i),mode(i));
    end
end