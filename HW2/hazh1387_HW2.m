%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hanwen Zhao
% CSCI 5722
% Assignment 2
% Instructor: Ioana Fleming
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;clc;

%% Task #1 Getting Correspondences
% read image into matrix
img1 = imread('uttower1.JPG');
img2 = imread('uttower2.JPG');
% call getPoints function to get corresponding points
points = getPoints(img1, img2, 10);
%% Task #2 Computing bh Homography Parameters
[H, minDis] = computeH(points, 10);
%% Task #3 Warping Between Image Planes
warpedImg = warp1(H,img1);
imshow(warpedImg)
%% Task #4 Create the Output Mosaic
newImg = uint8(zeros(3000,3000,3));
sizeImg1 = size(img1);
sizeImg2 = size(img2);
sizeWarped = size(warpedImg);
imagesc(warpedImg)
hold on
title(['Select A Point in Image 1'])
% store the current selection
xy1 = ginput(1);
hold off
figure
% display the second image
imagesc(img2)
hold on
title(['Select Cooresponding Point on Image 2'])
xy2 = ginput(1);
close all
offsetX1 = 450;
offsetY1 = 10;
offsetX2 = 450 + round(xy1(1) - xy2(1));
offsetY2 = 10 + round(xy1(2) - xy2(2));
newImg(offsetX2:offsetX2+sizeWarped(1)-1,offsetY2:offsetY2+sizeWarped(2)-1,:) = warpedImg;
newImg(offsetX1:offsetX1+sizeImg2(1)-1,offsetY1:offsetY1+sizeImg2(2)-1,:) = img2;
% Plot in subplots
subplot(2,2,1)
imshow(img1)
title('Original Image 1')
subplot(2,2,2)
imshow(img2)
title('Original Image 2')
subplot(2,2,3)
imshow(warpedImg)
title('Warped Image')
subplot(2,2,4)
imshow(newImg)
title('Image Mosaic')
axis([200 1500 300 1200])
hold off

%% Task 5 Example 1
% read image into matrix
img3 = imread('IMG_2015.JPG');
img4 = imread('IMG_2014.JPG');
% call getPoints function to get corresponding points
points2 = getPoints(img3, img4, 10);
[H2, minDis2] = computeH(points2, 10);
warpedImg2 = warp1(H2,img3);
imshow(warpedImg2)
newImg2 = uint8(zeros(3000,3000,3));
sizeImg3 = size(img3);
sizeImg4 = size(img4);
sizeWarped2 = size(warpedImg2);
figure
imagesc(warpedImg2)
hold on
title('Select A Point in Image 1')
% store the current selection
xy3 = ginput(1);
hold off
figure
% display the second image
imagesc(img4)
hold on
title(['Select Cooresponding Point on Image 2'])
xy4 = ginput(1);
close all
% use the offset to ensure indices are positive
offsetX3 = 450;
offsetY3 = 100;
offsetX4 = 450+ round(xy3(1) - xy4(1));
offsetY4 = 100 +round(xy3(2) - xy4(2));
newImg2(offsetX4:offsetX4+sizeWarped2(1)-1,offsetY4:offsetY4+sizeWarped2(2)-1,:) = warpedImg2;
newImg2(offsetX3:offsetX3+sizeImg4(1)-1,offsetY3:offsetY3+sizeImg4(2)-1,:) = img4;
% Plot in subplots
subplot(2,2,1)
imshow(img3)
title('Original Image 1')
subplot(2,2,2)
imshow(img4)
title('Original Image 2')
subplot(2,2,3)
imshow(warpedImg2)
title('Warped Image')
subplot(2,2,4)
imshow(newImg2)
title('Image Mosaic')
axis([500 1500 500 1200])
hold off

%% Task5 Example 2
% read image into matrix
img5 = imread('IMG_2021.JPG');
img6 = imread('IMG_2020.JPG');
% call getPoints function to get corresponding points
points3 = getPoints(img5, img6, 10);
[H3, minDis3] = computeH(points3, 10);
warpedImg3 = warp1(H3,img5);
imshow(warpedImg3)
newImg3 = uint8(zeros(3000,3000,3));
sizeImg5 = size(img5);
sizeImg6 = size(img6);
sizeWarped3 = size(warpedImg3);
figure
imagesc(warpedImg3)
hold on
title('Select A Point in Image 1')
% store the current selection
xy5 = ginput(1);
hold off
figure
% display the second image
imagesc(img6)
hold on
title(['Select Cooresponding Point on Image 2'])
xy6 = ginput(1);
close all
offsetX5 = 450;
offsetY5 = 100;
offsetX6 = 450+ round(xy5(1) - xy6(1));
offsetY6 = 100 + round(xy5(2) - xy6(2));
newImg3(offsetX6:offsetX6+sizeWarped3(1)-1,offsetY6:offsetY6+sizeWarped3(2)-1,:) = warpedImg3;
newImg3(offsetX5:offsetX5+sizeImg5(1)-1,offsetY5:offsetY5+sizeImg5(2)-1,:) = img6;
% Plot in subplots
subplot(2,2,1)
imshow(img5)
title('Original Image 1')
subplot(2,2,2)
imshow(img6)
title('Original Image 2')
subplot(2,2,3)
imshow(warpedImg3)
title('Warped Image')
subplot(2,2,4)
imshow(newImg3)
title('Image Mosaic')
axis([200 1500 500 1200])
hold off

%% Task5 Example 3
% read image into matrix
img7 = imread('uttower1.JPG');
img8 = imread('IMG_2022.JPG');
% call getPoints function to get corresponding points
points4 = getPoints(img7, img8, 4);
[H4, minDis4] = computeH(points4, 4);
newImg4 = img8;
sizeImg7 = size(img7);
sizeImg8 = size(img8);
for i=1:sizeImg7(1)
    for j=1:sizeImg7(2)
        % use forward method
        pos = H4*[i;j;1];
        x = round(pos(1)/pos(3));
        y = round(pos(2)/pos(3));
        newImg4(x,y,:) = img7(i,j,:);
    end
end
imshow(newImg4)
