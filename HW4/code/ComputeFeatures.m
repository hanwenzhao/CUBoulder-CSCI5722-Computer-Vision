function features = ComputeFeatures(img)
% Compute a feature vector for all pixels of an image. You can use this
% function as a starting point to implement your own custom feature
% vectors.
%
% INPUT
% img - Array of image data of size h x w x 3.
%
% OUTPUT
% features - Array of computed features for all pixels of size h x w x f
%            such that features(i, j, :) is the feature vector (of
%            dimension f) for the pixel img(i, j, :).

    height = size(img, 1);
    width = size(img, 2);
    grayscale = rgb2gray(img);
    features = zeros(height, width, 11);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                                                                         %
    %                              YOUR CODE HERE                             %
    %                                                                         %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % color features
    features(:,:,1:3) = double(img);
    % loaction features
    features(:,:,4) = repmat(1:width,height,1);
    features(:,:,5) = repmat((1:height)',1,width);
    % image gradient features
    % Gmag, Gdir
    [features(:,:,6),features(:,:,7)] = imgradient(grayscale);
    % edges information
    features(:,:,8) = edge(grayscale);
    % HSV
    features(:,:,9:11) = rgb2hsv(img);
end