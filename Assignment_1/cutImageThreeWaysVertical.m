function [ im_top,im_mid,im_bottom ] = cutImageThreeWaysVertical( im )
%% Cuts an image into vertical thirds
dims = size(im);
length = dims(1);
length_of_subimage = floor(length/3);
im_top = im(1:length_of_subimage,:);
im_mid = im(length_of_subimage+1:2*length_of_subimage,:);
im_bottom = im(2*length_of_subimage + 1:3*length_of_subimage,:);


end

