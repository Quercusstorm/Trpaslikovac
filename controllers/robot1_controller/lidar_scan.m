function [coordinates]=lidar_scan(sensor_name)
points = wb_lidar_get_point_cloud(sensor_name);
coordinates = struct2table(points);
coordinates.y = [];
coordinates.layer_id = [];
coordinates.time = [];
end