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


left_motor = wb_robot_get_device('left_motor');
right_motor = wb_robot_get_device('right_motor');



 lidar = wb_robot_get_device('lidar');
 wb_lidar_enable(lidar, TIME_STEP);
 wb_lidar_enable_point_cloud(lidar);
i=0
while wb_robot_step(TIME_STEP) ~= -1


if i==40
[coordinates]=lidar_scan(lidar);
coordinates(1).x
plot([coordinates.x],-[coordinates.z])
i=0;
 else i=i+1;
end




  
  

  
  drawnow;

end