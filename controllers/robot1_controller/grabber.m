function [ ] = grabber()
pivot_1 = wb_robot_get_device("pivot_1");
pivot_2 = wb_robot_get_device("pivot_2");
pivot_3 = wb_robot_get_device("pivot_3");
pivot_4 = wb_robot_get_device("pivot_4");
pivot_5 = wb_robot_get_device("pivot_5");
finger_a = wb_robot_get_device("finger_a");
finger_b = wb_robot_get_device("finger_b");
finger_c = wb_robot_get_device("finger_c");

while(wb_robot_step(timestep)) 

end
xxx = 0.5
wb_motor_set_position(pivot_1,);
wb_motor_set_position(pivot_2,);
wb_motor_set_position(pivot_3,);
wb_motor_set_position(pivot_4,);
wb_motor_set_position(pivot_5,);
wb_motor_set_position(finger_a,);
wb_motor_set_position(finger_b,);
wb_motor_set_position(finger_c,);


end