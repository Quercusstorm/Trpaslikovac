clc,clear
load('coordinates.mat');
distance = linspace(1,numel(coordinates));

for i=1:numel(coordinates)
distance(i) = ((coordinates(i).x)^2+(coordinates(i).z)^2)^0.5;
end
dif = linspace(1,numel(distance)-1);
prev_dif = [];
obstacle = [];
for i=1:numel(distance)-1
   dif(i) = abs(distance(i)-distance(i+1));
   if dif(i) > 0.01
       obstacle = [obstacle,i];
   end
end
