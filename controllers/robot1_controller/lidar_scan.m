function [coordinates]=lidar_scan(sensor_name);
coordinates = wb_lidar_get_point_cloud(sensor_name);
fields = {'y','layer_id','time'};
coordinates = rmfield(coordinates,fields);
end