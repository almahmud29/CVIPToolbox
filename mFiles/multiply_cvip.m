function mul = multiply_cvip(a,b)
% MULTIPLY_CVIP - Multiply two images or multiply  an image by aconstant .
%   
% Syntax :
% -------
% Z = multiply_cvip(X,Y) 
%
% multiply each element in array X by the corresponding 
% element in array Y and returns the result of multiplication in the corresponding 
% element of the output array Z.If one of the input parameter is
% constant, multiply the constant value to each element in array of 
% another input image.
%
% Input Parameters include :
% ------------------------
%   'X'      First input image or constant value 
%   'Y'      Second input image or constant value
%
% Output parameter include :
% ------------------------
%   'Z'      Output image.
%
%   Z is an array of type double.
%
%   If X and Y are numeric arrays of the different size, smaller size 
%   arrays are zero padded and multiplication is performed.
%  
%   To view the 8-bit image of type double, divide by 255.
%   To view the 16-bit image of type double, divide by 65535.
%                 
% Example 1 :
% ---------
%   Multiply two images together:
%
%                   X = imread('Cam.bmp');
%                   Y = imread('Car.bmp');
%                   S = multiply_cvip(X,Y);
%                   figure;imshow(S/65535);
%
% Example 2 :
% ---------
%   Multiply image by a constant:
%
%                   X = imread('Cam.bmp');
%                   Y = 50;
%                   S = multiply_cvip(X,Y);
%                   figure;imshow(S,[]);
%
%
%   See also, add_cvip, subtract_cvip, divide_cvip
%
% Reference
% ---------
% 1. Scott E Umbaugh. DIGITAL IMAGE PROCESSING AND ANALYSIS: Applications with MATLAB and CVIPtools, 3rd Edition.

%==========================================================================
%
%           Author:                 Deependra Mishra
%           Initial coding date:    03/17/2017
%           Latest update date:     03/17/2017
%           Credit:                 Scott Umbaugh 
%                                   CVIP Lab, SIUE
%           Copyright (C) 2017 Scott Umbaugh and SIUE
%
%==========================================================================

%------------------------------------------------------------------------

% Checking number of input arguments    
    if nargin<2,
        error('Too few arguements for multiply_cvip');
    elseif nargin>2,
        error('Too many arguements for multiply_cvip');
    end;
%----------------------------------------------------------------
% Checking data type of input image and converting to type double if
% necessary    
    if ~isa(a,'double')
        a=double(a);
    end
    
    if ~isa(b,'double')
        b=double(b);
    end
%-------------------------------------------------------------------

%----------Logic to support different input image type
%     if isa(a,'uint8') && isa(b,'uint16')
%         a= uint16(a);
%     elseif isa(a,'uint16') && isa(b,'uint8')
%         b=uint16(b);
%     elseif isa(a,'uint8') && isa(b,'double')
%         a=double(a);
%     elseif isa(a,'double') && isa(b,'uint8')
%         b=double(b);
%     elseif isa(a,'double') && isa(b,'uint16')
%         a=uint16(a);
%     elseif isa(a,'uint16') && isa(b,'double')
%         b=uint16(b);  
%     end;
%------------------------------------------------------------------------    
    if numel(a)==1 || numel(b)==1,
        mul = a.*b;

    else

% Checking the size of images and making same size by zero padding if
% necessary      
        if size(a,3)>size(b,3)
            b=cat(3,b,b,b);
           %b=repmat(b,[1 1 3]);
        elseif size(b,3)>size(a,3)
            a=cat(3,a,a,a);
        else
        end
        if size(a,2)>size(b,2)
            if size(a,1)>size(b,1)
                %c = zeros(size(a));
                b(end+size(a,1)-size(b,1),end+size(a,2)-size(b,2),1)=0;
            else
                a(end+size(b,1)-size(a,1),end,1)=0;
                b(end,end+size(a,2)-size(b,2),1)=0;
            end
        else
            if size(a,1)<size(b,1)
                a(end+size(b,1)-size(a,1),end+size(b,2)-size(a,2),1)=0;
            else
                a(end+size(a,1)-size(b,1),end,1)=0;
                b(end,end+size(b,2)-size(a,2),1)=0;
            end
        end
%-------------------------------------------------------------------
% Performing multipy operation on images    
        mul = a .* b;
    
    end
    
end