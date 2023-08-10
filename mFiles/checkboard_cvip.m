
% checkboard_cvip - creates checkboard according to the object width and
% height
%
% Syntax :
% -------
% 
% checkboard_cvip(height, width,[rowini], [colini], [obj_height], [obj_width], [bands], [R], [G], [B])
%   
% Input Parameters include :
% ------------------------ 
%   'height'    Image height
%   'width'     Image width

% Reference
% ---------
% 1. Scott E Umbaugh. DIGITAL IMAGE PROCESSING AND ANALYSIS: Applications
% with MATLAB and CVIPtools, 3rd Edition.

%==========================================================================
%
%           Author:                 Julián René Cuellar Buriticá
%           Initial coding date:    02/27/2018
%           Updated By         :    Hridoy Biswas
%           Latest update date:     12/01/2020
%           Credit:                 Scott Umbaugh 
%                                   CVIP Lab, SIUE
%           Copyright (C) 2016 Scott Umbaugh and SIUE
%
%==========================================================================
function OutIma= checkboard_cvip(height,width,firsty,firstx,blockx,blocky,no_bands,varargin)

        OutIma = zeros(height, width,no_bands);
        
        dx = bitshift(blockx,1);
        dy = bitshift(blocky,1);
        
        for k=1:no_bands
            if k == 1           %R band Color
                if no_bands == 1
                        color = 255;              %monocrome outline
                    else
                        color = varargin{1};    %color outline
                end
            elseif k == 2
                color=varargin{2};      %G band Color
            else
                color=varargin{3};      %B band Color
            end
            for i=1:firsty    %fill first row
                for j=1:firstx
                    OutIma(i,j,k) = color;
                end

                for y=1:firsty
                    for x=(firstx+blockx):dx:width 
                        for j=1:blockx 
                            if (y+j<=height) && (x+j<=width)
                                OutIma(y,x+j,k) = color;
                            end
                        end
                    end
                end   
            end

                for y=firsty+blocky:dy:height    %fill first column
                    for x=1:firstx
                        for i=1:blocky
                            if(y+i<=height) && (x+i<=width)
                                OutIma(y+i,x,k) = color;	
                            end
                        end
                    end
                end

                for y=firsty:dy:height      %fill odd rows
                    for x=firstx:dx:width 
                        for i=1:blocky
                            for j=1:blockx
                                if (y+i<=height) && (x+j<=width)
                                    OutIma(y+i,x+j,k) = color;	
                                end
                            end
                        end
                    end
                end

                for y=firsty+blocky:dy:height     %fill even rows
                    for x=firstx+blockx:dx:width 
                        for i=1:blocky
                            for j=1:blockx 
                                if (y+i<=height) && (x+j<=width)
                                    OutIma(y+i,x+j,k) = color;	
                                end
                            end
                        end
                    end
                end
        end
end