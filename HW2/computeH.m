function [Hout,minDis] = computeH(points, n)
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hanwen Zhao
% CSCI 5722
% Assignment 2
% Instructor: Ioana Fleming
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% create container for H and distance
H = zeros(3,3,20);
distance = zeros(20,1);
newP = zeros(n,3);
% repeat for 20 times
for j=1:20
    % select 4 random points
    index = randperm(n,4);
    selectedPoints = points(index,:);
    % for each pair of points, we can have the following matrix
    A = zeros(8,9);
    for i=1:4
        % select current points
        x1 = selectedPoints(i,1);
        y1 = selectedPoints(i,2);
        x2 = selectedPoints(i,3);
        y2 = selectedPoints(i,4);
        % form the matrix
        %A(2*i-1,:) = [0,0,0,-x1,-y1,-1,y2*x1,y2*y1,1];
        %A(2*i,:) = [x1,y1,1,0,0,0,-x2*x1,-x2*y1,-x2];
        A(2*i-1,:,j) = [-x1,-y1,-1,0,0,0,x1*x2,y1*x2,x2];
        A(2*i,:,j) = [0,0,0,-x1,-y1,-1,x1*y2,y1*y2,y2];
    end
    % take the svd of the 8*9 matrix
    [~,~,V] = svd(A(:,:,j));
    % take the last column of V and reshape into 3*3 matrix
    H(:,:,j) = transpose(reshape(V(:,end),[3,3]));
    % calcualte prtojection corrdinates
    for ii=1:n
      newP(ii,:) = H(:,:,j)*[points(ii,1);points(ii,2);1];
      newP(ii,:) = newP(ii,:)/newP(ii,3);
    end
    % calculate distance base on all 10 points
    distance(j) = sum(sqrt(sum((newP(:,1:2)-points(:,3:4)).^2,2)));
end
minDis = min(distance);
% find the index corresponding to minimum distance
index = find(distance==minDis);
Hout = H(:,:,index(1));
end