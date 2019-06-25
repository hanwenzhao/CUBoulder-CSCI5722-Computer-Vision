function [ outImg ] = gaussFilter( inImg, sigma)
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hanwen Zhao
% CSCI 5722
% Assignment 1
% Instructor: Ioana Fleming
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
% get the size of the input image
[m,n,~] = size(inImg);
kernal_size = 2 * ceil(2 * sigma) + 1;
% create an empty image for padding
padding_size = fix(kernal_size/2);
% create a paded array
processImg = double(padarray(double(inImg),[padding_size,padding_size],NaN));
outImg = zeros(m,n,3);
% Generate the G matrix
G = zeros(kernal_size,kernal_size);
for x = -padding_size:padding_size
    for y = -padding_size:padding_size
        G(x+padding_size+1,y+padding_size+1) = exp(-(x^2+y^2)/(2*sigma^2))/(2*pi*sigma^2);
    end
end
% loop through the image
for i = padding_size+1:m+padding_size
    for j = padding_size+1:n+padding_size
        outImg(i-padding_size,j-padding_size,1:3) = nansum(nansum(G.*double(processImg...
            (i-padding_size:i+padding_size,j-padding_size:j+padding_size,1:3))));
    end
end
outImg = uint8(outImg);
toc
end