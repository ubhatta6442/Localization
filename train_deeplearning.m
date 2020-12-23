input = [45 12 2;
         35 28 5;
         70 49 6;
         67 51 2];
     
correct_output = [36 65;
                  58 12;
                  14 34;
                  87 44];

w1 = 2*rand(6,3) - 1;
w2 = 2*rand(4,6) - 1;
w3 = 2*rand(2,4) - 1;

for epoch = 1:1000
    [w1,w2,w3] = deeplearning(w1 ,w2 ,w3 ,input ,correct_output);
end
save ('deep_neural.mat')