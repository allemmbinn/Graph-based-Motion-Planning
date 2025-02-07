function path = getPath(parent, initial_point, final_point)
    path = final_point;
    while ~isequal(path(1,:),initial_point)
        path = [parent{path(1,1),path(1,2)}; path];
    end
end