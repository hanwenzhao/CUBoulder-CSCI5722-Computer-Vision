function [outMat] = getPoints(imgIn1, imgIn2, n)
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hanwen Zhao
% CSCI 5722
% Assignment 2
% Instructor: Ioana Fleming
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% create container to store coordinates
xy1 = zeros(n,2);
xy2 = zeros(n,2);
% loop throught 10 points selection
for i = 1:n
    % display the first image
    imagesc(imgIn1)
    hold on
    % plot the previous points
    plot(xy1(1:i-1,1),xy1(1:i-1,2),'r*')
    title(['Select Point #', num2str(i)])
    % store the current selection
    xy1(i,:) = ginput(1);
    hold off
    % display the second image
    imagesc(imgIn2)
    hold on
    % plot the previous selections
    plot(xy2(1:i-1,1),xy2(1:i-1,2),'r*')
    title(['Select Point #', num2str(i)])
    % store the current selections
    xy2(i,:) = ginput(1);
end
close all
outMat = [fliplr(xy1),fliplr(xy2)];
end