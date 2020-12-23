clear all;
close all;
clc

%% training data
DOA1 = dlmread('Udita_LTE_Project.doa.t001_01.r006.p2m');
TOA1 = dlmread('Udita_LTE_Project.toa.t001_01.r006.p2m');
Location1 = dlmread('Udita_LTE_Project.pg.t001_01.r006.p2m');
% DOA2 = dlmread('Udita_LTE_Project.doa.t001_01.r007.p2m');
% TOA2 = dlmread('Udita_LTE_Project.toa.t001_01.r007.p2m');
% Location2 = dlmread('Udita_LTE_Project.pg.t001_01.r007.p2m');
DOA = [DOA1];
TOA = [TOA1];
Location = [Location1];


D1_Points_Acc = 1;
No_of_Points = 1430;%[DOA1(1,1) DOA2(1,1)];
%No_of_points2 = DOA2(1,1)_;
%No_of_points3 = DOA3(1,1);
for i=1:No_of_Points
   D1_Points = DOA(D1_Points_Acc ,2);  
   D1_Points_Acc = D1_Points_Acc + D1_Points + 1;
   No_of_Paths = D1_Points;
    for j=1:No_of_Paths
        
        Delay1(i,j) = TOA(D1_Points_Acc - D1_Points + j - 1,2); 
        DoA1_Az(i,j) = DOA(D1_Points_Acc - D1_Points + j - 1,3); 
        %DoA1_El(i,j) = DOA1(D1_Points_Acc - D1_Points + j - 1,2); 
        RSS(i,j) = DOA(D1_Points_Acc - D1_Points + j - 1,4); 
        
    end
    Location_x(i,1) = Location(i,2);
    Location_y(i,1) = Location(i,3);
end

No_MPCs = 3;
Ref = min(Delay1(:,1:No_MPCs));
%Features = [Delay1(:,1:No_MPCs)./min(Delay1(:)),abs(RSS(:,1:No_MPCs))./max(abs(RSS(:))),DoA1_Az(:,1:No_MPCs)];
Features = [(Delay1(:,1:No_MPCs)) - Ref];%,Delay1(:,1:No_MPCs),abs(RSS(:,1:No_MPCs))./max(abs(RSS(:)))];  
Locate = [Location_x, Location_y];

save('Features_NLOS_28GHZ.mat','Features') 

save('Locate_NLOS_28GHz.mat','Locate')

%% testing data
DOA1 = dlmread('Udita_LTE_Project.doa.t001_01.r007.p2m');
TOA1 = dlmread('Udita_LTE_Project.toa.t001_01.r007.p2m');
Location1 = dlmread('Udita_LTE_Project.pg.t001_01.r007.p2m');
DOA = [DOA1];
TOA = [TOA1];
Location = [Location1];


D1_Points_Acc = 1;
No_of_Points = 990;%[DOA1(1,1) DOA2(1,1)];
%No_of_points2 = DOA2(1,1)_;
%No_of_points3 = DOA3(1,1);
for i=1:No_of_Points
   D1_Points = DOA(D1_Points_Acc ,2);  
   D1_Points_Acc = D1_Points_Acc + D1_Points + 1;
   No_of_Paths = D1_Points;
    for j=1:No_of_Paths
        
        Delay1(i,j) = TOA(D1_Points_Acc - D1_Points + j - 1,2); 
        DoA1_Az(i,j) = DOA(D1_Points_Acc - D1_Points + j - 1,3); 
        %DoA1_El(i,j) = DOA1(D1_Points_Acc - D1_Points + j - 1,2); 
        RSS(i,j) = DOA(D1_Points_Acc - D1_Points + j - 1,4); 
        
    end
     Location_x(i,1) = Location(i,2);
     Location_y(i,1) = Location(i,3);
end

No_MPCs = 3;
Ref = min(Delay1(:,1:No_MPCs));
%Features = [Delay1(:,1:No_MPCs)./min(Delay1(:)),abs(RSS(:,1:No_MPCs))./max(abs(RSS(:))),DoA1_Az(:,1:No_MPCs)];
Features_test = [(Delay1(:,1:No_MPCs)) - Ref];%,Delay1(:,1:No_MPCs),abs(RSS(:,1:No_MPCs))./max(abs(RSS(:)))];  
Locate_test = [Location_x, Location_y];

save('Features_test_28GHZ.mat','Features') 

save('Locate_test_28GHz.mat','Locate')