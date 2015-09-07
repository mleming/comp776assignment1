function [ imfinal ] = alignThreeImages( im1, im2, im2_x_offset,im2_y_offset, im3, im3_x_offset,im3_y_offset)
%% Aligns two images onto a third image according to specified offsets
%   This takes in an image template (im1) and two images to be aligned to
%   it (im2, im3) and overlays them to make a 3D array (usually an RGB
%   image). This function does not pad the sides of any of the images, but,
%   rather, crops them according to the offsets, so that the only output
%   image to be viewed will be the areas in which im1, im2, and im3
%   overlap. It is expected that im1, im2 and im3 are the same size,
%   and that the offsets are not bigger than any of the respective image
%   dimensions.
%
%      im1: Image template  (Green)
%      im2: First image to be aligned (Red)
%      im3: Second image to be aligned (Blue)
%      im2_x_offset,im2_y_offset,im3_x_offset,im3_y_offset: offsets for im2
%          and im3 to template image
%
%      imfinal: The output image (RGB)


%Align im2 to im1
if im2_x_offset > 0
   im1 = im1(im2_x_offset+1:end,:);
   im2 = im2(1:end-im2_x_offset,:);
else
   im2 = im2(1-im2_x_offset:end,:);
   im1 = im1(1:end+im2_x_offset,:);
end
if im2_y_offset > 0
   im1 = im1(:,im2_y_offset+1:end);
   im2 = im2(:,1:end-im2_y_offset);
else
   im2 = im2(:,1-im2_y_offset:end);
   im1 = im1(:,1:end+im2_y_offset);
end

% Make the x and y offsets for im3 account for the cropping that just
% happened to im1 and im2
im3_x_offset = im3_x_offset - im2_x_offset;
im3_y_offset = im3_y_offset - im2_y_offset;


% Align im3 to im1 and im2
 if im3_x_offset > 0
    im1 = im1(im3_x_offset+1:end,:);
    im2 = im2(im3_x_offset+1:end,:);

    im3 = im3(1:end-im3_x_offset,:);
 else
    im3 = im3(1-im3_x_offset:end,:);

    im1 = im1(1:end+im3_x_offset,:);
    im2 = im2(1:end+im3_x_offset,:);
 end
 if im3_y_offset > 0    
    im2 = im2(:,im3_y_offset+1:end);
    im1 = im1(:,im3_y_offset+1:end);
    
    im3 = im3(:,1:end-im3_y_offset);
 else
    im1 = im1(:,1:end+im3_y_offset);
    im2 = im2(:,1:end+im3_y_offset);
    
    im3 = im3(:,1-im3_y_offset:end);
 end


% Crop the images further so as to make their dimensions equal
im1 = im1(1:min([size(im2,1),size(im3,1),size(im1,1)]),...
          1:min([size(im2,2),size(im3,2),size(im1,2)]));
im2 = im2(1:min([size(im2,1),size(im3,1),size(im1,1)]),...
          1:min([size(im2,2),size(im3,2),size(im1,2)]));
im3 = im3(1:min([size(im2,1),size(im3,1),size(im1,1)]),...
          1:min([size(im2,2),size(im3,2),size(im1,2)]));

imfinal = cat(3, im2, im1, im3);

end