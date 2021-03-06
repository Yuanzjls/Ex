clear
%generate a random dataset with 2 feature sets
%D = [randn(2000,2)*0.75+ones(2000,2);randn(2000,2)*0.55-ones(2000,2)];
D = xlsread('Iris.xlsx');;

%Load the iris dataset (this part must be used instead of the above line
%for loading the data in experiments
%D = csvread('iris.csv');
figure;
%plot the generated dataset
plot(D(:,1),D(:,2),'.');
%normalzie the dataset
D_Norm = (D-min (D(:))) ./ (max(D(:))) ;
%show the number of iterations on the command window
I = statset ('Display','iter');
D_Norm = D_Norm(:,1:2);
%cluster the data using the kmedoids command
[idx,C,sumd,d,midx,info] = kmedoids(D_Norm,4,'Distance','cityblock','Options',I);
%save all the achieved results as txt files
save kmedoids_idx.txt idx -ascii -double
save kmedoids_C.txt C -ascii -double
save kmedoids_sumd.txt sumd -ascii -double
save kmedoids_d.txt d -ascii -double
%plot the clusters and their centroids
plot(D_Norm(idx==1,1),D_Norm(idx==1,2),'r.','MarkerSize',7)
hold on
plot(D_Norm(idx==2,1),D_Norm(idx==2,2),'b.','MarkerSize',7)
plot(C(:,1),C(:,2),'co','MarkerSize',7,'LineWidth',1.5)
legend('Cluster 1','Cluster 2','Medoids','Location','NW');
title('Cluster Assignments and Medoids');
hold off
%evaluate the clustering approach
e = silhouette(D,idx);