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

TIME_STEP = 50; %world time_step
start_coordinates = [0,0]; %robot start coordinates
LM_pos = 0;
RM_pos = 0;
i=0

 %lidar = wb_robot_get_device('lidar');
 %wb_lidar_enable(lidar, TIME_STEP);
 %wb_lidar_enable_point_cloud(lidar);
[RM_pos,LM_pos] = rotate_robot(90,1,5,RM_pos,LM_pos)



while wb_robot_step(TIME_STEP) ~= -1


if i==200
%[coordinates]=lidar_scan(lidar);
%[RM_pos,LM_pos] = move_robot(0.25,1,5,RM_pos,LM_pos)
%save ('coordinates.mat','coordinates')

i=0;
 else i=i+1;
end




  
  

  
  drawnow;

end