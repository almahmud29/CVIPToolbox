function newImage = notch_filter_cvip(InputImage,zone,number,interactive)
% NOTCH_FILTER_CVIP -performs the notch frequency domain filtering.
%
% Syntax :
% -------
% newImage = notch_filter_cvip(Input_spect,zone,number,interactive)
%   
% Description :
% ------------
%  Notch is a function to  perform  selective  filtering  on  a
%  user-defined  area  of  an  image  or  spectrum. It is often
%  applied to frequency  domain  images  to  eliminate  regular
%  sinusoidal interference.
%
% Input Parameters include:
% ------------------------
%   'Input_spect'   The input spectrum. It can be obtained by fft_cvip().
%
%   'zone'          It must be a struct array containing the the fields
%                   X,Y,R which represent the location and the radius.
% 
%   'number'        The number of points that should be removed on the spectrum. 
%                   This number decides how many of the locations in the
%                   variable zone is used.
%
%   'interactive'   Instead of the variables zone and number, you can pass
%                   the value 1 to this variable and then input the 
%                   information about the locations and radius using a
%                   dialog box.
%
% Output Parameter include :
% ------------------------
%
%   'newImage'      The output spectrum after notch filtering.
% 
%
%   Example:
%   -------
%  
%                 Input_spect = imread('cam.bmp');
%                 block = [];
%                 outImage = fft_cvip( Input_spect,block);
%                 x =  [100  125];	
%                 y =   [112 112];
%                 r =   [10 10];
%                 zone = struct('X',{x},'Y',{y},'R',{r});
%                 number = length(x);
%                 filterIm = notch_filter_cvip(outImage,zone,number,0);
%                 figure;imshow((filterIm));
%                 inverseIm = ifft_cvip(filterIm,[]);
%                 figure;imshow(remap_cvip(inverseIm));
%
% Reference
% ---------
% 1. Scott E Umbaugh. DIGITAL IMAGE PROCESSING AND ANALYSIS: Human and Computer Vision Applications
%  with CVIPtools, 2nd Edition. 

%==========================================================================
%
%           Author:                 Mehrdad Alvandipour
%           Initial coding date:    10/13/2016
%           Latest update date:     10/19/2016
%           Credit:                 Scott Umbaugh 
%                                   CVIP Lab, SIUE
%           Copyright (C) 2016 Scott Umbaugh and SIUE
%
%==========================================================================


% OriginalImage = imread('CarSine.bmp');
%OriginalImage = double(OriginalImage);
[m ,n, o] = size(InputImage);

% Mw = fft2(OriginalImage);
% Mw=fftshift(Mw); % move the origin of the transform to the center of the frequency rectangle
% S2=log(1+abs(Mw)); % use abs to compute the magnitude (handling imaginary) and use log to brighten display
% S2 = mat2gray(S2);
% figure, imshow(S2,[])


if interactive
    prompt = {'x:','y:', 'R:'};
    dlg_title = 'Comma seperated list of inputs';
    num_lines = 1;
    def = {'5','5','2'};
    options.Resize = 'on';
    options.WindowStyle='normal';
    answer = inputdlg(prompt,dlg_title,num_lines,def,options);
    
    xx = str2num(answer{1});
    yy = str2num(answer{2});
    RR = str2num(answer{3}); % radius
    
    zone = struct('X',{},'Y',{},'R',{});
    
    number = length(xx);
    for i=1:number
        zone(i).X = xx(i);
        zone(i).Y = yy(i);
        zone(i).R = RR(i);
    end
end

%% create the notch mask M
M = ones(m,n,o);

% % find the position of the DC component.
% a = ones(m,n); a(1,1) = 0;
% az = fftshift(a);
% [r,c] = find(az == 0); 

for i=1:number

    xx = zone.X;
    yy = zone.Y;
    RR = zone.R;
%     k
    % create a circle of zeros with radius R
    x = xx(i);y = yy(i); R = RR(i);
    temp = (2*R) + 1;
    [U,V] = dftuv(temp,temp);
    D = sqrt(U.^2 + V.^2);
    D = fftshift(D);
    H = double(D <=R);
    H = not(H); % H is the matrix of the circle


    % put H inside M in the correct position
    for j=1:o
        M(y-R:y+R,x-R:x+R,j) = H;
    end

end
% figure; imshow(M,[])

%% Multiply the mask and the Input Image
newImage = M.*InputImage;
end
% S2=log(1+abs(Mw)); % use abs to compute the magnitude (handling imaginary) and use log to brighten display
% S2 = mat2gray(S2);
% figure, imshow(S2,[])

% newImage = real( ifft2( ifftshift(Mw) ) );
% figure; imshow(newImage/256,[])

function [U, V] = dftuv(M, N)
%DFTUV Computes meshgrid frequency matrices.
%   [U, V] = DFTUV(M, N) computes meshgrid frequency matrices U and
%   V. U and V are useful for computing frequency-domain filter 
%   functions that can be used with DFTFILT.  U and V are both M-by-N.

% Set up range of variables.
u = 0:(M-1);
v = 0:(N-1);

% Compute the indices for use in meshgrid
idx = find(u > M/2);
u(idx) = u(idx) - M;
idy = find(v > N/2);
v(idy) = v(idy) - N;

% Compute the meshgrid arrays
[V, U] = meshgrid(v, u);
end
