clear;clc;
% simple sample data
% points = [46,42;37,52;52,64;52,33;52,41;62,42;42,57];
% demand = [0,19,16,11,15,8,8];
filename= 'db/tests.csv';
[~,~,file_data] = xlsread( filename);
data = cell2mat(file_data);
demand = data(:,1)';
points = data(:,2:3);

global CantP CantV CV PR D DT MDist
PR = points;                               % Coordinates
D = demand;                                % Demands
CantP=length(D);                           % Total of points
CV = 40;                                   % Vehicle max capacity
DT = sum(D);                               % Total demand
CantV=round(DT/CV)+round(CantP*0.05);      % Vehicle quantity approximate
[MDist, ~]= dist(PR);                      % Distance matrix. (Euclidean)

unvisited = 2:CantP;                       % Points not visited. All in the first time except depot
vehicles = zeros(CantV,CantP);
demands = [];
distances = [];
iter = 1;
tic
while ~isempty(unvisited)
    [vehicle,unvisited,demand,distance] = greedy(unvisited);
    vehicles(iter,1:length(vehicle))= vehicle;
    iter = iter+1;
    demands = [demands,demand];
    distances = [distances,distance];
end
cantRealVehicles = iter -1;
distanceTotal = sum(distances);
time = toc;
% Save to a file the results
save(strcat('results/greedy_results'));
