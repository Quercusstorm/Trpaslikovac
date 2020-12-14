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

%speeds and accelaritons
move_speed = 1;
move_acceleration = 5;

grabber_speed = 1;
grabber_acceleration = 5;

arm_speed = 1;
arm_acceleration = 5;

search_phase = 'place'
phase = 0;
time = 0;
read = 1;
time_delay = 1000;

%devices
  %Arm and grabber
pivot_1 = wb_robot_get_device('pivot_1');
pivot_2 = wb_robot_get_device('pivot_2');
pivot_3 = wb_robot_get_device('pivot_3');
pivot_4 = wb_robot_get_device('pivot_4');
finger_a = wb_robot_get_device('grabber finger A');
finger_b = wb_robot_get_device('grabber finger B');
finger_c = wb_robot_get_device('grabber finger C');
wb_motor_set_velocity(pivot_1, arm_speed)
wb_motor_set_velocity(pivot_2, arm_speed)
wb_motor_set_velocity(pivot_3, arm_speed)
wb_motor_set_velocity(pivot_4, arm_speed)
wb_motor_set_velocity(finger_a,grabber_speed);
wb_motor_set_velocity(finger_b,grabber_speed);
wb_motor_set_velocity(finger_c,grabber_speed);
wb_motor_set_acceleration(pivot_1, arm_acceleration);
wb_motor_set_acceleration(pivot_2, arm_acceleration);
wb_motor_set_acceleration(pivot_3, arm_acceleration);
wb_motor_set_acceleration(pivot_4, arm_acceleration);
wb_motor_set_acceleration(finger_a, grabber_acceleration);
wb_motor_set_acceleration(finger_b, grabber_acceleration);
wb_motor_set_acceleration(finger_c, grabber_acceleration);
  
  %Lidar
lidar = wb_robot_get_device('lidar');
wb_lidar_enable(lidar, TIME_STEP);
wb_lidar_enable_point_cloud(lidar);

  %Motors
left_motor = wb_robot_get_device('left_motor');
right_motor = wb_robot_get_device('right_motor');
wb_motor_set_velocity(left_motor, move_speed);
wb_motor_set_velocity(right_motor, move_speed);
wb_motor_set_acceleration(left_motor, move_acceleration);
wb_motor_set_acceleration(right_motor, move_acceleration);

  %Motor sensor
motor_pos_L = wb_motor_get_position_sensor(left_motor);
motor_pos_R = wb_motor_get_position_sensor(right_motor);
wb_position_sensor_enable(motor_pos_L,TIME_STEP);
wb_position_sensor_enable(motor_pos_R,TIME_STEP);
 



while wb_robot_step(TIME_STEP) ~= -1
actual_pos_L = wb_position_sensor_get_value(motor_pos_L);
actual_pos_R = wb_position_sensor_get_value(motor_pos_R);
time = TIME_STEP + time;
coordinates = lidar_scan (lidar);

if read == 1
%save('coordinates.mat','coordinates')
[distance,angle,status] = lidar_search(coordinates,search_phase);
angle
[rotate_R rotate_L] = rotate_robot(angle);
LM_pos
[move_R, move_L] = move_robot (distance);
read = 0
end


  if phase == 0
  
      wb_motor_set_position(left_motor,rotate_L + LM_pos);
      wb_motor_set_position(right_motor,rotate_R + RM_pos);
         move_time = 1000 * move_speed * abs(rotate_L) + time_delay; %time in sec
          if time > move_time
            if status == 0
              read = 1;
            else
                phase = 1
             end
             time = 0
             LM_pos = rotate_L + LM_pos;
             RM_pos = rotate_R + RM_pos;
            end
          
          end
  
  if phase == 1
    wb_motor_set_position(left_motor,move_L + LM_pos);
    wb_motor_set_position(right_motor,move_R + RM_pos);
      move_time = 1000 * move_speed * abs(move_L) + time_delay;
      if time > move_time
        phase = 2
        LM_pos = move_L + LM_pos;
        RM_pos = move_R + RM_pos;
        time = 0
      end
  end
  
  if phase == 2
      arm_phase = 'down';
      [arm_pos_1,arm_pos_2,arm_pos_3] = arm (arm_phase);
      %wb_motor_set_position(finger_a, grabber)
      %wb_motor_set_position(finger_b, grabber)
      %wb_motor_set_position(finger_c, grabber)
      wb_motor_set_position(pivot_1,arm_pos_1);
      wb_motor_set_position(pivot_2,arm_pos_1);
      wb_motor_set_position(pivot_3,arm_pos_2);
      wb_motor_set_position(pivot_4,arm_pos_3);
      
     move_time = 1000 * arm_speed * abs(arm_pos_3) + time_delay;
       if time > move_time
         phase = 3
         read = 1
         time = 0
       end
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