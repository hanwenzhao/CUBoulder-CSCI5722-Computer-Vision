function [outImg] = famousMe(inImg1, inImg2)
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hanwen Zhao
% CSCI 5722
% Assignment 1
% Instructor: Ioana Fleming
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
% get the size of image1(myself)
inImg1 = imread(inImg1);
inImg2 = imread(inImg2);
[m1,n1,~] = size(inImg1);
% convert into grayscale
grayscale = inImg1(:,:,1)*0.299 + inImg1(:,:,2)*0.587 + inImg1(:,:,3)*0.114;
% create a container for binary image
binaryImg = zeros(m1,n1);
% use threshold to convert image to bw image
threshold = 35;
binaryImg(grayscale>=threshold) = 1;
binaryImg(grayscale<threshold) = 0;
% overwrite the output by background image
outImg = inImg2;
% use the binary image as the mask to render the final image
for ii = 1:m1
    for jj = 1:n1
        if binaryImg(ii,jj) == 1
            outImg(ii,jj,:) = inImg1(ii,jj,:);
        end
    end
end
toc
end