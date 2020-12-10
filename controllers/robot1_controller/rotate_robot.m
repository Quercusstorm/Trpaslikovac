function [rotate_R,rotate_L]=rotate_robot(angle)

wheel_radius = 0.02625;
wheels_distance = 0.154;
rotate_L = (((pi/360)*wheels_distance*angle)/wheel_radius);
rotate_R = ((-(pi/360)*wheels_distance*angle)/wheel_radius);

end