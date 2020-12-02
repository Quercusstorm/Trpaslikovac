function move_robot(angle,distance,speed)
wb_motor_set_position(left_motor,inf);
wb_motor_set_velocity(left_motor, 2);
wb_motor_set_position(right_motor,inf);
wb_motor_set_velocity(right_motor, 2);
end