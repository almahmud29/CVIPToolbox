function [gFilter] = gaussmask_cvip(Msiz)
%GAUSSMASK_CVIP Summary of this function goes here
%   Detailed explanation goes here

    %gFilter = window(@chebwin,Msiz);
%%By deafult value from DSP
    switch Msiz
        case 3
            gFilter=[0.5,1,0.5];
            gFilter=gFilter(:);
        case 5
            gFilter=[0.168664687345627,0.668651314185611,1,0.668651314185611,0.168664687345627];
            gFilter=gFilter(:);
         
        case 7
            gFilter=[0.0565040506285020,0.316608530648474,0.760120812353908,1,0.760120812353908,0.316608530648474,0.0565040506285020];
            gFilter=gFilter(:);
        case 9
            gFilter=[0.0218274074752118;0.144505627492174;0.443468588402406;0.820771062658583;1;0.820771062658583;0.443468588402406;0.144505627492174;0.0218274074752118];
            %gFilter=gFilter(:);
        case 11
            gFilter=[0.0100801109670276;0.0710970215667059;0.246608508718669;0.548819188589712;0.863249989018911;1;0.863249989018911;0.548819188589712;0.246608508718669;0.0710970215667059;0.0100801109670276];
            %gFilter=gFilter(:);
            
            
    end
    %%Algorithm 1
    m = Msiz;
    n = Msiz;
    %%Getting the sigma Value
    sigma=0.25;
    for i=5:2:n
        sigma=sigma+0.25;
    end
        
    %sigma=sqrt( ((n^4/2))/((2*log(2))+((n-3)*log(3))));
    %sigma=(m-1)/6;
    %sigma=kernel_radius/2;
    %Another approach
%     [xx,yy] = meshgrid(-(m-1)/2:(m-1)/2, -(n-1)/2:(n-1)/2);
%     gFilter = exp(-1/(2*sigma^2) * (xx.^2 + yy.^2));
%     %%
%     
    [h1, h2] = meshgrid(-(m-1)/2:(m-1)/2, -(n-1)/2:(n-1)/2);
    hg = exp(- (h1.^2+h2.^2) / (2*sigma^2));
    gFilter = hg ./ sum(hg(:));
%     [r,c] = meshgrid(gFilter,gFilter);
%     gFilter = power(Msiz,2).*(r.*c);
    
end
