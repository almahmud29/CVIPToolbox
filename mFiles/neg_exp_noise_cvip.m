function [ outImage ] = neg_exp_noise_cvip( inImage, var, noiseImgSize)
% NEG_EXP_NOISE_CVIP - add Negative Exponential noise to an image.
% The function adds Negative exponential noise to an image or creates 
% Negative exponential noise image.If user wants to add Negative 
% exponential noise to the image, the user needsto pass only two input 
% arguments (input image,and noise variance).If user wants to create a
% Negative exponential noise image only, pass input image as an empty 
% matrix [].And,the size of the noise image can be defined by passing
% additional parameter (size of noise image).If not passed, default size 
% of 256*256 will be selected. 
% 
% Syntax :
% -------
% outImage = neg_exp_noise_cvip(inImage, var, noiseImgSize)
%   
% 
% Input Parameters include :
% ------------------------
%   'inImage'       1-band input image of MxN size or 3-band input image of   
%                   MxNx3 size. The input image can be of uint8 or uint16 
%                   or double class. 
%   'var'           variance of Negative Exponential noise.   (default 100)  
%   'noiseImgSize'  Size of Negative Exponential noise image. Only needed 
%                   when noise is added to black image. 
%                   noiseImgSize(1): height              (default 256)
%                   noiseImgSize(2): width               (default 256)
%
%
% Output Parameter include :  
% ------------------------
%   'outImage'      Negative Exponential noise added image or Negative Exponential noise image 
%                                         
%
% Example :
% -------
%                   I = imread('butterfly.tif');      %original image
%                   O1 = neg_exp_noise_cvip(I);       %default parameters  
%                   figure;imshow(remap_cvip(O1,[]));
%                   noise_parameter = 200;       %variance = 200
%                   %Negative exponential noise added image
%                   O2 = neg_exp_noise_cvip(I,noise_parameter);
%                   figure;imshow(remap_cvip(O2,[]));
%                   %Negative exponential noise image
%                   image_size = [300 400];        %height = 300, width = 400
%                   O3 = neg_exp_noise_cvip([],noise_parameter, image_size);               
%                   figure;imshow(remap_cvip(O3,[]));
%
% Reference 
% ---------
% 1. Scott E Umbaugh. DIGITAL IMAGE PROCESSING AND ANALYSIS: Applications with MATLAB and CVIPtools, 3rd Edition.

%==========================================================================
%
%           Author:                 Norsang Lama
%           Initial coding date:    4/10/2017
%           Latest update date:     4/20/2017
%           Credit:                 Scott Umbaugh 
%                                   CVIP Lab, SIUE
%           Copyright (C) 2017 Scott Umbaugh and SIUE
%
%==========================================================================

%check number of input arguments
if nargin ~=1 && nargin ~= 2 && nargin ~= 3  
    error('Too many or too few input arguments!');
end
if nargout ~=1 && nargout ~=0
    error('Too many or too few output arguments!');
end

default_var = 100; %default alpha and variance
default_noiseImgSize = [256 256];  %default size of black image

%set up the default parameters
if nargin == 1                  
    var = default_var;
    noiseImgSize = default_noiseImgSize;          
elseif nargin == 2                
    if isempty(var) || ~isnumeric(var)      %check if input argument #2 is empty or not numeric
        var = default_var;
    end 
elseif nargin == 3   
     if isempty(noiseImgSize) 
        noiseImgSize = default_noiseImgSize;
    elseif length(noiseImgSize)==1
        noiseImgSize = [noiseImgSize default_noiseImgSize(2)];
    elseif length(noiseImgSize)> 2
        noiseImgSize = noiseImgSize(1:2);
    end  
    if isempty(var) || ~isnumeric(var)      %check if input argument #2 is empty or not numeric
        var = default_var;
    end 
end

%check number of output arguments
if nargout ~= 1 && nargout ~= 0
    error('Too many output arguments!');
end


%check if user wants Noise image only
if isempty(inImage)      
    inImage = zeros(noiseImgSize);    
end 

%Method used in CVIPtools C function
%Negative exponential noise image
A = sqrt(var)/2;
% generate uniformly distributed pseudo-random sequences PN1 and PN2
PN1 = rand(size(inImage));  
PN2 = rand(size(inImage));   
noise = (-2)*A*log(1-PN1);
theta = PN2*2*pi - pi;
nexpo_noise = 0.5 + noise.*((cos(theta)).^2+(sin(theta)).^2);

%%other method which uses single uniformly distributed psudeo-random sequence
%%generate uniformly distributed pseudo-random sequence
% PNseq = rand(size(inImage));
% lambda = sqrt(1/var);
% nexpo_noise = (-1)*log(PNseq)/lambda;

%add noise image to input image (or black image)
outImage = double(inImage) + nexpo_noise;
end