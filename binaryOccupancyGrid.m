function map=binaryOccupancyGrid(no_obstacles)
    map = binaryOccupancyMap(50 , 60 , 1 , "grid");
    %add obstacles
    i = 0;
    while i<=no_obstacles
        x = randi([ 0, 60]);
        y = randi([ 0, 50]);
        i = i+1;
        setOccupancy(map,[ x, y], 1)
    end
end