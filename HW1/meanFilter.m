function [outImg] = meanFilter( inImg, kernal_size)
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hanwen Zhao
% CSCI 5722
% Assignment 1
% Instructor: Ioana Fleming
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
% get the size of the input image
[m,n,~] = size(inImg);
% create an empty image for padding
padding_size = fix(kernal_size/2);
% create a paded array
processImg = padarray(double(inImg),[padding_size,padding_size],NaN);
outImg = uint8(zeros(m,n,3));
% loop through the image
for i = padding_size+1:m+padding_size
    for j = padding_size+1:n+padding_size
        outImg(i-padding_size,j-padding_size,1:3) = nanmean(nanmean(processImg...
           (i-padding_size:i+padding_size,j-padding_size:j+padding_size,1:3)));
    end
end
toc
end