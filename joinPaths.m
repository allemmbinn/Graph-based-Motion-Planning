function [best_pair, done] = joinPaths(array1, array2)
    % Find matching FULL ROWS (both elements)
    [i_indices, j_indices] = meshgrid(1:size(array1,1), 1:size(array2,1));
    full_matches = all(array1(i_indices(:), :) == array2(j_indices(:), :), 2);
    
    % Get matching pairs with both elements equal
    matching_pairs = [i_indices(full_matches), j_indices(full_matches)];
    
    % Calculate minimum sum of indices
    if isempty(matching_pairs)
        done = false;
        best_pair = [];
    else
        sum_indices = sum(matching_pairs, 2);
        [~, idx] = min(sum_indices);
        best_pair = matching_pairs(idx,:);
        done = true;
    end
end