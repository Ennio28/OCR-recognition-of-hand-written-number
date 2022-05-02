function [net, net2, filter] = initTrainNetwork
    % Load needed inputs
    load('Pin.mat')
    load('T.mat')
    load('Perfect2.mat')
    
    % Create a double layer network with 120 neurons in the hidden layer
    net = feedforwardnet(120);
    
    % Choose the training algorithm
    net.trainFcn = 'trainscg'; %traingcp | traingdx | 

    % Adjust the network parameters
    % The default learning rate worked fine for our purpose
    net.trainParam.epochs = 4000;
    net.trainParam.goal = 0;
    net.trainParam.min_grad = 1e-100;
    net.trainParam.max_fail = 500000;
    net.divideFcn = 'dividerand';
    net.performFcn = 'mse';
    net.adaptFcn = 'learngd';

    % Train division
    net.divideParam.trainRatio = 0.85;
    net.divideParam.valRatio = 0.15;
    net.divideParam.testRatio = 0.0;

    % Choose network activation function for both layers
    net.layers{1}.transferFcn = 'logsig';
    net.layers{2}.transferFcn = 'purelin';

    % Create a single layer network
    net2 = network;
    
    % Adjust the network parameters
    net2.numInputs = 1;
    net2.numLayers = 1;
    net2.trainFcn = 'trainscg'; %'trainc'; %'trainscg';
    net2.adaptFcn = 'learngd'; %learnp'; %'learngd';
    net2.outputConnect = [1];
    net2.inputConnect = [1];
    net2.biasConnect = [1];
    net2.inputs{1}.size = 256;
    net2.layers{1}.transferFcn = 'logsig'; %'hardlim'; %'tansig';

    % Create a network to work as hardlim filter
    filter = network;
    filter.numInputs = 1;
    filter.numLayers = 1;
    filter.layers{1}.size = 256;
    filter.layers{1}.transferFcn = 'hardlim';
    filter.trainFcn = 'trainc';
    filter.adaptFcn = 'learnp';
    filter.outputConnect = [1];
    filter.inputConnect = [1];
    filter.inputs{1}.size = 256;
    filter.inputWeights{1,1}.learnFcn = 'learnp';
    
    % Train networks
    net = train(net, Pin, T);
    net2 = train(net2, Pin, T);
    filter = train(filter, Pin, Perfect2);
    
    % Save the trained networks
    save('net.mat', 'net');
    save('net2.mat', 'net2');
    save('filter.mat', 'filter');
end