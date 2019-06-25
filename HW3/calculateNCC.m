function [disparityMap] = calculateNCC(leftImg, rightImg, kSize, maxDis)
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hanwen Zhao
% CSCI 5722
% Assignment 3
% Instructor: Ioana Fleming
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% convert into double precision
leftImg = im2double(leftImg);
rightImg = im2double(rightImg);
% get the size of the image
[rows, cols] = size(leftImg);
% allocate memory for output
disparityMap = zeros(rows, cols);
% calculate the offset
offset = (kSize-1)/2;
% pad the array with NaN for easy calculation
pad = NaN(rows, maxDis);
rightImg = [rightImg, pad];
% loop through the image
parfor i = 1+offset: rows-offset
    for j = 1+offset: cols-offset
        % get the current left part value
        leftPart = leftImg(i-offset:i+offset, j-offset:j+offset);
        % calculate mean value
        meanLeft = mean2(leftPart);
        % calculate numerator
        numLeft = leftPart-meanLeft;
        % calculate denominator
        denLeft = sqrt(sum(sum((leftPart-meanLeft).^2)));
        % in case of denominator is equal to 0
        if denLeft == 0
            denLeft = 1;
        end
        % calculate the NCC of left part
        leftPart = numLeft/denLeft;
        leftPart = repmat(leftPart, 1, maxDis);
        % formate the left part
        rightPart = rightImg(i-offset:i+offset, j-offset:j+offset);
        % calculate mean value
        meanRight = mean2(rightPart);
        % calculate denominator
        numRight = rightPart-meanRight;
        denRight = sqrt(sum(sum((rightPart-meanLeft).^2)));
        % in case of denominator is equal to 0
        if denRight == 0
            denRight = 1;
        end
        % calculate the NCC of right part
        rightPart = numRight/denRight;
        % for all disparity range
        for ii = 1:maxDis-1
           kernal = rightImg(i-offset:i+offset, ii+j-offset:ii+j+offset);
           meanKernal = mean2(kernal);
           numKernal = kernal-meanKernal;
           denKernal = sqrt(sum(sum((kernal-meanKernal).^2)));
           if denKernal == 0
               denKernal = 1;
           end
           kernal = numKernal/denKernal;
           rightPart = [rightPart, kernal];
        end
        % calculate the final NCC value
        NCC = leftPart.*rightPart;
        % reshape the NCC value
        NCC = reshape(NCC, kSize.^2, maxDis);
        % sum for each disparity
        NCC = sum(NCC);
        % find the best match
        bestMatch = find(NCC == max(NCC));
        % if more than one best match is found, use the first one
        disparityMap(i, j) = bestMatch(1);
    end
end
end