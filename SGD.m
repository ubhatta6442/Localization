function weight = SGD(weight, input, correct_output)
alpha = 0.9;
N = 4;
for i = 1:N
    transposed_input = input(i, :)';
    d = correct_output(i);
    weighted_sum = weight*transposed_input;
    output = sigmoid(weighted_sum);
    
    error = d - output;
    delta = output*(1-output)*error;
    dweight = alpha*delta*transposed_input;
    
    weight(1) = weight(1)+dweight(1);
    weight(2) = weight(2)+dweight(2);
    weight(3) = weight(3)+dweight(3);
    
end
end