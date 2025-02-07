# Motion Planning and Control of Unmanned Vehicles - Exercise 1

## Author
Name: Allen Emmanuel Binny  
Roll Number: 21EC39035

## How to run files
1. Add all the files in the folder to path
2. For the Part A of the problem: 
   a. Run the following command
    ```matlab
    exercise_a
    ```
    b. Provide values for the prompts. An example is shown below
    ```matlab
    Enter the number of obstacles (positive integer): 400
    Enter initial point [x y] (1 ≤ x ≤ 60, 1 ≤ y ≤ 50): [1 10]
    Enter final point [x y] (1 ≤ x ≤ 60, 1 ≤ y ≤ 50): [40 35]
    ```
    Note that the initial and final points must be entered in this format within the brackets. If found out of range, it will be prompted to try again.  
    c. Output Graphs as found in figures will be displayed if the path is found. Else it is displayed that the path is not found.

3. For the Part B of the problem:  
   a. Run the following command
    ```matlab
    exercise_b
    ```
    b. Provide values for the prompts. An example is shown below
    ```matlab
    Enter the number of obstacles (positive integer): 400
    Enter initial point [x y] (1 ≤ x ≤ 60, 1 ≤ y ≤ 50): [1 10]
    Enter final point [x y] (1 ≤ x ≤ 60, 1 ≤ y ≤ 50): [40 35]
    ```
    Note that the initial and final points must be entered in this format within the brackets. If found out of range, it will be prompted to try again.  

    c. If the path is found, Output Graphs as found in figures for different heuristics - Manhattan, Euclidean and Custom Heuristic is displayed. Additionally the cost of the paths are also displayed. An example is shown below:
    ```matlab
    Using Manhattan Distance as Heuristic
    Path Cost for the current method: 98
    Path Cost for the Ideal ASTAR Algorithm: 96
    ###########################################################
    Using Euclidian Distance as Heuristic
    Path Cost for the current method: 106
    Path Cost for the Ideal ASTAR Algorithm: 96
    ###########################################################
    Using Custom Heuristic
    Path Cost for the current method: 106
    Path Cost for the Ideal ASTAR Algorithm: 96
    ###########################################################
    ```
    d. If the path is not found then an appropriate message is displayed.

## Directory Structure

21EC39035_Exercise_1/  
├── Figures/  
│ ├── Part A/  
│ │ ├── Case_1.png  
│ │ ├── Case_2.png  
│ │ ├── Case_3.png  
│ │ └── Case_4.png  
│ └── Part B/  
│ ├── 300_obstacles.png  
│ ├── 750_obstacles.png  
│ ├── Custom_750.png  
│ ├── Custom.png  
│ ├── Euclidean_750.png  
│ ├── Euclidean.png  
│ ├── Manhattan_750.png  
│ └── Manhattan.png  
├── 21EC39035_Motion_Planning.pdf  
├── Problem_Statement.pdf  
├── README.txt  
├── a_star.m  
├── binaryOccupancyGrid.m  
├── dijkstra.m  
├── exercise_a.m  
├── exercise_b.m  
├── getPath.m  
├── heuristic_function.m  
├── joinPaths.m  
├── visualise_path_double.m  
└── visualisePath.m  


## Description
This repository contains the implementation of path planning algorithms for an autonomous vehicle guided by two satellites. The project demonstrates both satellite-based path planning and autonomous vehicle navigation using various algorithms.

## Files Description

### Main Scripts
- `exercise_a.m`: Implementation of Part A (Satellite Path Planning)
- `exercise_b.m`: Implementation of Part B (Autonomous Vehicle Path Planning)

### Core Functions
- `a_star.m`: A* algorithm implementation with Manhattan Distance and Euclidean Distance heuristics
- `dijkstra.m`: Dijkstra's algorithm implementation for satellite path planning
- `binaryOccupancyGrid.m`: Creates occupancy grid with random obstacles
- `getPath.m`: Reconstructs path from parent nodes
- `joinPaths.m`: Merges paths in shared satellite region
- `visualisePath.m`: Basic path visualization function
- `visualise_path_double.m`: Enhanced visualization for dual satellite paths
- `heuristic_function.m`: Implementation of different heuristic functions

### Documentation
- `Problem_Statement.pdf`: Original assignment problem statement
- `21EC39035_Motion_Planning.pdf`: Detailed report of implementation and results

### Results
- `Figures/Part A/`: Contains visualization results for different satellite path planning cases
- `Figures/Part B/`: Contains results for different heuristic implementations and obstacle densities

## Usage
1. Run `exercise_a.m` for satellite-based path planning
2. Run `exercise_b.m` for autonomous vehicle path planning
3. Follow the prompts to input:
   - Number of obstacles
   - Initial point coordinates
   - Final point coordinates

## Implementation Details
- Part A: Satellite path planning using Dijkstra's algorithm
- Part B: Autonomous vehicle navigation using A* algorithm with different heuristics:
  - Manhattan distance
  - Euclidean distance
  - Custom heuristic combining path distance and goal estimation