function [ imfinal, x_BC, y_BC, x_RC, y_RC, radius ] = imagePyramidProkudinGorskii( im, radius )
%% Aligns large-scale Prokudin-Gorskii images
% This function uses recursion to take in a high-resolution
% Prokudin-Gorskii image and align its components. This function makes
% recursive calls to itself, resizing the image by a constant scaling
% factor until it is within a certain resolution. Then, it aligns the
% lower-resolution version of the image. This alignment is performed to the
% image in the next level of recursion up; a section of the middle of the
% aligned version of this image is then aligned, and the results of this
% alignment are added to the one from the level below.

% im: Prokudin-Gorskii black and white image
%
% imfinal: Aligned RGB image
% x_BC, y_BC, x_RC, y_RC: Offsets used for the red and blue components when
%     aligning to the green.
% radius: Radius of window used in normxcorr2 alignment. Default

if ~exist('radius','var')
   radius = 35; 
end
scale = 0.5;
size_image = 400;
[BC,GC,RC] = cutImageThreeWaysVertical(im);
im = cat(3,RC,GC,BC);
if size(im,1) > size_image*2
    im_resized = unfoldProkudinGorskii(imresize(im, scale));
    [~,x_BC, y_BC, x_RC, y_RC, radius] =...
        imagePyramidProkudinGorskii(im_resized,radius);
    x_BC = floor(x_BC/scale);
    y_BC = floor(y_BC/scale);
    x_RC = floor(x_RC/scale);
    y_RC = floor(y_RC/scale);
    BC = im(:,:,3);
    GC = im(:,:,2);
    RC = im(:,:,1);
    imfinal = alignThreeImages(GC,RC,x_RC,y_RC,BC,x_BC,y_BC);
    dims = size(imfinal);
    len = dims(1);
    wid = dims(2);
    image_section = imfinal(...
         floor((len - size_image)/2):floor((len + size_image)/2),...
         floor((wid - size_image)/2):floor((wid + size_image)/2),:);
    produkin_gorskii = unfoldProkudinGorskii(image_section);
    [ ~, x_BC2, y_BC2, x_RC2, y_RC2 ] = ...
        alignProkudinGorskiiImage( produkin_gorskii, radius );
    x_BC = x_BC + x_BC2;
    y_BC = y_BC + y_BC2;
    x_RC = x_RC + x_RC2;
    y_RC = y_RC + y_RC2;
    imfinal = alignThreeImages(GC,RC,x_RC,y_RC,BC,x_BC,y_BC);
else
    [ imfinal, x_BC, y_BC, x_RC, y_RC ] = ...
        alignProkudinGorskiiImage( unfoldProkudinGorskii(im), radius );
end

end