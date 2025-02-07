close all;
clear;
clc;
% Get number of obstacles for the map
while true
    no_obstacles = input('Enter number of obstacles (positive integer): ');
    if isnumeric(no_obstacles) && isscalar(no_obstacles) && no_obstacles > 0
        break;
    end
    fprintf(2, 'Invalid input. Please enter a positive integer.\n');
end
% Get initial point with validation
while true
    initial_point = input('Enter initial point [x y] (1 ≤ x ≤ 60, 1 ≤ y ≤ 50): ');
    if isnumeric(initial_point) && numel(initial_point) == 2 && ...
       all(initial_point >= [1 1]) && all(initial_point <= [60 50])
        initial_point = round(initial_point);
        break;
    end
    fprintf(2, 'Invalid input. Enter as [x y] with 1 ≤ x ≤ 60, 1 ≤ y ≤ 50\n');
end
% Get final point with validation
while true
    final_point = input('Enter final point [x y] (1 ≤ x ≤ 60, 1 ≤ y ≤ 50): ');
    if isnumeric(final_point) && numel(final_point) == 2 && ...
       all(final_point >= [1 1]) && all(final_point <= [60 50])
        final_point = round(final_point);
        break;
    end
    fprintf(2, 'Invalid input. Enter as [x y] with 1 ≤ x ≤ 60, 1 ≤ y ≤ 50\n');
end
% Create map with required no of obstacles
map = binaryOccupancyGrid(no_obstacles);
while getOccupancy(map, initial_point)==1 || getOccupancy(map, final_point)==1 
    disp("Obstacle at Initial or Final Point");
    map = binaryOccupancyGrid(no_obstacles);
end
disp("Initalised a proper map");
% Starting the movement of the vehicle and starting the call for A* algorithm
for heu=1:3
    if heu == 1
        disp("Using Manhattan Distance as Heuristic");
    elseif heu == 2
        disp("Using Euclidian Distance as Heuristic");
    else
        disp("Using Custom Heuristic");
    end
    reached = false;
    initial_count = 30;
    current_point = initial_point;
    path_exp = [initial_point];
    % Doesn't allow visitation more than once
    visited  = zeros(60, 50); 
    U = [-1 0; 0 -1; 1 0; 0 1];
    u_cost = zeros(4, 1); % Heuristic for each point
    % Initial 30 steps to the desired point
    while initial_count ~= 0
        initial_count = initial_count -1;            
        % Creates a cost based on x_diff, y_diff - if the difference is more 
        % more likely that u is taken except if an obstacle is found
        visited(current_point(1), current_point(2)) = visited(current_point(1), current_point(2)) + 1;
        % This cost provides inf cost to obstacle  or out of range        
        % and more cost if point is visited
        for i=1:length(U)
            next_point = current_point + U(i,:);
            if getOccupancy(map, next_point) == 0 && next_point(1) >= 1 &&...
               next_point(1) <= 60 && next_point(2) >= 1 && next_point(2) <= 50 
                weight = visited(next_point(1), next_point(2)) + 1;
                u_cost(i) = heuristic_function(next_point, final_point, heu, []) * weight;
            else
                u_cost(i) = 1e7;
            end
        end
        [~, sorted_indices] = sort(u_cost);
        % It takes the step where the heuristic cost will be minimum
        for i=1:length(sorted_indices)
            next_point = current_point + U(sorted_indices(i),:);
            if isequal(next_point, final_point)
                reached = true;
                path_exp = [path_exp; next_point];
                break;
            elseif getOccupancy(map, next_point) == 0 && next_point(1) >= 1 &&...
                    next_point(1) <= 60 && next_point(2) >= 1 && next_point(2) <= 50 
                path_exp = [path_exp; next_point];
                current_point = next_point;
                break;
            end
        end
    end
    % If we have not yet reached we use the path recieved from satellite now
    path_reach   = [];
    remaing_path = [];
    if ~reached
        [path_astar, reached_astar] = a_star(map, initial_point, final_point, 60, 50, heu);
    end
    % If the a_star path is reached
    if reached_astar
        % Now time to get to a_star path
        % Find the closest point to path
        min_distance_sq = inf;
        closest_index = -1;
        for i = 1:length(path_astar)
            diff_vector = path_astar(i,:) - current_point;
            distance_sq = diff_vector(1)^2 + diff_vector(2)^2;
            if distance_sq < min_distance_sq
                min_distance_sq = distance_sq;
                closest_index = i;
            end
        end
        % Setting to zero
        visited = zeros(60, 50);
        while ~reached
            % This is where the heuristic majorly comes
            % IF 1 - We move through Manhattan Distance of the closest point
            % IF 2 - We move through Euclidean Distance of the closes point
            % IF 3 - We move through the custom heuristic funciton
            visited(current_point(1), current_point(2)) = visited(current_point(1), current_point(2)) + 1;
            closest_point = path_astar(closest_index, :);
            for i=1:length(U)
                next_point = current_point + U(i,:);
                if getOccupancy(map, next_point) == 0 && next_point(1) >= 1 &&...
                   next_point(1) <= 60 && next_point(2) >= 1 && next_point(2) <= 50 
                    weight = visited(next_point(1), next_point(2)) + 1;
                    u_cost(i) = heuristic_function(next_point, closest_point, heu, []) * weight;
                else
                    u_cost(i) = 1e7;
                end
            end
            [~, sorted_indices] = sort(u_cost);
            for i=1:length(sorted_indices)
                next_point = current_point + U(sorted_indices(i),:);
                if isequal(next_point, closest_point)
                    reached = true;
                    path_reach = [path_reach; next_point];
                    break;
                elseif getOccupancy(map, next_point) == 0 
                    path_reach = [path_reach; next_point];
                    current_point = next_point;
                    break;
                end
            end
        end
        % Get to follow path
        remaing_path = path_astar(closest_index+1:end,:);
    end
    path = [path_exp; path_reach; remaing_path];
    % Get to follow path
    fprintf("Path Cost for the current method: %d\n", length(path));
    fprintf("Path Cost for the Ideal ASTAR Algorithm: %d\n", length(path_astar));
    disp("###########################################################");    
    if reached 
        if heu == 1
            plt_title = "Plot for Manhattan Distance Heuristic";
        elseif heu == 2
            plt_title = "Plot for Euclidean Distance Heuristic";
        else
            plt_title = "Plot for Custom Heuristic";
        end
        visualisePath(map, path_exp, path_reach, path_astar, plt_title);
    else
        disp("No Path Found");
    end
end