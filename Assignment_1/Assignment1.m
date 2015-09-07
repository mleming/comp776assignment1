% Matthew Leming
% COMP 776, Fall 2015, Jan-Michael Frahm
% UNC-Chapel Hill
% Assignment 1 - Linear interpolation, image alignment
% 

%% Part 1 - Linear Interpolation
% Show the interpolated image
im = imread('crayons_mosaic.bmp');
im = BayerPattern(im);
figure;
imshow(im);
% Sum of squared differences between interpolated and original image
imjpg = imread('crayons.jpg');
[im, mean_error_RC,mean_error_GC,mean_error_BC, max_error_RC,...
    max_error_GC, max_error_BC] = sumOfSquaredDifferences(im,imjpg);
mean_error_RC
mean_error_GC
mean_error_BC
max_error_RC
max_error_GC
max_error_BC
figure;
imshow(im);

%% Part 2 - Image Alignment
% Align the Prokudin-Gorskii Images with normalized cross-correlation
images = cellstr(['data/00125v.jpg';'data/00149v.jpg';'data/00153v.jpg';...
                  'data/00351v.jpg';'data/00398v.jpg';'data/01112v.jpg']);
for i=1:size(images,1)
    image_file = char(images(i));
    im = imread(image_file);
    [im, x_BC, y_BC, x_RC, y_RC ] = alignProkudinGorskiiImage(im,30);
    image_info = strcat([image_file,': blue x offset: ',num2str(x_BC),...
        ', blue y offset: ',num2str(y_BC),', red x offset: ',...
         num2str(x_RC),', red y offset:',num2str(y_RC)]);
    figure;
    image_info
    imshow(im);
end
 
%% Extra Credit - Image Pyramids
% Recursively align higher-resolution images
images = cellstr(['data_hires/01047u.tif';'data_hires/01657u.tif';...
                  'data_hires/01861a.tif']);
for i=1:size(images,1)
    image_file = char(images(i));
    im = imread(image_file);
    [im, x_BC, y_BC, x_RC, y_RC ] = imagePyramidProkudinGorskii(im);
    image_info = strcat([image_file,': blue x offset: ',num2str(x_BC),...
        ', blue y offset: ',num2str(y_BC),', red x offset: ',...
         num2str(x_RC),', red y offset:',num2str(y_RC)]);
    figure;
    image_info
    imshow(im);
end