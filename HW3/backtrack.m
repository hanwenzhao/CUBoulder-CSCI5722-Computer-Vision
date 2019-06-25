function [vec] = backtrack(D, length)
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hanwen Zhao
% CSCI 5722
% Assignment 3
% Instructor: Ioana Fleming
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% create the container and initial them to NaN
vec = NaN(1, length);
% get the size of direction matrix
[row, col] = size(D);
% stop if we reach the scanline
while(row ~= 1 && col ~= 1)
    % NW = 1
    if D(row, col) == 1
        vec(row-1) = abs(row-col);
        % update iterators
        row = row - 1;
        col = col - 1;
    elseif D(row, col) == 2
        % N=2
        % update iterators
        row = row - 1;
    elseif D(row, col) == 3
        % W = 3
        % update iterators
        col = col - 1;
    end
end
end