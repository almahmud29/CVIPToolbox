%%%...................Contrast Limited Adaptve Histogram Equialization..........
%%%The main aim of the function is to do adaptive histogram equilization
%%%using control the contrast.The algorithm has been developed using   
%%%sliding window method.The results of the output image depends on the
%%%contrast limit and the block size.the DCT symmetry has been applied to
%%%border edges to get rid of the undesirable pixels.
% Syntax :
% -------
% outImage = clahe_cvip( inImage,block size, band, clipping limit,'n')
%   
% Input Parameters include :
% ------------------------
%
% 'inImage'       Input image of MxN or MxNxB size. The input image can
%                 be of uint8 or double class. 
% 'block size'    Specify a block size.It should be an odd number.
%                      
% 'band'          Specify a band 
%                 [band=1=> Red band,band=2 => Green band,band=2 => Blue band
%                                                             
% 'clipping limit' Specify a clipping limit form 0 to 1 to limit the contrast 
%                       
%                                                             
%  'byte'          If user wants the output as byte (0-255)  'y', otherwise 'n'
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
%        Output=Clahe_cvip(I,33,1,0.2,'y')
%        figure; imshow(Output);
%                                                                      
% Reference
% ---------
% 1. Scott E Umbaugh. DIGITAL IMAGE PROCESSING AND ANALYSIS: Applications
% with MATLAB and CVIPtools, 3rd Edition.
%Reference
% 2. Pizer, Stephen M. "Contrast-limited adaptive histogram equalization: Speed and effectiveness stephen m. pizer, r. eugene johnston, james p. ericksen, bonnie c. yankaskas, keith e. muller medical image display research group." Proceedings of the First Conference on Visualization in Biomedical Computing, Atlanta, Georgia. Vol. 337. 1990. 

% 3. Reza, Ali M. "Realization of the contrast limited adaptive histogram equalization (CLAHE) for real-time image enhancement." Journal of VLSI signal processing systems for signal, image and video technology 38.1 (2004): 35-44. 

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
function output=clahe_cvip(A,Block,band,limit,byte)

tic
[m,n,o] = size(A);
A=double(A);

W = Block;

    
if rem(Block, 2) == 0
    opts = struct('WindowStyle','modal',... 
              'Interpreter','tex');
warndlg('Please select an odd number for the block size ','Warning',opts);
     %errordlg(['Selected block size is not an odd number! Select an odd number' ...
       % ' and try again.'], 'CLAHE Error', 'modal');

else
   f = waitbar(0,'CLAHE','Name','CLAHE is running...',...
    'CreateCancelBtn','setappdata(gcbf,''canceling'',1)');

setappdata(f,'canceling',0);
c = (W+1)/2;    % coordinate of the center pixel of the window
output = double(A);
m1=m+(c*2-2);
n1=n+(c*2-2);
A1=zeros(m1,n1);
% A2=zeros(m,n);
%%
%%Mirror the edge
% ro=(m-(c-1))-(c-2);%row
% co=(n-(c-1))-(c-2);

A1(1:c-1,c:n1-(c-1),band)=flipud( A(1:c-1,1:n,band));%top row
A1(c:m1-(c-1),1:c-1,band)=fliplr( A(1:m,c:c+(c-2),band));%left corner
A1(m1-(c-2):end,c:n1-(c-1),band)=flipud( A(m-(c-2):end,1:n,band));%bottom row
A1(c:m1-(c-1),(n1-(c-2)):end,band)=fliplr( A(1:m,n-(c-2):n));%top right
%%
%%Corner Mirror
%top left
A1(1:c-1,1:c-1,band)=fliplr(A(1:c-1,c:c+c-2,band));
A1(1:c-1,1:c-1,band)=flipud( A1(1:c-1,1:c-1,band));
%top right
A1(1:c-1,n1-(c-2):end,band)=fliplr(A(1:c-1,n-(c-2):n,band));
A1(1:c-1,n1-(c-2):end,band)=flipud(A1(1:c-1,n1-(c-2):end,band));
%bottom left
A1(m1-(c-2):end,1:c-1,band)=fliplr(A(m-(c-2):end,c:c+(c-2),band));
A1(m1-(c-2):end,1:c-1,band)=flipud(A1(m1-(c-2):end,1:c-1,band));
%bottom right
A1(m1-(c-2):end,n1-(c-2):end,band)=fliplr(A(m-(c-2):end,n-(c-2):n,band));
A1(m1-(c-2):end,n1-(c-2):end,band)=flipud(A1(m1-(c-2):end,n1-(c-2):end,band));

                  
%Getting the middle image
for i= c: (m1+1-c)
    for j=c:(n1+1-c) 
    
        A1(i,j,band) = double(A(i-(c-1),j-(c-1),band)) ; % W-block of the image. Only one band.
        
    
    end
end

%%Sliding window

for i= c: (m1+1-c)
    for j=c:(n1+1-c) 
        
        block = double( A1( i - (c-1): i+ (c-1) , j - (c-1): j+ (c-1), band ) ) ; % W-block of the image. Only one band.
        block=histeq_contrast(block,W,limit);
        B=block(ceil(numel(block)/2));
        
%         B=mean(block(:));
       output(i-(c-1),j-(c-1),band) =B ;
        if getappdata(f,'canceling')
            break
        end
      last=n1+1-c;
    % Update waitbar and message
      waitbar(i/last,f,sprintf('Sliding window is running row %d of %d',i,last))   
%     output(i,j,band) =B ;
    end
end
delete(f)
% for i= c: (m1+1-c)
%     for j=c:(n1+1-c) 
%     
%         output(i-(c-1),j-(c-1),band) = double(A1(i,j,band)) ; % W-block of the image. Only one band.
%         
%        
%     end
% end


if o>1
    %avoid divide-by-zero by replacing 0 with nan
    tempImage = A(:,:,band);
    tempImage(tempImage == 0) = nan;


      for b=1:o
          if b ~= band
              output(:,:, b) = ( output(:,:,band)./tempImage).*A(:,:,b);
               if output(:,:, b)==0
                  output(:,:, b)=0.5;
               end%keeping the ratio same
          end
          
      end

    %now replace all nan values with 0
     output(isnan( output)) = 0;
     
end
if strcmp(byte,'y')
     output=uint8(output);
end
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
%add the average between all frequency
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
end
cum=zeros(256,1);
probc=zeros(256,1);
output = zeros(256,1);
sum=0;
eq=zeros(r*c,1);
numOfPixels=r*c;
maxGray=256;
% maxGray=max(A(:));
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