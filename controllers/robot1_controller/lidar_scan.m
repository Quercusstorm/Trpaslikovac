function [points]=lidar_scan(sensor_name)
points = wb_lidar_get_point_cloud(sensor_name);

end