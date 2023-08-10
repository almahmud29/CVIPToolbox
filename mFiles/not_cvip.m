function not = not_cvip(a)
% NOT_CVIP - Performs logical NOT operation on input image.
%
% Syntax :
% --------
%  Z = not_cvip(X) 
%  
% performs bitwise NOT on each element in array X and returns the result of 
% bitwise NOT operation in the corresponding element of the output array Z.
%
%  X   -   Input image. 
%  Z   -   Output image.
%
% Z is an array of type uint8 or uint16 depending upon the input X. 
%                 
% Example :
% -------
%   Performs bitwise NOT operation on input image:
%
%                   X = imread('Cam.bmp');
%                   S = not_cvip(X);
%                   figure;imshow(S,[]);
%
%   See also, xor_cvip, and_cvip, or_cvip
%
%
% Reference
% ---------
% 1. Scott E Umbaugh. DIGITAL IMAGE PROCESSING AND ANALYSIS: Applications
% with MATLAB and CVIPtools, 3rd Edition.

%==========================================================================
%
%           Author:                 Deependra Mishra
%           Initial coding date:    03/17/2017
%           Updated by:             Julian Rene Cuellar Buritica
%           Latest update date:     05/24/2019
%           Credit:                 Scott Umbaugh 
%                                   CVIP Lab, SIUE
%           Copyright (C) 2018 Scott Umbaugh and SIUE
%
%==========================================================================

% Revision History
%
 % Revision 1.2  01/09/2019  15:21:14  jucuell
 % updating function documentation and removing unncesary control
 % characters in statements like commas and semicolons.
%
 % Revision 1.1  03/17/2017  15:23:31  jucuell
 % Initial coding and testing.
%

%------------------------------------------------------------------------

% Checking number of input arguments
%     narginchk(2,2); % using if else is faster
    if nargin<1
        error('Too few arguements for not_cvip');
    elseif nargin>1
        error('Too many arguements for not_cvip');
    end
%----------------------------------------------------------------
% Checking data type of input image and converting to type uint8 if
% necessary    
    if isa(a,'double') && (max(max(max(a)))<=255)
        a=uint8(a);
    elseif isa(a,'double') && (max(max(max(a)))>=255)
        a=uint16(a);
    end
%-------------------------------------------------------------------
% Performing NOT operation on images     
    not = bitcmp(a);
end