% MATLAB controller for Webots
% File:          robot1_controller.m
% Date:
% Description:
% Author:
% Modifications:

% uncomment the next two lines if you want to use
% MATLAB's desktop to interact with the controller:
%desktop;
%keyboard;

%variables:
TIME_STEP = 64; %world time_step
LM_pos = 0;
RM_pos = 0;
speed = 1;
acceleration = 5;
search_phase = 'place'
phase =0;
time = 0;
%devices
  %Grabber
pivot_1 = wb_robot_get_device('pivot_1');
pivot_2 = wb_robot_get_device('pivot_2');
pivot_3 = wb_robot_get_device('pivot_3');
pivot_4 = wb_robot_get_device('pivot_4');
finger_a = wb_robot_get_device('grabber finger A');
finger_b = wb_robot_get_device('grabber finger B');
finger_c = wb_robot_get_device('grabber finger C');
wb_motor_set_velocity(finger_a,1);
wb_motor_set_velocity(finger_b,1);
wb_motor_set_velocity(finger_c,1);
wb_motor_set_position(finger_a, 0.5);
wb_motor_set_position(finger_b, 0.5);
wb_motor_set_position(finger_c, 0.5);
  
  %Lidar
lidar = wb_robot_get_device('lidar');
wb_lidar_enable(lidar, TIME_STEP);
wb_lidar_enable_point_cloud(lidar);

  %motors
left_motor = wb_robot_get_device('left_motor');
right_motor = wb_robot_get_device('right_motor');
wb_motor_set_velocity(left_motor, speed);
wb_motor_set_velocity(right_motor, speed);
wb_motor_set_acceleration(left_motor, acceleration);
wb_motor_set_acceleration(right_motor, acceleration);

  %motor sensor
motor_pos_L = wb_motor_get_position_sensor(left_motor);
motor_pos_R = wb_motor_get_position_sensor(right_motor);
wb_position_sensor_enable(motor_pos_L,TIME_STEP);
wb_position_sensor_enable(motor_pos_R,TIME_STEP);
 



i=200
while wb_robot_step(TIME_STEP) ~= -1
actual_pos_L = wb_position_sensor_get_value(motor_pos_L);
actual_pos_R = wb_position_sensor_get_value(motor_pos_R);
time = TIME_STEP + time;

 coordinates = lidar_scan (lidar);
[distance,angle,status]=lidar_search(coordinates,search_phase);
[rotate_R rotate_L]=rotate_robot(angle);
[move_R, move_L]= move_robot (distance-0.03);

if phase == 0

    wb_motor_set_position(left_motor,rotate_L+LM_pos);
    wb_motor_set_position(right_motor,rotate_R+RM_pos);
       move_time = 1000*speed*abs(rotate_L)+1000 %time in sec
        if time > move_time
        phase = 1
        LM_pos = rotate_L +LM_pos;
        RM_pos = rotate_R +RM_pos;
        end
        end
if phase == 1
  wb_motor_set_position(left_motor,move_L+LM_pos);
   wb_motor_set_position(right_motor,move_R+RM_pos);
    move_time =1000*speed*abs(rotate_L)+1000
    if time >move_time
    phase = 0
    
     LM_pos = rotate_L +LM_pos;
     RM_pos = rotate_R +RM_pos;

end
LM_pos = actual_pos_L;
RM_pos = actual_pos_R;
end










%wb_motor_set_velocity(pivot_1, 1 )
%wb_motor_set_velocity(pivot_2, 1 )
%wb_motor_set_velocity(pivot_3, 1 )
%wb_motor_set_velocity(pivot_4, 1 )


%wb_motor_set_position(pivot_1, -0.5)
%wb_motor_set_position(pivot_2, -0.5)
%wb_motor_set_position(pivot_3, -0.55)
%wb_motor_set_position(pivot_4, -1.57)








  
  

  
  drawnow;

end