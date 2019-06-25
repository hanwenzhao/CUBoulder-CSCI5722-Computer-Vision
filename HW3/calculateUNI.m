function [disparityMap] = calculateUNI(leftImg, rightImg, kSize, maxDis)
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hanwen Zhao
% CSCI 5722
% Assignment 3
% Instructor: Ioana Fleming
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% convert uint8 to double
leftImg = double(leftImg);
rightImg = double(rightImg);
% get the size of the image
[row,col] = size(leftImg);
% allocate memory for output
disparityMap = zeros(row,col);
% pad the image for calculations
rightImg = [rightImg, NaN(row,maxDis)];
% offset base on the kernal size
offset = floor(kSize/2);
% for kernal size equal to 1
% loop through the image
if kSize == 1
    for i = 1:row
        for j = 1:col
            % get the value 
            leftPart = leftImg(i,j);
            % search towards right
            rightPart = rightImg(i, j:j+maxDis);
            % calcuate sum of squared differences
            SSD = (leftPart-rightPart).^2;
            % find the best match
            bestMatch = find(SSD == min(SSD));
            % if there is more than one best result, use the first one
            if (~isempty(bestMatch))
                % if a match is available set the original value to NaN
                disparityMap(i,j) = bestMatch(1);
                rightImg(i,j+bestMatch(1)) = NaN;
            end
        end
    end
end
end