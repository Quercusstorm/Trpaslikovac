function [ ] = grabber(phase, speed)
pivot_1 = wb_robot_get_device('pivot_1');
pivot_2 = wb_robot_get_device('pivot_2');
pivot_3 = wb_robot_get_device('pivot_3');
pivot_4 = wb_robot_get_device('pivot_4');
finger_a = wb_robot_get_device('grabber finger A');
finger_b = wb_robot_get_device('grabber finger B');
finger_c = wb_robot_get_device('grabber finger C');

double r = 0.0
double r_3 = 0.0
double r_4 = 0.0
double v = 0.0

if(phase == sklonit)
 r = MAX(pivot_1,r-0.5)
 r_3= MAX(pivot_3, r-0.55)
 r_4= MAX(pivot_3, r-1.57)
 elseif (phase == zdvih)
 r= MIN(pivot_1,r-0.4)
 r_3= MIN(pivot_3, r-0.4)
 r_4= MIN(pivot_3, r-0.4)
 elseif (phase == otvor)
 v = MAX(finger_a, v+0.5)
 elseif (phase == zatvor)
 v = MIN(finger_a, 0.0)
 
wb_motor_set_velocity(finger_a,1)
wb_motor_set_velocity(finger_b,1)
wb_motor_set_velocity(finger_c,1)
wb_motor_set_velocity(pivot_1, 1)
wb_motor_set_velocity(pivot_2, 1)
wb_motor_set_velocity(pivot_3, 1)
wb_motor_set_velocity(pivot_4, 1)
wb_motor_set_velocity(pivot_5, 1)
wb_motor_set_velocity(finger_a, 1)
wb_motor_set_velocity(finger_b, 1)
wb_motor_set_velocity(finger_c, 1)

wb_motor_set_position(finger_a, v)
wb_motor_set_position(finger_b, v)
wb_motor_set_position(finger_c, v)
wb_motor_set_position(pivot_1,r);
wb_motor_set_position(pivot_2,r);
wb_motor_set_position(pivot_3,r_3);
wb_motor_set_position(pivot_4,r_4);
wb_motor_set_position(finger_a,v);
wb_motor_set_position(finger_b,v);
wb_motor_set_position(finger_c,v);


end