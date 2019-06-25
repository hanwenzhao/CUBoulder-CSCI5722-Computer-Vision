% This script creates a menu driven application

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hanwen Zhao
% CSCI 5722
% Assignment 1
% Instructor: Ioana Fleming
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;close all;clc;

% Display a menu and get a choice
choice = menu('Choose an option', 'Exit Program', 'Load Image', ...
    'Display Image', 'Mean Filter', 'Gaussian Filter', 'Frosty', ...
    'Scale Nearest', 'Scale Bilinear', 'Swirl Filter', 'Famous Me');  % as you develop functions, add buttons for them here
 
% Choice 1 is to exit the program
while choice ~= 1
   switch choice
       case 0
           disp('Error - please choose one of the options.')
           % Display a menu and get a choice
           choice = menu('Choose an option', 'Exit Program', 'Load Image', ...
    'Display Image', 'Mean Filter', 'Gaussian Filter', 'Frosty', ...
    'Scale Nearest', 'Scale Bilinear', 'Swirl Filter', 'Famous Me');  % as you develop functions, add buttons for them here
        case 2
           % Load an image
           image_choice = menu('Choose an image', 'lena1', 'mandril1', 'sully', 'yoda');
           switch image_choice
               case 1
                   filename = 'lena1.jpg';
               case 2
                   filename = 'mandrill1.jpg';
               case 3
                   filename = 'sully.bmp';
               case 4
                   filename = 'yoda.bmp';
               % fill in cases for all the images you plan to use
           end
           current_img = imread(filename);
       case 3
           % Display image
           figure
           imagesc(current_img);
           if size(current_img,3) == 1
               colormap gray
           end
           
       case 4
           % Mean Filter
           % 1. Ask the user for size of kernel
           prompt = {'Enter kernal size:'};
           dlg_title = 'Input';
           num_lines = 1;
           defaultans = {'3'};
           k_size = inputdlg(prompt,dlg_title,num_lines,defaultans);
           % 2. Call the appropriate function
           newImage = meanFilter(current_img, str2double(k_size{1,1})); % create your own function for the mean filter
           % 3. Display the old and the new image using subplot
           figure
           subplot(1,2,1)
           imagesc(current_img)
           axis image
           subplot(1,2,2)
           imagesc(newImage)
           axis image
           % 4. Save the newImage to a file
           newFileName = strcat('Mean_Filter_',filename);
           imwrite(newImage,newFileName)
              
       case 5
           % Gaussian Filter
           % 1. Ask the user for the sigma
           prompt = {'Enter sigma value:'};
           dlg_title = 'Input';
           num_lines = 1;
           defaultans = {'2'};
           sigma = inputdlg(prompt,dlg_title,num_lines,defaultans);
           % 2. Call the appropriate function
           newImage = gaussFilter(current_img, str2double(sigma{1,1})); % create your own function for the gaussian filter
           % 3. Display the old and the new image using subplot
           figure
           subplot(1,2,1)
           imagesc(current_img)
           axis image
           subplot(1,2,2)
           imagesc(newImage)
           axis image
           % 4. Save the newImage to a file
           newFileName = strcat('Gaussian_Filter_',filename);
           imwrite(newImage,newFileName)
           
        case 6
           % Frosty
           % 1. Ask the user for the sigma
           prompt = {'Enter value n:', 'Enter value m:'};
           dlg_title = 'Input';
           num_lines = 1;
           defaultans = {'3','3'};
           parameters = inputdlg(prompt,dlg_title,num_lines,defaultans);
           % 2. Call the appropriate function
           newImage = frosty(current_img, str2double(parameters{1,1}), ...
               str2double(parameters{2,1})); % create your own function for the frosty filter
           % 3. Display the old and the new image using subplot
           figure
           subplot(1,2,1)
           imagesc(current_img)
           axis image
           subplot(1,2,2)
           imagesc(newImage)
           axis image
           % 4. Save the newImage to a file
           newFileName = strcat('Frosty_',filename);
           imwrite(newImage,newFileName)
           
       case 7
           % Scale Nearest
           % 1. Ask the user for the sigma
           prompt = {'Enter factor value:'};
           dlg_title = 'Input';
           num_lines = 1;
           defaultans = {'2'};
           factor = inputdlg(prompt,dlg_title,num_lines,defaultans);
           % 2. Call the appropriate function
           newImage = scaleNearest(current_img, str2double(factor{1,1})); % create your own function for the gaussian filter
           % 3. Display the old and the new image using subplot
           figure
           subplot(1,2,1)
           imagesc(current_img)
           axis image
           subplot(1,2,2)
           imagesc(newImage)
           axis image
           % 4. Save the newImage to a file
           newFileName = strcat('Scale_Nearest_',filename);
           imwrite(newImage,newFileName)
           
        case 8
           % Scale Bilinear
           % 1. Ask the user for the sigma
           prompt = {'Enter factor value:'};
           dlg_title = 'Input';
           num_lines = 1;
           defaultans = {'2'};
           factor = inputdlg(prompt,dlg_title,num_lines,defaultans);
           % 2. Call the appropriate function
           newImage = scaleBilinear(current_img, str2double(factor{1,1})); % create your own function for the gaussian filter
           % 3. Display the old and the new image using subplot
           figure
           subplot(1,2,1)
           imagesc(current_img)
           axis image
           subplot(1,2,2)
           imagesc(newImage)
           axis image
           % 4. Save the newImage to a file
           newFileName = strcat('Scale_Bilinear_',filename);
           imwrite(newImage,newFileName)
           
       case 9
           % swirl filter
           % 1. Ask the user for the sigma
           prompt = {'Enter value factor:', 'Enter value ox:', 'Enter value oy:'};
           dlg_title = 'Input';
           num_lines = 1;
           defaultans = {'100','250','250'};
           parameters = inputdlg(prompt,dlg_title,num_lines,defaultans);
           % 2. Call the appropriate function
           newImage = swirlFilter(current_img, str2double(parameters{1,1}), ...
               str2double(parameters{2,1}), str2double(parameters{3,1})); % create your own function for the frosty filter
           % 3. Display the old and the new image using subplot
           figure
           subplot(1,2,1)
           imagesc(current_img)
           axis image
           subplot(1,2,2)
           imagesc(newImage)
           axis image
           % 4. Save the newImage to a file
           newFileName = strcat('Swirl_Filter_',filename);
           imwrite(newImage,newFileName)
           
           
       case 10
           % Famous Me
           % 1. Ask the user for the sigma
           % 2. Call the appropriate function
           newImage = famousMe('IMG_1888.JPG','space_sky.jpg'); % create your own function for the gaussian filter
           % 3. Display the old and the new image using subplot
           figure
           imagesc(newImage)
           axis image
           % 4. Save the newImage to a file
           newFileName = strcat('Famous_Me.jpg');
           imwrite(newImage,newFileName)
end
   % Display menu again and get user's choice
   choice = menu('Choose an option', 'Exit Program', 'Load Image', ...
    'Display Image', 'Mean Filter', 'Gaussian Filter', 'Frosty', ...
    'Scale Nearest', 'Scale Bilinear', 'Swirl Filter', 'Famous Me');  % as you develop functions, add buttons for them here
end
