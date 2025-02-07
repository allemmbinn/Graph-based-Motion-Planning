function [shared_nodes, parent, reached] = dijkstra(map, initial_point, final_point, x_lim, shared_region)
    y_lim = [1, 50]; % Limit in the y-region
    visited = zeros(x_lim(2), y_lim(2)); % The nodes which have been visted
    parent  = cell(x_lim(2), y_lim(2)); % Parent nodes
    % distances = inf(x_lim(2), y_lim(2)); % Distance cost for each point
    % Each element in queue: [x; y; dist_to_come]
    queue = [initial_point'; 0];
    % distances(initial_point(1), initial_point(2)) = 0;
    reached = false; % For check if final point is reached
    shared_nodes = [];
    while ~isempty(queue)
        % Take the minimum value in the queue
        [current_dist, idx] = min(queue(3, :));
        current_point  = queue(1:2,idx)';
        visited(current_point(1), current_point(2)) = 1;
        % Remove the element
        queue(:, idx) = [];
        % Add the visited node in shared region to a queue
        if current_point(1) >= shared_region(1) && current_point(1) <= shared_region(2)   
            shared_nodes = [shared_nodes; current_point];
        end
        % Reached the final point
        if isequal(final_point, current_point)
            reached = true;
            return;
        end
        for i=-1:1
            for j=-1:1
                next_point = current_point + [i, j];
                % Check if point beyond limits or obstacle is present
                if next_point(1) >= x_lim(1) && next_point(2) >= y_lim(1) && next_point(1) <= x_lim(2) && next_point(2) <= y_lim(2) && getOccupancy(map, next_point) == 0 && ~visited(next_point(1),next_point(2))
                    if abs(i) + abs(j) == 2
                        cost_to_come = current_dist + 1.4; % Diagonal points
                    else
                        cost_to_come = current_dist + 1; % Vertical or Horizontal Points
                    end
                    % Checks if element in queue
                    [flag, ind] = ismember(next_point, queue(1:2, :)',"rows");
                    if flag
                        % Check if new cost is smaller
                        if queue(3, ind) > cost_to_come
                            queue(3, ind) = cost_to_come;
                            parent{next_point(1),next_point(2)} = current_point;
                        end
                    else
                        % Since element not in queue, add to the queue
                        element = [next_point'; cost_to_come]; 
                        queue = [queue, element];
                        parent{next_point(1),next_point(2)} = current_point;
                    end
                end
            end
        end
    end
end