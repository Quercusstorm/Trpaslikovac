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
TIME_STEP = 50; %world time_step
phase = 'find_ball';
status = 0;
LM_pos = 0;
RM_pos = 0;
motor_position = 1
i=0;

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

  %motor sensor

  





while wb_robot_step(TIME_STEP) ~= -1


[RM_pos,LM_pos] = move_robot(0.5,1,5,RM_pos,LM_pos)







%[RM_pos,LM_pos] = move_robot(0.25,1,5,RM_pos,LM_pos)
%save ('coordinates.mat','coordinates')


%wb_motor_set_velocity(pivot_1, 1 )
%wb_motor_set_velocity(pivot_2, 1 )
%wb_motor_set_velocity(pivot_3, 1 )
%wb_motor_set_velocity(pivot_4, 1 )


%wb_motor_set_position(pivot_1, -0.5)
%wb_motor_set_position(pivot_2, -0.5)
%wb_motor_set_position(pivot_3, -0.55)
%wb_motor_set_position(pivot_4, -1.57)



%i=0;
 %else i=i+1;
%end




  
  

  
  drawnow;

end