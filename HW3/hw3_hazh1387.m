%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hanwen Zhao
% CSCI 5722
% Assignment 3
% Instructor: Ioana Fleming
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reference: https://github.com/christwt/
tic
close all;clc
%% Task #1 Calculate disparity using the SSD algorithm
% read data
load('handshakeStereoParams.mat');
videoFileLeft = 'handshake_left.avi';
videoFileRight = 'handshake_right.avi';
readerLeft = vision.VideoFileReader(videoFileLeft, 'VideoOutputDataType', 'uint8');
readerRight = vision.VideoFileReader(videoFileRight, 'VideoOutputDataType', 'uint8');
frameLeft = readerLeft.step();
frameRight = readerRight.step();
[frameLeftRect, frameRightRect] = ...
    rectifyStereoImages(frameLeft, frameRight, stereoParams);
leftImgGray  = rgb2gray(frameLeftRect);
rightImgGray = rgb2gray(frameRightRect);
%%
% use built-in function to calculate disparity
disparitySSDImg1 = disparity(leftImgGray, rightImgGray);
% call calculateDisparity function
% kernal size 1*1
disparitySSDImg2 = calculateSSD(leftImgGray, rightImgGray, 1, 63);
% kernal size 5*5
disparitySSDImg3 = calculateSSD(leftImgGray, rightImgGray, 5, 63);
% kernal size 11*11
disparitySSDImg4 = calculateSSD(leftImgGray, rightImgGray, 11, 63);
figure
subplot(2,2,1)
imagesc(disparitySSDImg1, [0, 64]);
title('Disparity Map MATLAB')
colormap(gca,jet)
colorbar
pbaspect([1 1 1])
subplot(2,2,2)
imagesc(disparitySSDImg2, [0, 64]);
title('Disparity SSD 1x1')
colormap(gca,jet)
colorbar
pbaspect([1 1 1])
subplot(2,2,3)
imagesc(disparitySSDImg3, [0, 64]);
title('Disparity SSD 5x5')
colormap(gca,jet)
colorbar
pbaspect([1 1 1])
subplot(2,2,4)
imagesc(disparitySSDImg4, [0, 64]);
title('Disparity SSD 11x11')
colormap(gca,jet)
colorbar
pbaspect([1 1 1])

%% Task #2 Calculate disparity using the NCC algorithm
% use built-in function to calculate disparity
disparityNCCImg1 = disparity(leftImgGray, rightImgGray);
% call calculateDisparity function
% kernal size 1*1
disparityNCCImg2 = calculateNCC(leftImgGray, rightImgGray, 3, 63);
% kernal size 5*5
disparityNCCImg3 = calculateNCC(leftImgGray, rightImgGray, 5, 63);
% kernal size 11*11
disparityNCCImg4 = calculateNCC(leftImgGray, rightImgGray, 7, 63);
figure
subplot(2,2,1)
imagesc(disparityNCCImg1, [0, 64]);
title('Disparity Map MATLAB')
colormap(gca,jet)
colorbar
pbaspect([1 1 1])
subplot(2,2,2)
imagesc(disparityNCCImg2, [0, 64]);
title('Disparity NCC 1x1')
colormap(gca,jet)
colorbar
pbaspect([1 1 1])
subplot(2,2,3)
imagesc(disparityNCCImg3, [0, 64]);
title('Disparity NCC 1x1')
colormap(gca,jet)
colorbar
pbaspect([1 1 1])
subplot(2,2,4)
imagesc(disparityNCCImg4, [0, 64]);
title('Disparity NCC 1x1')
colormap(gca,jet)
colorbar
pbaspect([1 1 1])

%% Task #3 Uniqueness constraint
disparity3UNI = calculateUNI(rightImgGray,leftImgGray, 1, 80);
disparity3UNI = imgaussfilt(disparity3UNI, 2);
figure
imagesc(disparity3UNI, [0 64])
title('Unique Constraint')
colormap(gca,jet)
colorbar
pbaspect([1 1 1])
%% Task #4 Generate outliers map
disparitySSDLR = calculateSSD(leftImgGray, leftImgGray, 3, 63);
disparitySSDRL = calculateSSD(fliplr(rightImgGray),fliplr(leftImgGray),3,63);
disparityNCCLR = disparityNCCImg2;
disparityNCCRL = calculateNCC(fliplr(rightImgGray),fliplr(leftImgGray),3,63);
outlinerMap1 =  consistencyCheck(disparitySSDLR, disparitySSDRL, 1);
outlinerMap2 =  consistencyCheck(disparityNCCLR, disparityNCCRL, 1);
%%
figure
subplot(1,2,1)
imshow(outlinerMap1);
title('Outlier Map for SSD (3*3)')
pbaspect([1 1 1])
subplot(1,2,2)
imshow(outlinerMap2);
title('Outlier Map for NCC (3*3)')
pbaspect([1 1 1])

%% Task #5 Compute depth from disparity
disparityMapSSD3 = disparitySSDLR;
disparityMapNCC3 = disparityNCCImg2;
point3DSSD = reconstruction(disparityMapSSD3, stereoParams);
point3DNCC = reconstruction(disparityMapNCC3, stereoParams);
point3DSSD = point3DSSD./1000;
point3DNCC = point3DNCC./1000;
figure
subplot(1,2,1)
imshow(point3DSSD)
title('Depth Matrix for SSD (3*3)')
pbaspect([1 1 1])
subplot(1,2,2)
imshow(point3DNCC)
title('Depth Matrix for NCC (3*3)')
pbaspect([1 1 1])

%% Task #6 Synthetic stereo sequences
% read the image
frameLeft = rgb2gray(imread('frame_1L.png'));
frameRight = rgb2gray(imread('frame_1R.png'));
groundTruth = imread('frame_1LR.png');
disparity6SSD = uint8(calculateSSD(frameRight, frameLeft, 13, 77));
disparity6NCC = uint8(calculateNCC(frameRight, frameLeft, 9, 77));
disparity6UNI = uint8(calculateUNI(frameRight, frameLeft, 1, 80));
disparity6UNI = imgaussfilt(disparity6UNI, 2);
diffSSD = abs(disparity6SSD - groundTruth);
diffNCC = abs(disparity6NCC - groundTruth);
diffUNI = abs(disparity6UNI - groundTruth);
figure
subplot(2,2,1)
imshow(groundTruth)
title('Ground Truth')
pbaspect([1 1 1])
subplot(2,2,2)
imshow(disparity6SSD);
title('SSD')
pbaspect([1 1 1])
subplot(2,2,3)
imshow(disparity6NCC)
title('NCC')
pbaspect([1 1 1])
subplot(2,2,4)
imshow(disparity6UNI)
title('UNI')
pbaspect([1 1 1])
figure
subplot(1,3,1)
histogram(diffSSD)
title('SSD')
ylim([0 10e4])
pbaspect([1 1 1])
subplot(1,3,2)
histogram(diffNCC)
title('NCC')
ylim([0 10e4])
pbaspect([1 1 1])
subplot(1,3,3)
histogram(diffUNI)
title('UNI')
ylim([0 10e4])
pbaspect([1 1 1])
%% Task #7 Dynamic Programming
disparityDP = calculateDisparity(leftImgGray, rightImgGray);
d_color = display_dmap(disparityDP);
imshow(d_color)

