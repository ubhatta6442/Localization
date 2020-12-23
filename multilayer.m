Features_Data = load('Features_NLOS_28GHz.mat');
Features = Features_Data.Features;

Locate_Data = load('Locate_NLOS_28GHz.mat');
Locate = Locate_Data.Locate;
input = Features;
correct_output = Locate;


%% Define hyperparameters to optimize
vars = [optimizableVariable('hiddenLayerSize1', [4,50], 'Type', 'integer');
    optimizableVariable('hiddenLayerSize2', [4,50], 'Type', 'integer');
    optimizableVariable('lr', [1e-3 1], 'Transform', 'log');
    optimizableVariable('Fcn',{'radbas' 'logsig' 'tansig' 'poslin' 'purelin'},'Type','categorical')];% 'poslin' 'purelin'
%optimizableVariable('performFcn',{'mse' 'crossentropy'},'Type','categorical')];
%%%% Optimize

%% T.hiddenLayerSize2 = 0 , T.hiddenLayerSize2]
minfn = @(T)Loss_calculation(input', correct_output',[ T.hiddenLayerSize1 T.hiddenLayerSize2], T.lr,T.Fcn);
results = bayesopt(minfn, vars,'IsObjectiveDeterministic',false,...
    'AcquisitionFunctionName','expected-improvement-plus')
T = bestPoint(results);

net = feedforwardnet([ T.hiddenLayerSize1 T.hiddenLayerSize2]);
net.trainParam.lr = T.lr;
%for i=1:length([ T.hiddenLayerSize1])
%    net.layers{i}.transferFcn = char(T.Fcn);
%end 
%for i=1:length([ T.hiddenLayerSize2])
%    net.layers{i}.transferFcn = char(T.Fcn);
%end 
net.performFcn = 'mse';

net = train(net,input',correct_output');

%% testing

Features_testData = load('Features_test_28GHz.mat');
Features_test = Features_testData.Features_test;

Locate_testData = load('Locate_test_28GHz.mat');
Locate_test = Locate_testData.Locate_test;
%input = Features;
correct_output = Locate_test;

Test_Data = Features_test;
Net_Out = net(Test_Data');
save('correct_output_28_NLOS.mat','correct_output');
save('Net_Out_28_NLOS.mat','Net_Out');


figure
scatter(Net_Out(1,:),Net_Out(2,:),'b+')
hold on
scatter(correct_output(:,1),correct_output(:,2),'r')
xlabel('x-coordinate(meters)')
ylabel('y-coordinate(meters)')
legend('Predicted Location','True Location')


