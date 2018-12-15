%% Estimating Optical Flow
% This example uses the Farneback Method to to estimate the direction and speed of moving
% cars in the video
% Copyright 2018 The MathWorks, Inc.
%% Read the video into MATLAB
%vidreader documentation: https://www.mathworks.com/help/matlab/ref/videoreader.html
vidReader = VideoReader('vid.m4v');
opticFlow = opticalFlowFarneback;
%% Estimate Optical Flow of each frame
ssim_total = zeros(vidReader.height, vidReader.width);
i = 0;
ref = rgb2gray(im2double(readFrame(vidReader)));
while hasFrame(vidReader)
    frameRGB = rgb2gray(im2double(readFrame(vidReader)));
    [~, ssim_map] = ssim(frameRGB, ref);
    ref = frameRGB;
    ssim_total = ssim_total + ssim_map;
    i = i + 1;
end
ssim_final = ssim_total ./ i;


threshold = mean(ssim_final(:));
binary = imbinarize(ssim_final, threshold);
SE = strel('square',20);
morphed = imclose(binary, SE);
no_circles = 1 - bwareaopen(imcomplement(morphed), 10000);
imshow(no_circles);

