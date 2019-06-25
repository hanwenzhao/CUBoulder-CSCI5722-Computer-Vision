function [disparityMap] = calculateSSD(leftImg, rightImg, kSize, maxDis)
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
            disparityMap(i,j) = bestMatch(1);
        end
    end
end

% for larger kernal size
if kSize > 1
    parfor i = 1+offset:row-offset
        for j = 1+offset:col-offset
            % format the left part
            leftPart = leftImg(i-offset:i+offset,j-offset:j+offset);
            leftPart = repmat(leftPart,1,maxDis);
            % format the right part
            rightPart = rightImg(i-offset:i+offset,j-offset:j+offset);
            % loop through towards right
            for ii = 1:maxDis-1
               rightPart = [rightPart, rightImg(i-offset:i+offset,j+ii-offset:j+ii+offset)];
            end
            % calculate squared difference
            SSD = (leftPart-rightPart).^2;
            % apply gaussian filter
            %SSD = imgaussfilt(SSD, 'FilterSize', kSize);
            % resize SSD matrix
            SSD = reshape(SSD, kSize^2, maxDis);
            % sum of squared difference
            SSD = sum(SSD);
            % find the lowest score
            bestMatch = find(SSD == min(SSD));
            % if we have more than one best match, use the first one
            disparityMap(i, j) = bestMatch(1); 
        end
    end
end
end