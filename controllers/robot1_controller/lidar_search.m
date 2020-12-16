function [distance,angle,status] = lidar_search (coordinates, phase)
  distance = []; %variables
  coordinates_x =[] ;
  coordinates_z = [];
  dif = [];
  status = [0];
  alpha_0 = 240/666;
  center =[];
  diameter = [];
  obstacle = [];
  dif_value = 0.03;

  for i = 1:numel(coordinates)                          %coordinates matrix
    coordinates_x(i) = round(coordinates(i).x,3);
    coordinates_z(i) = round(coordinates(i).z,3);
  end

  distance = ((coordinates_x).^2 + (coordinates_z).^2).^0.5;    %calculate distance from each point
  
  for i = 1:length(distance) - 1                          %search obstacle end points
    dif(i) = abs(distance(i) - distance(i+1));
    if dif(i) > dif_value
      obstacle = [obstacle, i+0.5];
    end
  end

  for i = 1 : length(obstacle) - 1                       %edit end points error
    if abs(obstacle(i) - obstacle(i+1)) == 1
      if mod(i,2) == 0 %sudé
        obstacle(i+1) = 1000;
      else
        obstacle(i) = 1000;
      end
    end
  end
 
  obstacle(obstacle == 1000) = []; %delate obstactacle = 1000
  if mod(length(obstacle),2) ~= 0
    status = 0;
  else
    for i = 1:length(obstacle) / 2
      center(i) = (obstacle(2*i) + obstacle(2*i-1)) / 2;
      center(i) = ceil(center(i));
    end
    center_angle = (center.*alpha_0)-120;
    points_angle = (obstacle.*alpha_0)-120; %agle calc
    center_distance = distance(center); %center dist calc
 
   for i = 1:length(points_angle) / 2
     beta = abs(abs(center_angle(i)) - abs(points_angle(2*i))) ;
     diameter(i) = (center_distance(i) * sind(beta)) / (1-sind(beta)); %diameter calc
   end
 
   switch phase %diameter choice
     case ('pick')
       sorted_dia_map = find(diameter < 0.025); %small
     case ('place')
       sorted_dia_map = find(diameter > 0.025); %big
    end
    
    a = isempty(sorted_dia_map); %status edit
    
    if a == 1
      status = 0;
    else %sort out values
      center_distance = center_distance(sorted_dia_map);
      center_angle = center_angle(sorted_dia_map);
      [center_distance,I] = min(center_distance);
      center_angle = center_angle(I);
      distance = center_distance - 0.025;
      angle = center_angle;
      status = 1;
    end
  end
  if status == 0 %error search
    distance = 0;
    angle = 180;
  end
end