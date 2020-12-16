%move robot calc function, input = robot move distance (meters), output = left and right motor rotate (rad)
function [rotate_R,rotate_L] = move_robot(distance)
wheel_radius = 0.02625; %robot wheels radius
turns = distance / (2 * wheel_radius * pi); %calc number of motor turns
rotate_L = (turns * 6.283); %calc motor rotate in radians
rotate_R = rotate_L; %same rotate fo second motor
end