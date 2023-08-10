  
 I = imread('butterfly.tif');    %original image
                  O = hist_thresh_cvip(I,0,1);
                  imshow(uint8(O));
                  
                  
                  
                  % WHY?