clc,clear
load('coordinates.mat');
distance = zeros(numel(coordinates));
for i=1:numel(coordinates)
distance(i) = ((coordinates(i).x)^2+(coordinates(i).z)^2)^0.5;
end