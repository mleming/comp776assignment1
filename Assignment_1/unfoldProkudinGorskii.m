function [ imfinal ] = unfoldProkudinGorskii( im )
%% Turns an RGB image into a black-and-white Prokudin-Gorskii image
imfinal = cat(1,im(:,:,3),im(:,:,2),im(:,:,1));

end

