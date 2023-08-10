%%%...................Contrast Limited Adaptve Histogram Equialization..........
%%%The main aim of the function is to do adaptive histogram equilization
%%%using conrast limiting parameter.The algorithm has been developed using   
%%%non-overlapping method.The results of the output image depends on the
%%%contrast limitation and the block size.Bi-linear interpolation can be done to remove block artifacts.
% Syntax :
% -------
% outImage = Clahe_cvip( inImage,block size, band, clipping limit)
%   
% Input Parameters include :
% ------------------------
%
% 'inImage'       Input image of MxN or MxNxB size. The input image can
%                 be of uint8 or double class. 
% 'block size'    Specify a block size.It can be any number.
%                      
% 'band'          Specify a band 
%                 [band=1=> Red band,band=2 => Green band,band=2 => Blue band
%                                                             
% 'clipping limit' Specify a clipping limit form 0 to 1 to limit the contrast 
%                       
%                                                             
%  'byte'          If user wants the output as byte (0-255)  'y', 'n'
%                  

% 
%
% Output Parameter include :  
% ------------------------
% 'outImage'      Output  subimage
%                                         
%
% Examples :
% --------
%        I = imread('cam.bmp');      %original image
%        Output=clahe_cvip_block(I,33,1,0.2,'y')
%        figure; imshow(Output);
%                                                                      
% Reference
% ---------
% 1. Scott E Umbaugh. DIGITAL IMAGE PROCESSING AND ANALYSIS: Applications
% with MATLAB and CVIPtools, 3rd Edition.
%Reference
%--------------------------------------------------------------------------
%%.....

%==========================================================================
%
%           Author:                 Hridoy Biswas
%           Initial coding date:    9/15/2020
%           Latest update date:     10/22/2020
%           Credit:                 Scott Umbaugh 
%                                   CVIP Lab, SIUE
%           Copyright (C) 2019-2020 Scott Umbaugh and SIUE
%
%==========================================================================

%--------------------------------------------------------------------------
function reconstructed=clahe_cvip_block(A,Block,band,limit,byte)

[rows, columns, o] = size(A);
A=double(A);
% Enlarge figure to full screen.
% set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
% Divide the image up into 4 blocks.
% Let's assume we know the block size and that all blocks will be the same size.
blockSizeR = Block; % Rows in block.
blockSizeC = Block; % Columns in block.
% Figure out the size of each block. 
wholeBlockRows = floor(rows / blockSizeR);
wholeBlockCols = floor(columns / blockSizeC);
% Preallocate a 3D image
image3d = zeros(wholeBlockRows, wholeBlockCols, 3);
% Now scan though, getting each block and putting it as a slice of a 3D array.
sliceNumber = 1;
reconstructed = zeros(size(A));


for row = 1 : blockSizeR : rows
  for col = 1 : blockSizeC : columns
    % Let's be a little explicit here in our variables
    % to make it easier to see what's going on.
    % Determine starting and ending rows.
    row1 = row;
    row2 = row1 + blockSizeR - 1;
    row2 = min(rows, row2); % Don't let it go outside the image.
    % Determine starting and ending columns.
    col1 = col;
    col2 = col1 + blockSizeC - 1;
    col2 = min(columns, col2); % Don't let it go outside the image.
    % Extract out the block into a single subimage.
    oneBlock = A(row1:row2, col1:col2);
    oneBlock = (histeq_contrast(oneBlock,Block,limit));
   
    % Assign this slice to the image we just extracted.
    if (row2-row1+1) == blockSizeR && (col2-col1+1) == blockSizeC
      % Then the block size is the tile size, 
      % so add a slice to our 3D image stack.
      image3D(:, :, sliceNumber) = oneBlock;
      reconstructed(row1:row2, col1:col2,band) = oneBlock ;
%       subplot(2, 2, 2);   
%       imshow(reconstructed,[] )
    else
        
     reconstructed(row1:row2, col1:col2,band) = oneBlock ;
%      subplot(2, 2, 2);   
%      imshow(uint8(reconstructed))
    
        
        
      newTileSize = [(row2-row1+1), (col2-col1+1)];
%       warningMessage = sprintf('Warning: this block size of %d rows and %d columns\ndoes not match the preset block size of %d rows and %d columns.\nIt will not be added to the 3D image stack.',...
%         newTileSize(1), newTileSize(2), blockSizeR, blockSizeC);
%       uiwait(warndlg(warningMessage));
    end
    sliceNumber = sliceNumber + 1;
  end

    
end
if o>1
    %avoid divide-by-zero by replacing 0 with nan
    tempImage = A(:,:,band);
    tempImage(tempImage == 0) = nan;


      for b=1:o
          if b ~= band
              reconstructed(:,:, b) = ( reconstructed(:,:,band)./tempImage).*A(:,:,b);%keeping the ratio same
          end
      end

    %now replace all nan values with 0
     reconstructed(isnan( reconstructed)) = 0;

end
if strcmp(byte,'y')
     reconstructed=uint8(reconstructed);
end
end
function eq=histeq_contrast(A,block,limit)
% A=imread("Cameraman.tif");
limit=round((limit*block^2));

x=unique(A);
% limit=(1-limit)*100;
% limit=round((limit*(block^2)/length(x)));
% s=sort(A);
out = (histc(A(:),x));
sum=0;
[r,c,b]=size(A);
% B=A(:);
no_bins=256;
freq=zeros(256,1);

 for i=1:size(A,1)
        for j=1:size(A,2)
            value = A(i,j);
            freq(value+1) = freq(value+1)+1 ;
%             if freq(value+1)>limit
%                 sum1=(freq(value+1)-limit)+sum1;
%                 freq(value+1)=limit;
%             end% Frequency
        end
 end
% %clippping histogram
for i= 1:max(A(:))
    if freq(i+1)>limit
        f=freq(i+1)-limit;
        freq(i+1)=limit;
        sum=sum+f;
    else
        freq(i+1)=freq(i+1);
    end

end
average=sum/length(x);
new_freq=zeros(256,1);
for i= 1:max(A(:))
    if freq(i+1)<limit && freq(i)>0
     new_freq(i+1)=freq(i+1)+average;
     if new_freq(i+1)>limit
         new_freq(i+1)=limit;
     
     else
       new_freq(i+1)= new_freq(i+1);
     end
    else
    new_freq(i+1)=freq(i+1);
     
    end
end%add the average between all frequency
cum=zeros(256,1);
probc=zeros(256,1);
output = zeros(256,1);
sum=0;
eq=zeros(r*c,1);
numOfPixels=r*c;
% maxGray=256;
maxGray=max(A(:));
 for i = 1:max(A(:))
        sum=sum+new_freq(i+1);  
        cum(i)=sum; % cumulative frequency
        probc(i)=cum(i)/numOfPixels; % Normalized Frequency
        output(i) = round(probc(i)*maxGray); %Hist Equalized pixel value
 end
    t=1:no_bins;
% t=0:max(A(:));
%----Mapping the original pixels to hist equalized pixel value
    for i=1:max(A(:))
                eq(A==t(i))=output(i);
    end
        eq = uint8(reshape(eq,size(A)));
        
%         imshow(eq,[]);
end