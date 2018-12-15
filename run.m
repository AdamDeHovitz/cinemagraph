%% Estimating Optical Flow
% This example uses the Farneback Method to to estimate the direction and speed of moving
% cars in the video
% Copyright 2018 The MathWorks, Inc.
%% Read the video into MATLAB
%vidreader documentation: https://www.mathworks.com/help/matlab/ref/videoreader.html
vidReader = VideoReader('vid.m4v');
opticFlow = opticalFlowFarneback;
%% Estimate Optical Flow of each frame
meanImage = zeros(vidReader.height, vidReader.width);
i = 0;
while hasFrame(vidReader)
    frameRGB = rgb2gray(im2double(readFrame(vidReader)));
    meanImage = meanImage + frameRGB;
    i = i + 1;
end
vidReader.CurrentTime = 0;
meanImage = meanImage ./ i;
maxDif = zeros(vidReader.height, vidReader.width);
while hasFrame(vidReader)
    frameRGB = rgb2gray(im2double(readFrame(vidReader)));
    frame_dif = abs(meanImage - frameRGB);
    replace = frame_dif > maxDif;
    maxDif(replace) = frame_dif(replace);
end
threshold = mean(maxDif(:)) + std(maxDif(:));
binary = imbinarize(maxDif, threshold);
SE = strel('square',20);
morphed = imclose(binary, SE);
no_circles = 1 - bwareaopen(imcomplement(morphed), 10000);
imshow(no_circles);

