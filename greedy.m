function [vehicle,unvisited,demand, distance] = greedy(unvisited)
    global MDist CV D;    
    temp_demad = D(unvisited);
    point_demand = [unvisited;temp_demad];
    point_demand = sortrows(point_demand',2);
    [cantP,~]=size(point_demand);
    vehicle = [];
    demand = 0;
    distance = 0;
    i = 1;
    last = 0;
    while(i <= cantP && demand + point_demand(i,2)<= CV)
        if i == 1
            distance = distance + MDist(1,point_demand(i,1));
        else
            distance = distance + MDist(vehicle(last),point_demand(i,1));
        end
        vehicle = [vehicle, point_demand(i,1)];
        last = last + 1;
        demand = demand + point_demand(i,2);
        unvisited = unvisited(unvisited ~= point_demand(i,1));        
        i=i+1;
    end
end