function [ imfinal, x_BC, y_BC, x_RC, y_RC ] = alignProkudinGorskiiImage( im,radius )
%% Aligns the components of a Prokudin-Gorskii image to an RGB image
% Takes in a black-and-white 2D array (a Prokudin-Gorsii image), divides it
% into three parts, and overlays these three parts according via normalized
% cross-correlation.
%
% im: Black and white Prokudin-Gorskii image - I.E., a black-and-white
%     image that is approximately divided vertically in three parts, with
%     the top being blue, the middle being green, and the bottom being red.
% radius: The radius of the square search window to be used in aligning the
%     red and blue components to the green component. Optional - a default
%     is selected if it is not supplied
%
% imfinal: Aligned RGB image of approximately 1/3 the height of im
%     Detailed explanation goes here
% x_BC, y_BC, x_RC, y_RC: Offsets used for the red and blue components when
%     aligning to the green. Used mainly in the recursive implementation of
%     this function.
if ~exist('radius','var')
   radius = 15; 
end

[BC,GC,RC] = cutImageThreeWaysVertical(im);
dims= size(GC);
length = dims(1);
width  = dims(2);
BC_subimage =  BC(round(length/2 - radius):...
                  round(length/2 + radius),...
                  round(width/2  - radius): ...
                  round(width/2  + radius));
RC_subimage =  RC(round(length/2 - radius):...
                  round(length/2 + radius),...
                  round(width/2  - radius): ...
                  round(width/2  + radius));
BC_corr = normxcorr2(BC_subimage,GC);
RC_corr = normxcorr2(RC_subimage,GC);
BC_corr = BC_corr(radius:end-radius-1,radius:end-radius-1);
RC_corr = RC_corr(radius:end-radius-1,radius:end-radius-1);

% Find the x and y of the max value in BC_corr and RC_corr (this was the
% best way I could find to do it)
maxcorrBC = 0;
maxcorrRC = 0;
x_BC = 0;
x_RC = 0;
y_RC = 0;
y_BC = 0;
for x=1:size(BC_corr,1)
    for y=1:size(BC_corr,2)
        if BC_corr(x,y) > maxcorrBC
            maxcorrBC = BC_corr(x,y);
            x_BC = x;
            y_BC = y;
        end
        if RC_corr(x,y) > maxcorrRC
            maxcorrRC = RC_corr(x,y);
            x_RC = x;
            y_RC = y;
        end
    end
end
x_BC = floor(x_BC - length/2);
y_BC = floor(y_BC - width/2);
x_RC = floor(x_RC - length/2);
y_RC = floor(y_RC - width/2);
imfinal =alignThreeImages(GC,RC,x_RC,y_RC,BC,x_BC,y_BC);
return;

