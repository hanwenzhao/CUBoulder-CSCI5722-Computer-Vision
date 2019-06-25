function [outImg] = scaleNearest(inImg, factor)
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hanwen Zhao
% CSCI 5722
% Assignment 1
% Instructor: Ioana Fleming
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
% get the size of original image
[m,n,~] = size(inImg);
% calculae the new image size
newSize = floor([m,n].*factor);
% calculate the index matrix
mm = round(((1:newSize(1))-0.5)./factor+0.5);
nn = round(((1:newSize(2))-0.5)./factor+0.5);
% map to the new image
outImg = inImg(mm,nn,:);
toc
end