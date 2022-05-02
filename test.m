%[net, net2, filter] = initTrainNetwork;

%result = sim(net2, sim(filter, P));
result = sim(net, P);
%result = sim(net2, P);

[ans place] = max(result);
place = place-1;

helper = 0;
correct = 0;

for ncases = 1 : length(place)
    if helper == 10
        helper = 0;
    end
    
    if(place([ncases]) == helper)
        correct = correct + 1;
    else
        correct = correct + 0;
    end
    
    helper = helper + 1;
end

correct = (correct / length(place)) * 100;

correct