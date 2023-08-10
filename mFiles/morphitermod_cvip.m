function outImage = morphitermod_cvip(binImage, setsSurr, n, boolFunc, rotate)
% MORPHITERMOD_CVIP - perform morphological iterative based  modification as defined
% a set of surrounds,a logical operation and the number of iterations of a binary image.
% To perform morphological modification,first,a_ij is found
% for each pixel;a_ij is 1 if (i,j)th pixel has the user specified 
% surrounds or 0 otherwise.Then,morphological operation is performed 
% between a_ij and b_ij, where b_ij is current pixel value (either 1 or 0).
% The user can specify the morphological operation by choosing one of the 
% boolean function from the pre-defined list.A total of 14 surrounds sets 
% are available.Each surrounds set has six surrounding pixels as we have
% considered NW/SE six connectivity.If rotate option is set ON, the
% surrounds are checked in all six directions.The morophological
% modification is repeated n times. 
%
% Syntax :
% ------
%  outImage = morphitermod_cvip(binImage, setsSurr, n, boolFunc, rotate)
%   
% Input Parameters include :
% ------------------------
%   'binImage'      Binary image of MxN size. 
%
%   'setsSurr'      A row vector containing the ids of the surrounds. The
%                   maximum length is 14. For examples, [2 5 7] or [1:14].
%                    
%                   surrounds id = 1  ---->  0 0 x
%                                            0 b 0
%                                            x 0 0
%
%                   surrounds id = 2  ---->  0 1 x
%                                            0 b 0
%                                            x 0 0
%                                       
%                   surrounds id = 3  ---->  1 1 x
%                                            0 b 0
%                                            x 0 0
%                          .
%                          .
%                          .
% 
%                   surrounds id = 14 ---->  1 1 x
%                                            0 b 0
%                                            x 1 1
%
%                   If multiple surrounds are selected, a_ij = 1 if any of 
%                   the surrounds are present. See reference 1 for other
%                   surrounds, which are not shown above.
%
%                                                              (default: 7)
%
%   'n'             Number of iterations.                    
%                                                              (default: 1)
%
%   'boolFunc'      Boolean function L(a,b)
%                   
%                   boolFunc = 1  ---->  !a     (i.e. NOT a)
%                   boolFunc = 2  ---->  ab     (i.e a AND b)
%                   boolFunc = 3  ---->  a+b    (i.e a OR b)
%                   boolFunc = 4  ---->  a^b    (i.e a XOR b)
%                   boolFunc = 5  ---->  (!a)b  (i.e (NOT a) AND b)
%                   boolFunc = 6  ---->  (a!b)  (i.e a AND (NOT b))
%      
%                                                              (default: 1)
%
%   'rotate'        Rotate each surrounds set. Checks each surrounds set in 
%                   all six directions if rotate option is set ON.
%                   
%                   rotate = 0  ---->  OFF
%                   rotate = 1  ---->  ON 
%      
%                                                              (default: 0)
%
%
% Output Parameter include :  
% ------------------------
%   'outImage'      Output image of iterative morphological modification. 
%                   It is of Boolean class.
%
%
% Example 1 :
% ---------
%     %Perform modification using default parameters 
%       I = imread('Shapes.bmp');         %original image
%       O1 = morphitermod_cvip(I);           
%       figure;imshow(O1,[]);
% Example 2 :
% ---------
%     %Perform modification using user specified parameters 
%
%       I = imread('Shapes.bmp');          %original image
%       n = 2;                             % number of iterations
%       f = 3;                            % boolean function L(a,b) = ab
%       S = [1 2 3];                     % sets of surrounds
%       r = 1;                             % rotate OFF
%       O2 = morphitermod_cvip(I,S,n,f,r);   
%       figure;imshow(O2,[]); 
%
% Reference :
% ---------
% 1. Scott E Umbaugh. DIGITAL IMAGE PROCESSING AND ANALYSIS: Applications with MATLAB and CVIPtools, 3rd Edition.

%==========================================================================
%
%           Author:                 Norsang Lama
%           Initial coding date:    8/3/2017
%           Latest update date:     8/9/2017
%           Credit:                 Scott Umbaugh 
%                                   CVIP Lab, SIUE
%           Copyright (C) 2017 Scott Umbaugh and SIUE
%
%==========================================================================

%check number of input and output arguments
if nargin ~= 1 && nargin ~= 2 && nargin ~= 3  && nargin ~= 4 && nargin ~= 5
    error('Too many or too few input arguments!')
end
if nargout ~= 0 && nargout ~= 1 
    error('Too many or too few output arguments!')
end

%check if input arguments are existed
% default values are set-up inside structel_cvip function
if ~exist('setsSurr','var') 
    setsSurr = 1;
    rotate = 0;
end

if ~exist('n','var')  
    n = 1;
end

if ~exist('boolFunc','var')  
   boolFunc = 1;
end

if ~exist('rotate', 'var')
    rotate = 0;
