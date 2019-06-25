function [outlinerMap] = consistencyCheck(LR, RL, TLR)
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hanwen Zhao
% CSCI 5722
% Assignment 3
% Instructor: Ioana Fleming
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% get the size of the image
[row, col] = size(LR);
% allocate memory for output
outlinerMap = zeros(row, col);

for i = 1:row
    for j = 1:col
        % disparity value on LR
        dLR = LR(i,j);
        % if out of boundary
        if j+dLR<1 || j+dLR>col
           outlinerMap(i,j) = 1;
        else
            jdLR = round(j+dLR);
            dRL = RL(i, jdLR);
            if abs(dLR-dRL) <= TLR
                % inlier point
                outlinerMap(i,j) = 0;
            else
                % outlier point
                outlinerMap(i,j) = 1;
            end
        end
    end
end
end