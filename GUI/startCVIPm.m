%Scrip to start CVIPTools Matlab
warning ('off','all');

% clc
%Call CVIPToolbox figure and get its handle
% h = CVIPToolbox;
% h=Preprocessing;
%Dock menu on empty frame
group = setfigdocked('GroupName','CVIP Toolbox V.3.7','Figure', CVIPToolbox , ...
    'Maximize', 0, 'GroupDocked', 0);
% group = setfigdocked('GroupName',' ','Figure', CVIPToolbox , ...
%     'Maximize', 0, 'GroupDocked', 0);
 clear;
 