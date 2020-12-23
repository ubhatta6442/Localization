function weight = batch(weight, input, correct_output)
alpha = 0.9;
dweight_sum = 0;
N = 4;
n = 3;
for  i= 1:N
    transposed_input = input(i, :)';
    d = correct_output(i);
    weighted_sum = weight*transposed_input;

end
    output = sigmoid(weighted_sum);
    
    error = d - output;
    delta = output*(1-output)*error;
for j=1:n
    dweight(i,j) = alpha*delta*transposed_input(j);
end    
end
    dweight_sum = sum(dweight);
    avg_dweight = dweight_sum/N;
    weight(1) = weight(1)+avg_dweight(1);
    weight(2) = weight(2)+avg_dweight(2);
    weight(3) = weight(3)+avg_dweight(3);
    
