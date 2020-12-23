function [w1, w2, w3] = deeplearning(w1, w2,w3,input,correct_output)
alpha = 0.01;
N=4;
for k = 1:N
    transposed_input = input(k, :)';
    
    
    input_hiddenlayer1 = w1*transposed_input;
    output_hiddenlayer1 = sigmoid(input_hiddenlayer1);
    
    input_hiddenlayer2 = w2*output_hiddenlayer1;
    output_hiddenlayer2 = sigmoid(input_hiddenlayer2);
    
    input_outputnode = w3*output_hiddenlayer2';
    output_outputnode = softmax(input_outputnode);
    
    correct_output_transposed = correct_output(k,:)';
    error = correct_output_transposed - output_outputnode;
    
    delta = error;
    
    error_hiddenlayer2 = w3'*delta;
    delta2 = error_hiddenlayer2 * input_hiddenlayer2;
    
    error_hiddenlayer1 = w2'* delta2;
    delta1 = error_hiddenlayer1 * input_hiddenlayer1;
    
    delta_w1 = alpha*delta1*transposed_input; 
    delta_w2 = alpha*delta2*output_hiddenlayer1;
    delta_w3 = alpha*delta3*output_hiddenlayer2;
    
    w1 = w1+delta_w1;
    w2 = w2+delta_w2;
    w3 = w3+delta_w3;
    
end
end