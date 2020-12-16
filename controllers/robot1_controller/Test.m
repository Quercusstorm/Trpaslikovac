clc,clear
load('coordinates.mat');

phase = 'pick';
distance = linspace(1,numel(coordinates));  %prealocation
coordinates_x = linspace(1,numel(coordinates)); %prealocation
coordinates_z = linspace(1,numel(coordinates)); 
status = [];


for i=1:numel(coordinates)                          %coordinates matrix
    coordinates_x(i)=round(coordinates(i).x,3);
    coordinates_z(i)=round(coordinates(i).z,3);
end

distance = ((coordinates_x).^2+(coordinates_z).^2).^0.5;    %calculate distance from each point
 
dif = linspace(1,numel(distance)-1);               %prealocation
obstacle = [];
 
 for i=1:numel(distance)-1                          %search obstacle end points
    dif(i) = abs(distance(i)-distance(i+1));
    if dif(i) > 0.03
        obstacle = [obstacle,i];
    end
 end
 
 for i = 1: numel(obstacle)-1                       %edit end points error
 if abs(obstacle(i)-obstacle(i+1)) == 1
     obstacle(i) = (obstacle(i)+obstacle(i+1))/2;
     obstacle(i+1) = 1000;
 end
 end
 obstacle(obstacle==1000) = [];                     %delete duplicated end points
 
 if mod(numel(obstacle),2) == 0                     %if even obstacle number
     for i = 1:numel(obstacle)
         if mod(i,2) == 0
             obstacle(i)=floor(obstacle(i));        %round end obstacle points down
         else
             obstacle(i)=ceil(obstacle(i)+1);         %round end obstacle points up
         end
     end
 else
     status = 0;                                %error if odd obstacle number
 end
 if status == 0
     angle = 45;
     distance = 0.1;
 else
 
 distance_obstacle = [];
 obstacle_center=[];
 for i=1:(numel(obstacle))/2
     obstacle_center(i) = (obstacle(2*i)+obstacle((2*i)-1))/2;
     if floor(obstacle_center(i))==ceil(obstacle_center(i))
     distance_obstacle = [distance_obstacle,distance(obstacle_center(i))];
     else
         obstacle_center(i) = (obstacle(2*i)+obstacle((2*i)-1))/2;
         a =(distance(floor(obstacle_center(i)))+distance(ceil(obstacle_center(i))))/2;
         distance_obstacle = [distance_obstacle,a];
     end
 end
 average_dist = [];
 alpha_0 = 240/666;
 alpha = [];
 for i=1:(numel(obstacle))/2
     average_dist(i) = (distance(obstacle(2*i))+distance(obstacle((2*i)-1)))/2;
     alpha(i) = (obstacle(2*i)*alpha_0 - obstacle((2*i)-1)*alpha_0)/2;
 end
 
 obstacle_dia = tand(alpha).*average_dist;
 obstacle_angle = alpha_0.*obstacle_center-120;
 switch phase
     case 'pick'
           sorted_dia_map = find(obstacle_dia < 0.025);
 
         
     case 'place'
            sorted_dia_map = find(obstacle_dia > 0.025);
 end

 

 status = 1;
 distance_obstacle = distance_obstacle(sorted_dia_map);
 [distance_obstacle,I] = min(distance_obstacle);
 obstacle_angle = obstacle_angle(I);
 distance = distance_obstacle;
 angle = obstacle_angle;
 
 a = isempty(sorted_dia_map);
 if a == 1
     status = 0;
     distance_obstacle = 0.1;
     angle = 45;
 end
 end



