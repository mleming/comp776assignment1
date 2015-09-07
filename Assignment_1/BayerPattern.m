function [imfinal] = BayerPattern(im)
%% Interpolates a Bater pattern black-and-white image into an RGB image
% Takes a 2D array with pixels arranged such that (1,1) is red, (1,2) is
% green, (1,3) is blue, (1,4) is green, and so on, and performs a linear
% interpolation on this image to make is into an RGB image
h_green = [0    0.25 0    ;...
           0.25 1    0.25 ;...
           0    0.25 0   ];
h_red   = [0.25 0.5  0.25 ;...
           0.5  1    0.5  ;...
           0.25 0.5  0.25];
h_blue  = [0.25 0.5  0.25 ;...
           0.5  1    0.5  ;...
           0.25 0.5  0.25];
GF = zeros(size(im));
GF(1:2:end,2:2:end) = 1;
GF(2:2:end,1:2:end) = 1;
RF = zeros(size(im));
RF(1:2:end,1:2:end) = 1;
BF = zeros(size(im));
BF(2:2:end,2:2:end) = 1;
GC = imfilter(uint8(GF).*im,h_green);
RC = imfilter(uint8(RF).*im,h_red);
BC = imfilter(uint8(BF).*im,h_blue);
imfinal = cat(3, RC, GC, BC);
return;