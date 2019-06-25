function [d_color] = display_dmap(D)
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hanwen Zhao
% CSCI 5722
% Assignment 3
% Instructor: Ioana Fleming
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% get the maxiumu and minimum value, remap 
D = D/(max(max(D)) - min(min(D)));
% resize the image to 3 channels
d_color = repmat(D, 1, 1, 3);
% loop through the image
[row, col] = size(D);
for i = 1:row
    for j = 1:col
        if isnan(d_color(i,j,:))
            % only set the red channel
            d_color(i,j,1) = 1;
            d_color(i,j,2) = 0;
            d_color(i,j,3) = 0;
        end
    end
end
end