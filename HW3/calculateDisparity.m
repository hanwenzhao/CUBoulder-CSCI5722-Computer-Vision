function [disparityMap] = calculateDisparity(leftImg, rightImg)
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hanwen Zhao
% CSCI 5722
% Assignment 3
% Instructor: Ioana Fleming
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% assign some constant
maxDis = 63;
occ = 0.01;
% convert images to double precision for calculations
leftImg = double(leftImg);
rightImg = double(rightImg);
% obtain the size of the image
[rows, cols] = size(leftImg);
% allocate memory
disparityMap = zeros(rows, cols);
% loop through the image
for row = 1:rows
    dispVec = stereoDP(leftImg(row,:), rightImg(row,:), maxDis, occ);
    disparityMap(row,:) = dispVec;
end
end