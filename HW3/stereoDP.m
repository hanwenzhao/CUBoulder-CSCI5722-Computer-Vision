function [disparityVec] = stereoDP(leftVec, rightVec, maxDis, occ)
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hanwen Zhao
% CSCI 5722
% Assignment 3
% Instructor: Ioana Fleming
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% get the size of vector
length = size(leftVec, 2);
row = length + 1;
col = length + 1;
% allocate memories for cost function and direction function
C = zeros(row, col);
D = zeros(row, col);
% initialize values
% D(i,0) = rows * occ
for i = 1:row
    C(i,1) = i * occ;
end
% D(0,j) = cols * occ
for i = 1:col
    C(1, i) = i * occ;
end
% loop through the matrix
for i = 2:row
    for j = 2:col
        % d11 = (Il(1)-Ir(1)).^2
        if i == 2 && j == 2
           NW = (leftVec(i-1) - rightVec(j - 1)).^2;
           C(i,j) = NW;
           D(i,j) = 1;
        else
            % D(i, j) = min(D(i?1,j?1) + dij , D(i?1,j) + occ, D(i,j?1) + occ)
            NW = C(i-1, j-1) + (leftVec(i-1)-rightVec(j-1)).^2;
            N = C(i-1, j) + occ;
            W = C(i, j-1) + occ;
            if NW < N && NW < W
                C(i,j) = NW;
                D(i,j) = 1;
            elseif N < NW && N < W
                C(i,j) = N;
                D(i,j) = 2;
            else
                C(i,j) = W;
                D(i,j) = 3;
            end
        end
    end
end
disparityVec = backtrack(D, length);
end