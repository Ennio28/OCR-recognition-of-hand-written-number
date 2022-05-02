function result = myclassifier(data, filled_inx)
    % Check if network files already exists and act accordingly
    if isfile('net.mat') && isfile('net2.mat') && isfile ('filter.mat')
        
        % Networs already exists, so import them
        load('net.mat');
        load('net2.mat');
        load('filter.mat');
    else
        
        % Network files do not exist, so create and train networks
        [net, net2, filter] = initTrainNetwork;
    end

    load('selection.mat'); 
    % Performs the classification
    if (selection == 'DoubleLayer')
        result = sim(net, data);
    else
        result = sim(net2, data);
    end
    
    % Prepare data to fit the ocr_fun display format
    nCases = length(filled_inx);
    net_result = result;
    result = ones(1,nCases) * -1;
    
    for n_case = 1 : nCases
        case_result = find(net_result(:,filled_inx(n_case)) == max(net_result(:,filled_inx(n_case))));
        if length(case_result) == 1
           result(n_case) = case_result;
        end
    end
end