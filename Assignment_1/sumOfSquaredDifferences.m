function [sum_arr, mean_error_RC,mean_error_GC,mean_error_BC, max_error_RC, max_error_GC, max_error_BC] = sumOfSquaredDifferences(arr1, arr2)
    RC = abs(arr1(:,:,1) - arr2(:,:,1));
    mean_error_RC = sum(RC(:))/size(RC(:),1);
    max_error_RC = max(RC(:));
    GC = abs(arr1(:,:,2) - arr2(:,:,2));
    mean_error_GC = sum(GC(:))/size(GC(:),1);
    max_error_GC = max(GC(:));
    BC = abs(arr1(:,:,3) - arr2(:,:,3));
    mean_error_BC = sum(BC(:))/size(BC(:),1);
    max_error_BC = max(BC(:));

    sum_arr = sum(arr1.^2 - arr2.^2,3);
return;
