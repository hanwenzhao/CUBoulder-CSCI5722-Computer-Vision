function [ImgOut] = warp1(H,ImgIn)
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hanwen Zhao
% CSCI 5722
% Assignment 2
% Instructor: Ioana Fleming
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calculate inverse Homography
Hinv = inv(H);
% check the channel of the image
[m,n,c] = size(ImgIn);
ImgOut = uint8(zeros(1500,1500,c));
for i = 1:1500
    for j = 1:1500
        % calculate coordinates base on inverse H
        XY = Hinv*[i;j;1];
        % make the last value to 1
        XY = XY/XY(end);
        % if the backward mapping coordinates within the image size, assign
        % values
        if (round(XY(1))>=1) && (round(XY(1))<=m) && (round(XY(2))>=1) && (round(XY(2)<=n))
            ImgOut(i,j,:) = ImgIn(round(XY(1)),round(XY(2)),:);
        end
    end
end
end