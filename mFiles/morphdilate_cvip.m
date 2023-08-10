function [outImage, kernel] = morphdilate_cvip(inImage, kType, kSize, kArgs)
% MORPHDILATE_CVIP - Perform morphological dilation of a grayscale or color image.
% The function performs morphological dilation of a grayscale image.The 
% user can specify the kernel and its parameters,otherwise the default 
% kernel and kernel parameters are selected.
%
% Syntax :
% ------
% [outImage, struct_el] = morphdilate_cvip(inImage, kType, kSize, kArgs)
%    
% Input Parameters include :
% ------------------------
%   'inImage'       1-band or 3-band image of MxN size. 
%
%   'kType'         Kernel or Structure Elements type.
%                   kType = 1 ----> disk 
%                   kType = 2 ----> square 
%                   kType = 3 ----> rectangle 
%                   kType = 4 ----> cross
%                                                              (default: 2)
%
%   'kSize'         Size of Kernel or Structure Elements. Kernel will
%                   a square matrix of K*K, where K = kSize. kSize must be
%                   positive odd integer (1,3,5, and so on). 
%                                                              (default: 3)
%
%   'kArgs'         Kernel arguments. The number of arguments vary with the
%                   kernel type. Any argument must be positive odd integer 
%                   (1,3,5, and so on)    
%                     'disk' kernel, no arguments, i.e. kArgs = []
%                     'square' kernel, one argument (width) 
%                           i.e. kArgs = width
%                                                          (default: kSize)
%                     'rectangle' kernel, two arguments (width & height) 
%                           i.e. kArgs(1) = width
%                                kArgs(2) = height       
%                                                (default: [kSize kSize-2])
%                     'cross' kernel, two arguments (thickness & cross size) 
%                           i.e. kArgs(1) = thickness
%                                kArgs(2) = cross size
%                                                    (default: [1 kSize-2])
%
%
% Output Parameter include :  
% ------------------------
%   'outImage'      Output image of Morphological dilation. It is of double
%                   class.
%                   (Note: Remap or divide by constant C before displaying 
%                   it, for 8-bit image, C = 255).
%           
%   'struct_el'     Kernel or Structuring element matrix of K*K size. 
%
%
% Example 1 :
% ---------
%     %Perform dilation using default parameters and get only ouput image
%       I = imread('cam.bmp');         %original image
%       O1 = morphdilate_cvip(I);      %Square kernel with size 3           
%       figure;imshow(O1,[]);
% Example 2 :
% ---------
%     %Perform dilation using user specified parameters and get two 
%       %outputs (output image and kernel)
%       I = imread('Binary.jpg');          %original image
%       [O2, kernel] = morphdilate_cvip(I,3,5,[5 3]); %5*5 rectangle kernel
%                            %with rectangle width 5 and rectangle height 3     
%       figure;imshow(O2,[]);
% Reference
% ---------
% 1. Scott E Umbaugh. DIGITAL IMAGE PROCESSING AND ANALYSIS: Applications with MATLAB and CVIPtools, 3rd Edition.

%==========================================================================
%
%           Author:                 Norsang Lama
%           Initial coding date:    5/27/2017
%           Latest update date:     6/1/2017
%           Credit:                 Scott Umbaugh 
%                                   CVIP Lab, SIUE
%           Copyright (C) 2017 Scott Umbaugh and SIUE
%
%==========================================================================

%check number of input and output arguments
if nargin ~= 1 && nargin ~= 2 && nargin ~= 3  && nargin ~= 4  
    error('Too many or too few input arguments!')
end
if nargout ~= 0 && nargout ~= 1 && nargout ~= 2
    error('Too many or too few output arguments!')
end

%check if kernel arguments are existed
% default values are set-up inside structel_cvip function
if ~exist('kType','var') 
    kType = [];
end
if ~exist('kSize','var')  
    kSize = [];
end
if ~exist('kArgs','var')  
   kArgs = [];
end

%create structuring element or kernel
kernel = structel_cvip(kType, kSize, kArgs);

%centers of structuring element or kernel
centr_loc = ceil(kSize/2);

%output image
inImage = double(inImage);
outImage = inImage;

%Perform Morphological Dilation
[nrow, ncol, nband] = size(inImage);

for r = -(centr_loc-1) : centr_loc -1
    for c = -(centr_loc - 1) : centr_loc - 1  
        %fprintf('\n\tr = %d c = %d', r + centr_r,c + centr_c)
        
        %if kernel element is 1, update the result image with new max value
        %if kernel element is 0, no change     
        if kernel(r + centr_loc, c + centr_loc) == 1
            if r < 0
                temp2 = [zeros(-r, ncol, nband); inImage(1:end+r,:,:)];
            elseif r > 0
                temp2 = [inImage(1+r:end,:, :); zeros(r,ncol, nband)];
            else
                temp2 = inImage;
            end

            if c < 0
                temp2 = [zeros(nrow,-c, nband) temp2(:, 1:end+c, :)]; 
            elseif c > 0
                temp2 = [temp2(:, 1+c:end, :) zeros(nrow,c,nband)];
            end
            
            %find the maximum
            outImage = max(outImage, temp2);    
            %outImage = outImage.*(outImage>temp2)+ temp2.*(temp2>outImage);
        end
        
       
    end
end

end

