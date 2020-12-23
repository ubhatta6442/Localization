load ('Trained_network.mat');
input = [0 0 1; 0 1 1;1 0 1;1 1 1];
N=4;
for i = 1:N
    transposed_input = input(i, :)';
    weighted_sum = weight*transposed_input;
    output = sigmoid(weighted_sum)
end