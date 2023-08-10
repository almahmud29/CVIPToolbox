
% batch_cvip: Script that can be used to perform image processing operations
% in batch mode. It reads multiple images and multiple mask  as specified by the user and 
% perform multiple image processing operation on the input images and stores
% the output images in the folder specified by the user.
%
% Batch  file illustrates its use with a few sample functions.To run your
% own algorithm on a set of images,simply replace the sample functions
% with the sequence of functons you needed to implement your algorithm.
%

clc;
clear;
%% Get the image file
[filename, pathname] = uigetfile({'*.*', 'All Files (*.*)';...
        '*.tif','TIFF (*.tif)'; '*.bmp','BMP (*.bmp)';...
        '*.jpg', 'JPEG/JPEG2000 (*.jpg)'; '*.png','PNG (*.png)';...
        '*.pbm ; *.ppm;*.pgm; *.pnm',...
        'PBM/PPM/PGM/PNM (*.pbm,*.ppm,*.pgm, *.pnm)';...
        '*.gif','GIF (*.gif)'}, ...
        'Select an input image file', 'MultiSelect','on'); % prompts user to select input files

if ~isa(filename,'cell')
    filename = cellstr(filename); % convert filename to cell structure
end
%%Get the Mask file
% [filename2, pathname2] = uigetfile({'*.*', 'All Files (*.*)';...
%         '*.tif','TIFF (*.tif)'; '*.bmp','BMP (*.bmp)';...
%         '*.jpg', 'JPEG/JPEG2000 (*.jpg)'; '*.png','PNG (*.png)';...
%         '*.pbm ; *.ppm;*.pgm; *.pnm',...
%         'PBM/PPM/PGM/PNM (*.pbm,*.ppm,*.pgm, *.pnm)';...
%         '*.gif','GIF (*.gif)'}, ...
%         'Select an input image file', 'MultiSelect','on'); % prompts user to select input files

if ~isa(filename,'cell')
    filename = cellstr(filename); % convert filename to cell structure
end
%%
[k,l]=size(filename);%get the file size
% if ~isa(filename2,'cell')
%     filename2 = cellstr(filename2); % convert filename to cell structure
% end
folder_name = uigetdir; % prompts user to select folder to save output images   
for i = 1:l % iterate through all input image files
    imageName = char(filename(i)); % read the name of input image
    im = imread([pathname imageName]); % load the particular image for operation
    %im2=char(filename2(i)) ;
    %im2=imread([pathname2 im2]);% 2nd image (mask image)
%     imshow(im2)
%     imshow(im)
     G = extract_band_cvip(im,2);
     J = adapthisteq(G,'clipLimit',0.02,'Distribution','rayleigh');
     %imshow(J)
     %g=max(J(:));
    
     [O2, kernel] = morphdilate_cvip(J,3,3,[3 3]);
     
     %A=hist(O2);
     %g=O2(:,:,2);
     %max1=max(g(:))*255;
     
     %THlvl=max1;
     %imshow(O2)
%       if max(max(O2(:))) <= 1      %detect if image data type is double
%         OutIma = threshold_cvip(InIma, THlvl/255);
%       else
%         OutIma = threshold_cvip(uint8(O2), THlvl);
%       end%
        %im=im2double(O2);
      OutIma=threshold_cvip( O2, 190 );
      %imshow(OutIma)
      OutIma=imresize(OutIma,[1072 712])
      %mask=threshold_cvip( im2, 110) ;
     
      %OutIma=uint8(divide_cvip(OutIma,mask))
      
      
     

   
    [~,name,ext] = fileparts(filename{i}); % separates the filename and extension
    FinalImageName = strcat(name,'_',int2str(i),ext); % Create new output filename for each new image
    imwrite(OutIma,[folder_name '\' FinalImageName]); % write image to disk
    disp(i); % display the image number being operated
end


