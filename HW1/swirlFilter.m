function [outImg] = swirlFilter(inImg, factor, ox, oy)
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hanwen Zhao
% CSCI 5722
% Assignment 1
% Instructor: Ioana Fleming
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
% get the size of input image
[m,n,~] = size(inImg);
outImg = zeros(m,n,3);
% create container for the new coordinates
xx = zeros(m,n);
yy = zeros(m,n);
% go through all points
for i=1:m
    % offset the center of the rotation
    x=i-ox-factor;
    for j=1:n
        y=j-oy+factor;
        % transform cartesian coordinates to polar
        [r,theta]=myOwnCart2Polar(x,y);
        phi=theta+r/factor;
        % transform polar coordinates to cartesian
        [newX,newY]=myOwnPolar2Cart(r,phi);
        % add the center of location back
        xx(i,j)=ceil(newX)+ox;
        yy(i,j)=ceil(newY)+oy;
    end
end

% check any inappropriate value
xx=max(xx,1); xx=min(xx,m);
yy=max(yy,1); yy=min(yy,n);
% loop throught the final image and inverse mappoing
for i=1:size(inImg,1)
    for j=1:size(inImg,2)
        outImg(i,j,:)=inImg(xx(i,j),yy(i,j),:);
    end
end
% convert into uint8
outImg = uint8(outImg);
toc
end


