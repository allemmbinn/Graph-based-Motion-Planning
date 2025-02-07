function visualise_path_double(map, initial_point, final_point, path_1, path_2, join_point, plt_title)
    figure;
    show(map);
    hold on;
    
    % Plot Satellite 1 path
    if ~isempty(path_1)
        for i=2:length(path_1)-1
            x = path_1(i,1) + [-1 0 0 -1];
            y = path_1(i,2) + [0 0 -1 -1];
            if i == 2
                patch(x, y, 'red', 'EdgeColor', 'red', 'DisplayName', 'Satellite 1 Path');
            else
                patch(x, y, 'red', 'EdgeColor', 'red', 'HandleVisibility', 'off');
            end
        end
    end
    
    % Plot Satellite 2 path
    if ~isempty(path_2)
        for i=2:length(path_2)-1
            x = path_2(i,1) + [-1 0 0 -1];
            y = path_2(i,2) + [0 0 -1 -1];
            if i == 2
                patch(x, y, 'c', 'EdgeColor', 'c', 'DisplayName', 'Satellite 2 Path');
            else
                patch(x, y, 'c', 'EdgeColor', 'c', 'HandleVisibility', 'off');
            end
        end
    end
    
    % Plot other points
    if ~isempty(join_point)
        x = join_point(1) + [-1 0 0 -1];
        y = join_point(2) + [0 0 -1 -1];
        patch(x, y, 'b', 'EdgeColor', 'b', 'DisplayName', 'Meeting Point');
    end
    
    x = initial_point(1) + [-1 0 0 -1];
    y = initial_point(2) + [0 0 -1 -1];
    patch(x, y, 'yellow', 'EdgeColor', 'yellow', 'DisplayName', 'Initial Point');
    
    x = final_point(1) + [-1 0 0 -1];
    y = final_point(2) + [0 0 -1 -1];
    patch(x, y, 'green', 'EdgeColor', 'green', 'DisplayName', 'Final Point');
    
    % Add legend
    legend('show', 'Location', 'best');
    title(plt_title);
    hold off;
end
