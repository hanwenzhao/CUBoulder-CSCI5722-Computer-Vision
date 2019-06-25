function [outImg] = scaleBilinear(inImg, factor)
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hanwen Zhao
% CSCI 5722
% Assignment 1
% Instructor: Ioana Fleming
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
% get the size of original image
[m,n,~] = size(inImg);
% calculate the new size
newSize = floor([m,n].*factor);
% calculate the sampling size
msample = m/newSize(1);
nsample = n/newSize(2);
% create container for outImg
outImg = zeros(newSize);
% loop through all points
for i = 1:newSize(1)
    x = (msample*i) + 0.5*(1-1/factor);
    for j = 1:newSize(2)
        y = (nsample*j) + 0.5*(1-1/factor);
        if x < 1
            x = 1;
        end
        if x >= m
            x = m - 0.01;
        end
        if y < 1
            y = 1;
        end
        if y >=  n
            y = n - 0.01;
        end
        x1 = floor(x);x2 = x1+1;
        y1 = floor(y);y2 = y1+1;
        % get values
        ulValue = inImg(x1,y1,1:3);
        urValue = inImg(x2,y1,1:3);
        llValue = inImg(x1,y2,1:3); 
        lrValue = inImg(x2,y2,1:3);
        % calculate coefficient
        ulCoeff = (y2-y)*(x2-x);
        urCoeff = (y2-y)*(x-x1);
        llCoeff = (x2-x)*(y-y1);
        lrCoeff = (y-y1)*(x-x1);
        outImg(i,j,1:3) = ulCoeff.*ulValue+urCoeff.*urValue+llCoeff.*llValue...
            +lrCoeff.*lrValue;
    end
end
outImg = uint8(outImg);
toc
end