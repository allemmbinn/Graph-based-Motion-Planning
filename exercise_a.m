close all;
clear;
clc;
% Get user inputs with validation
while true
    no_obstacles = input('Enter the number of obstacles (positive integer): ');
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
    disp("Enter final point [x y] (1 ≤ x ≤ 60, 1 ≤ y ≤ 50): ");
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
% Defining Limtis for the Satellites
% Satellite 1
x_lim_1 = [1, 40];
x_lim_2 = [30, 60];
y_lim   = [1, 50];
shared_region = [x_lim_2(1), x_lim_1(2)];
% Getting all the paths
% path_1 and path_2 store the paths of individual satellites while path stores the actual path
path_1 = [];
path_2 = [];
join_point = [];
% Now we check for the 4 cases to see which satellites need to be used
if initial_point(1) <= x_lim_1(2) && final_point(1) <= x_lim_1(2)
    % Both start and end in region of satellite 1
    [~, parent_1, reached] = dijkstra(map, initial_point, final_point, x_lim_1, shared_region);
    if reached
        path_1 = getPath(parent_1, initial_point, final_point);
        path   = path_1;
    end
elseif initial_point(1) >= x_lim_2(1) && final_point(1) >= x_lim_2(1)
    % Both lie in region of satellite 2
    [~, parent_2, reached] = dijkstra(map, initial_point, final_point, x_lim_2, shared_region);
    if reached
        path_2 = getPath(parent_2, initial_point, final_point);
        path   = path_2;
    end
elseif initial_point(1) < x_lim_2(1) && final_point(1) > x_lim_1(2)
    % dijstra for satellite 1 from start and satellite 2 from end
    [shared_nodes_1, parent_1, ~] = dijkstra(map, initial_point, final_point, x_lim_1, shared_region);
    [shared_nodes_2, parent_2, ~] = dijkstra(map, final_point, initial_point, x_lim_2, shared_region);
    % function to find the points where the first joining happens of
    % forward and backward search of the paths
    [best_pair, done] = joinPaths(shared_nodes_1, shared_nodes_2);
    if done
        reached = true;
        join_point = shared_nodes_1(best_pair(1),:);
        path_1 = getPath(parent_1, initial_point, join_point);
        % Remove the last element
        path_1_temp = path_1(1:end-1,:);
        path_2 = getPath(parent_2, final_point, join_point);
        % Reverse the rows
        path_2 = path_2(end:-1:1, :);
        path = [path_1_temp; path_2];
    else
        reached = false;
    end
else
    % dijstra for satellite 2 from start and satellite 1 from end
    [shared_nodes_2, parent_2, ~] = dijkstra(map, initial_point, final_point, x_lim_2, shared_region);
    [shared_nodes_1, parent_1, ~] = dijkstra(map, final_point, initial_point, x_lim_1, shared_region);
    % function to find the points where the first joining happens of
    % forward and backward search of the paths
    [best_pair, done] = joinPaths(shared_nodes_1, shared_nodes_2);
    if done
        reached = true;
        join_point = shared_nodes_1(best_pair(1),:);
        path_2 = getPath(parent_2, initial_point, join_point);
        path_2_temp = path_2(1:end-1,:);
        path_1 = getPath(parent_1, final_point, join_point);
        % Reverse the rows
        path_1 = path_1(end:-1:1, :);
        path = [path_2_temp; path_1];
    else
        reached = false;
    end
end
if reached
    disp("Path Found");
    visualise_path_double(map, initial_point, final_point, path_1, path_2, join_point, "Dijkstra's Algorithm");
else
    % Printing Error that path not found
    fprintf(2, "No Path Found.\n");
end