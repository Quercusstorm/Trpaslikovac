%rotate robot calc function, input = robot rotate angle (deg), output = left and right motor rotate angle (rad)
function [rotate_R,rotate_L] = rotate_robot(angle)
wheel_radius = 0.02625;  %robot wheels radius
wheels_distance = 0.154; %robot wheels distance
rotate_L = (((pi / 360) * wheels_distance * angle) / wheel_radius); %calc motor rotate angle in radians
rotate_R = -rotate_L; %oposit direction second wheel
end