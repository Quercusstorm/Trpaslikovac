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

TIME_STEP = 50;

% get and enable devices, e.g.:
%  camera = wb_robot_get_device('camera');
%  wb_camera_enable(camera, TIME_STEP);
left_motor = wb_robot_get_device('left_motor');
right_motor = wb_robot_get_device('right_motor');


%%wb_motor_set_position(left_motor,inf);
%wb_motor_set_velocity(left_motor, 2);
%wb_motor_set_position(right_motor,inf);
%%wb_motor_set_velocity(right_motor, 2);

%  camera = wb_robot_get_device('camera');
%  wb_camera_enable(camera, TIME_STEP);
% main loop:
% perform simulation steps of TIME_STEP milliseconds
% and leave the loop when Webots signals the termination
%
 sensor = wb_robot_get_device('sensor');
 wb_lidar_enable(sensor, TIME_STEP);
 wb_lidar_enable_point_cloud(sensor);
i=0
while wb_robot_step(TIME_STEP) ~= -1
[points]=lidar_scan(sensor);
if i==200
 points.x
 points.z
 i=0;
 else i=i+1;
end
 %save('points_data.mat','-struct','points')
 
  % read the sensors, e.g.:
  %  rgb = wb_camera_get_image(camera);

  % Process here sensor data, images, etc.

  % send actuator commands, e.g.:
  %  wb_motor_set_postion(motor, 10.0);

  % if your code plots some graphics, it needs to flushed like this:
  drawnow;

end

% cleanup code goes here: write data to files, etc.
