function [path, reached] = a_star(map, initial_point, final_point, x_lim, y_lim, heuristic)
    visited = zeros(x_lim, y_lim);
    parent  = cell(x_lim, y_lim);
    % Each element in queue: [x; y; dist_to_come + dist_to_go]
    % Get cost_to_go
    if heuristic == 1
        % Use Manhattan Distance
        dist_to_go = abs(final_point(1) - initial_point(1)) + abs(final_point(2) - initial_point(2));
    else
        % Use Eucledian Distance
        dist_to_go = sqrt((final_point(1) - initial_point(1))^2 + (final_point(2) - initial_point(2))^2);
    end
    queue = [initial_point'; 0 + dist_to_go];
    % Control Actions
    U = [-1 0; 0 -1; 1 0; 0 1];
    while ~isempty(queue)
        [current_cost, idx] = min(queue(3, :));
        current_point  = queue(1:2,idx)';
        visited(current_point(1), current_point(2)) = 1;
        % Remove the element
        queue(:, idx) = [];
        if isequal(final_point, current_point)
            path = getPath(parent, initial_point, final_point);
            reached = true;
            return;
        end
        for u_ind = 1:length(U)
            next_point = current_point + U(u_ind, :);
            if next_point(1) >= 1 && next_point(2) >= 1 && next_point(1) <= x_lim && next_point(2) <= y_lim && getOccupancy(map, next_point) == 0 && ~visited(next_point(1),next_point(2))
                % dist_to_go = heuristic_function(next_point, final_point, heuristic, []);
                if heuristic == 1
                    % Use Manhattan Distance
                    dist_to_go = abs(final_point(1) - next_point(1)) + abs(final_point(2) - next_point(2));
                else
                    % Use Eucledian Distance - Even in custom we use
                    % Euclidean
                    dist_to_go = sqrt((final_point(1) - next_point(1))^2 + (final_point(2) - next_point(2))^2);
                end
                total_cost = current_cost + 1 + dist_to_go;
                % Checks if element in queue
                [flag, ind] = ismember(next_point, queue(1:2, :)',"rows");
                if flag
                    % Check if new cost is smaller
                    if queue(3, ind) > total_cost
                        queue(3, ind) = total_cost;
                        parent{next_point(1),next_point(2)} = current_point;
                    end
                else
                    % Since element not in queue, add to the queue
                    element = [next_point'; total_cost]; 
                    queue = [queue, element];
                    parent{next_point(1),next_point(2)} = current_point;
                end
                
            end
        end
    end
    % If path is not yet found
    path = [];
    reached = false;
end