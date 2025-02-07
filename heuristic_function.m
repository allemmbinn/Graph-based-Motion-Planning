function dist_to_go = heuristic_function(next_point, final_point, heuristic, satellite_path)
    if heuristic == 1
        % Use Manhattan Distance
        dist_to_go = abs(final_point(1) - next_point(1)) + abs(final_point(2) - next_point(2));
    elseif heuristic == 2
        % Euclidian Distance
        dist_to_go = sqrt((final_point(1) - next_point(1))^2 + (final_point(2) - next_point(2))^2);
    elseif heuristic == 3
        % Custom Heuristic
        % Find the nearest point to the path
        if ~isempty(satellite_path)
            min_distance_sq = inf;
            path_length = length(satellite_path);
            closest_index = -1;
            for i = 1:length(satellite_path)
                diff_vector = satellite_path(i,:) - next_point;
                distance_sq = sqrt(diff_vector(1)^2 + diff_vector(2)^2);
                if distance_sq < min_distance_sq
                    min_distance_sq = distance_sq;
                    closest_index = i;
                end
            end
            % Cost to Goal - Length to the path
            dist_to_go = (path_length - closest_index) +  min_distance_sq;   
        else
            % In absence of the path - its just euclidean distance to the goal
            dist_to_go = sqrt((final_point(1) - next_point(1))^2 + (final_point(2) - next_point(2))^2);
        end
    end