end


%Size of binary image and create temporary image
binImage = logical(binImage);
[M, N] = size(binImage);

%pixel positions of surrounds based on six-connectivity
pos = [[-1,-1]; [-1,0]; [0,1]; [1,1]; [1,0]; [0,-1]];


for i =1:n
    outImage = false(M,N);
    
    for id = 1:length(setsSurr)         
        
        %select the surrounds S
        S = select_surrounds_set(setsSurr(id));
        
        %if set 1, set 7, and rotate is OFF, we don't need to rotate the
        %surrounds
        if ~rotate || setsSurr(id) == 1 ||  setsSurr(id) == 7
            tempImage = true(M,N); 
            
            for ind = 1:6
                temp = false(M,N);
                r = pos(ind,1);
                c = pos(ind,2);   

                %pad the input binary image with +ve infinity values
                if r < 0
                    temp2 = [inf(-r, N); binImage(1:end+r,:)];
                elseif r > 0
                    temp2 = [binImage(1+r:end,:); inf(r,N)];
                else
                    temp2 = binImage;
                end

                if c < 0
                    temp2 = [inf(M,-c) temp2(:, 1:end+c)];
                elseif c > 0
                    temp2 = [temp2(:, 1+c:end) inf(M,c)];
                end              

                %find if surrounds are present
                temp(temp2 == S(ind)) = true;
                tempImage = tempImage & temp;

            end
        else
            %find all combinations of surrounds if rotate option is set ON
            S = find_all_surrounds(S);
            
            tempImage = true(M,N,6);
            
            for ind = 1:6
                temp = false(size(binImage));
                r = pos(ind,1);
                c = pos(ind,2);   

                %pad the input binary image with +ve infinity values
                if r < 0
                    temp2 = [inf(-r, N); binImage(1:end+r,:)];
                elseif r > 0
                    temp2 = [binImage(1+r:end,:); inf(r,N)];
                else
                    temp2 = binImage;
                end

                if c < 0
                    temp2 = [inf(M,-c) temp2(:, 1:end+c)];
                elseif c > 0
                    temp2 = [temp2(:, 1+c:end) inf(M,c)];
                end              

                %find if surrounds are present
                tt = temp;
                for j = 1:6
                    tt(temp2 == S(j,ind)) = true;
                    tempImage(:,:,j) = tempImage(:,:,j) & tt;
                    tt = temp;
                end
            end
            tempImage = tempImage(:,:,1)| tempImage(:,:,2)|tempImage(:,:,3)...
                | tempImage(:,:,4)|tempImage(:,:,5)|tempImage(:,:,6);
        end        
        outImage = outImage | tempImage;
    end
    
    %perform the Boolean operation as specified by user
    switch boolFunc        
        case 1  % !a => NOT a
            outImage = ~outImage;
        case 2  % ab => a AND b
            outImage = outImage & binImage;
        case 3  % a + b => a OR b
            outImage = outImage | binImage;
        case 4  % a ^ b => a XOR b
            outImage = xor(outImage, binImage); 
        case 5  % (!a)b +> (NOT a) AND b
            outImage = (~outImage) & binImage;           
        case 6  % a(!b) +> a AND (NOT b)
            outImage = outImage & (~binImage);    
    end
    
    binImage = outImage;
end
    
end



function allSurrounds = find_all_surrounds(S)
%find all six combinations of surrounds S
    allSurrounds = [S; zeros(5,6)];
   
    %rotating the surrounds (or hexLat)
    for i = 2:6
        allSurrounds(i,:) = [allSurrounds(i-1,end) allSurrounds(i-1,1:end-1)];
    end   
    
end

function hexLat = select_surrounds_set(id)
    
    switch id
        case 1  % all surrounds = 0
            hexLat = [[0 0 0] ...
                     [0 0 0]];
            
        case 2
            hexLat = [[0 0 0]...
                      [0 0 1]];
            
        case 3            
            hexLat = [[1 1 0]...
                      [0 0 0]];
            
        case 4
            hexLat = [[1 1 0]...
                      [0 0 1]];
            
        case 5
            hexLat = [[1 1 1]...
                      [0 0 1]];
            
        case 6
            hexLat = [[1 1 1]...
                      [0 1 1]];
                
        case 7
            hexLat = [[1 1 1]...
                      [1 1 1]];
            
        case 8 
            hexLat = [[0 1 0]...
                      [1 0 1]]; 
                
        case 9
            hexLat = [[1 1 0]...
                      [0 1 0]];
                
        case 10
            hexLat = [[1 1 0]...
                      [1 0 0]];
               
        case 11
            hexLat = [[1 1 0]...
                      [0 0 1]]; 
                
        case 12
            hexLat = [[0 1 0]...
                      [0 0 1]];
               
        case 13
            hexLat = [[0 1 0]...
                      [0 1 0]];
               
        case 14
            hexLat = [[0 1 1] ...
                      [0 1 1]];          
    end
end

