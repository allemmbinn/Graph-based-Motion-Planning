function visualisePath(map, path_exp, path_reach, path_astar, plt_title)
    figure;
    show(map);
    hold on;
    % Path taken by a-star
    for i=2:length(path_astar)-1
        x = path_astar(i,1) + [-1 0 0 -1];
        y = path_astar(i,2) + [0 0 -1 -1];
        patch(x, y, 'c', 'EdgeColor', 'c', 'HandleVisibility', 'off');
    end
    % For the Legend
    patch(NaN, NaN, 'c', 'EdgeColor', 'c', 'DisplayName', 'A-star Path');
    % Path taken in exploratory phase
    for i=2:length(path_exp)
        x = path_exp(i,1) + [-1 0 0 -1];
        y = path_exp(i,2) + [0 0 -1 -1];
        patch(x, y, 'red', 'EdgeColor', 'red', 'HandleVisibility', 'off');
    end
    % For the Legend
    patch(NaN, NaN, 'red', 'EdgeColor', 'red', 'DisplayName', 'Exploratory Path');
    %Path taken in reaching path phase
    if size(path_reach,1) == 1
        x = path_reach(1) + [-1 0 0 -1];
        y = path_reach(2) + [0 0 -1 -1];
        patch(x, y, 'blue', 'EdgeColor', 'blue', 'HandleVisibility', 'off');
    else
        for i=1:length(path_reach)
            x = path_reach(i,1) + [-1 0 0 -1];
            y = path_reach(i,2) + [0 0 -1 -1];
            patch(x, y, 'blue', 'EdgeColor', 'blue', 'HandleVisibility', 'off');
        end
    end
    %For the Legend
    patch(NaN, NaN, 'blue', 'EdgeColor', 'blue', 'DisplayName', 'Reaching A* Path');

    % Initial Point
    x = path_exp(1,1) + [-1 0 0 -1];
    y = path_exp(1,2) + [0 0 -1 -1];
    patch(x, y, 'yellow', 'EdgeColor', 'yellow', 'DisplayName', 'Start Point');
    % Final Point
    x = path_astar(end, 1) + [-1 0 0 -1];
    y = path_astar(end, 2) + [0 0 -1 -1];
    patch(x, y, 'green', 'EdgeColor', 'green', 'DisplayName', 'Goal Point');
    % Add legend
    legend('show', 'Location', 'best');
    title(plt_title);
    hold off;
end