function [ imfinal ] = cropImage( im )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
RC = im(:,:,1);
GC = im(:,:,2);
BC = im(:,:,3);
RC = sumOfSquaredDifferences(double(RC),double(GC));
BC = sumOfSquaredDifferences(double(RC),double(BC));
BC = uint8(BC/max(BC(:))*255);
%BC = edge(BC,'Prewitt');
imfinal = BC;
clear sum;
for x=1:5
    sum(sum(BC(:,x:x+2)))
    if sum(sum(BC(:,x:x+2))) > 40
        BC = BC(:,3:end);
        im = im(:,3:end,:);
    end
    sum(sum(BC(:,end-x-3:end-x-1)))
    if sum(sum(BC(:,end-x-3:end-x-1))) > 40
        BC = BC(:,1:end-2);
        im = im(:,1:end-2,:);
    end
    sum(sum(BC(x:x+2,:)))
    if sum(sum(BC(x:x+2,:))) > 40
        BC = BC(x:end,:);
        im = im(x:end,:,:);
    end
    sum(sum(BC(end-x-3:end-x-1,:)))
    if sum(sum(BC(end-x-3:end-x-1,:))) > 40
        BC = BC(x:end,:);
        im = im(x:end,:,:);
    end

end

imfinal = im;

end

