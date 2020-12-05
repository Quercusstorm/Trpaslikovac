function [ ] = grabber(phase, speed)
pivot_1 = wb_robot_get_device('pivot_1');
pivot_2 = wb_robot_get_device('pivot_2');
pivot_3 = wb_robot_get_device('pivot_3');
pivot_4 = wb_robot_get_device('pivot_4');
finger_a = wb_robot_get_device('finger_a');
finger_b = wb_robot_get_device('finger_b');
finger_c = wb_robot_get_device('finger_c');

double r = 0.0
double s = 0.0

if(phase == sklonit)
 r = MAX(pivot_1,r-0.05)
 elseif (phase == zdvih)
 r= MIN(pivot_1,r+0.05)
 elseif (phase == otvor)
 v = MAX(finger_a, s+0.05)
 elseif (phase == zatvor)
 v = MIN(finger_a, s-0.05)
 
wb_motor_set_velocity(pivot_1, 1)
wb_motor_set_velocity(pivot_2, 1)
wb_motor_set_velocity(pivot_3, 1)
wb_motor_set_velocity(pivot_4, 1)
wb_motor_set_velocity(pivot_5, 1)
wb_motor_set_velocity(finger_a, 1)
wb_motor_set_velocity(finger_b, 1)
wb_motor_set_velocity(finger_c, 1)

wb_motor_set_position(pivot_1,r);
wb_motor_set_position(pivot_2,r);
wb_motor_set_position(pivot_3,r);
wb_motor_set_position(pivot_4,r);
wb_motor_set_position(finger_a,v);
wb_motor_set_position(finger_b,v);
wb_motor_set_position(finger_c,v);


end