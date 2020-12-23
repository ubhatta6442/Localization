function Err = Loss_calculation(a, b, numHid, lr, Fcn)

net1 = feedforwardnet(numHid);
net1.trainParam.lr = lr;
net1.performFcn = 'mse';
for i=1:length(numHid)
     net1.layers{i}.transferFcn = char(Fcn);
end

net1.performParam.normalization = 'standard';
%net1.trainParam.epochs=250;


netOut = train(net1, a, b);

% Evaluate on validation set and compute rmse
ypred = netOut(a);
ytarget = b;
Err = norm(ypred - ytarget,2);%sum(ytarget== ypred) / length(ytarget);
