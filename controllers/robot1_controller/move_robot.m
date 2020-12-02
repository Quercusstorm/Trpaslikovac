function = move_robot(angle,distance,speed,acceleration)

left_motor = wb_robot_get_device('left_motor');
right_motor = wb_robot_get_device('right_motor');


wheel_radius = 0.02625;
wheels_distance = 0.154;
rotate_wheel = ((pi/360)*wheels_distance*angle)/wheel_radius;

wb_motor_set_velocity(left_motor, speed);
wb_motor_set_velocity(right_motor, speed);
wb_motor_set_acceleration(left_motor, acceleration);
wb_motor_set_acceleration(right_motor, acceleration);
wb_motor_set_position(left_motor,rotate_wheel);
wb_motor_set_position(right_motor,-rotate_wheel);


end