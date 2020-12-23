input = [0 1 2 3 4 5 6 7 8];correct_output = [0 0.84 0.91 0.14 -0.77 -0.96 -0.28 0.66 0.99]

Train_Targets = correct_output;%dummyvar(Train_Labels);
%            Test_Targets = dummyvar(Test_Labels);
           
            %%% Define a train/validation split to use inside the objective function
            %cv = cvpartition(size(Train_Targets,1), 'Holdout', 15/100);
           
            %% Define hyperparameters to optimize
            %vars = [optimizableVariable('hiddenLayerSize1', [4,50], 'Type', 'integer');
%                 %optimizableVariable('hiddenLayerSize2', [4,50], 'Type', 'integer');
%                 optimizableVariable('lr', [1e-3 1], 'Transform', 'log');
%                 optimizableVariable('Fcn',{'radbas' 'logsig' 'tansig'},'Type','categorical')];% 'poslin' 'purelin'
%             %optimizableVariable('performFcn',{'mse' 'crossentropy'},'Type','categorical')];
%             %%%% Optimize
%            
%             %% T.hiddenLayerSize2 = 0 , T.hiddenLayerSize2]
%             minfn = @(T)kfoldLoss_NN(Train_Data, Train_Targets', cv,[ T.hiddenLayerSize1], T.lr,T.Fcn,length(UAVArray));
%             results = bayesopt(minfn, vars,'IsObjectiveDeterministic',false,...
%                 'AcquisitionFunctionName','expected-improvement-plus')
%             T = bestPoint(results);
%            
            %T.hiddenLayerSize2
            vars = [optimizableVariable('hiddenLayerSize1', [4,50], 'Type', 'integer')]
            net = patternnet([ 10 10 ]);
            %net.trainParam.lr = T.lr;
            %net1.layers.transferFcn = char(T.Fcn);
            %net.numLayers = T.numLayers;
%             for i=1:length([ T.hiddenLayerSize1])
%                 net.layers{i}.transferFcn = char(T.Fcn);
% %             end            %net.performParam.regularization = 0.1;
%             net.performParam.normalization = 'standard';
%             net.performFcn = 'crossentropy';%char(T.performFcn);
            tic;[net,~] = train(net,input,correct_output);timeElapsed = toc;
           
           Test_Data = [2];
            Net_Out = net(Test_Data)            % predicts probability for each label