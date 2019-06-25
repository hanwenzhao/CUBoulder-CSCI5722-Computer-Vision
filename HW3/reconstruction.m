function [point3D] = reconstruction(disparityMap, stereoParams)
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hanwen Zhao
% CSCI 5722
% Assignment 3
% Instructor: Ioana Fleming
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% formula 11.1 from textbook
% d = F(B/Z), Z = (F*B)/d, Units: (mm*pixels)/pixels = mm
% d = disparities(pixels), B = baseline(pixels), F = focal length(mm), Z = depth(mm)
% allocate memory for output
[m,n] = size(disparityMap);
point3D = zeros(m,n);
% obtain the focus length
focalLength = stereoParams.CameraParameters1.FocalLength;
% conver from pixels to mm
fx1 = focalLength(1)/0.25;
fy1 = focalLength(2)/0.25;
% focus length of the camera
Focal = (fx1 + fy1)/2;
% obtain the principle points
p1 = stereoParams.CameraParameters1.PrincipalPoint;
p2 = stereoParams.CameraParameters2.PrincipalPoint;
% calculate the baseline
D = sqrt((p2(1)-p1(1)).^2 + (p2(2)-p1(2)).^2);
for i = 1:m
    for j = 1:n
        dis = disparityMap(i,j);
        % calcuate depth
        depth = (Focal*D)/dis;
        % assign values
        point3D(i,j) = depth;
    end
end
end