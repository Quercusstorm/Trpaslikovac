function [rotate_R,rotate_L]= move_robot(distance)
wheel_radius = 0.02625;
turns = distance/(2*wheel_radius*pi);
rotate_R = (turns * 6.283);
rotate_L = (turns * 6.283);
end