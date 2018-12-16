%% Estimating Optical Flow
% This example uses the Farneback Method to to estimate the direction and speed of moving
% cars in the video
% Copyright 2018 The MathWorks, Inc.
%% Read the video into MATLAB
%vidreader documentation: https://www.mathworks.com/help/matlab/ref/videoreader.html
vidReader = VideoReader('vid.m4v');
%opticFlow = opticalFlowFarneback;
%% Estimate Optical Flow of each frame

% alternate is ssim_image
binary = mean_image(vidReader);

SE = strel('square',20);
morphed = imclose(binary, SE);
no_circles = 1 - bwareaopen(imcomplement(morphed), 10000);
imshow(no_circles);
%image that user defines a selection on
selection_image = no_circles ./2 + meanImage ./2;
sound(randn(4096, 1), 8192)
selection = drawassisted();
selection_mask = createMask(selection);
sound(randn(4096, 1), 8192)
