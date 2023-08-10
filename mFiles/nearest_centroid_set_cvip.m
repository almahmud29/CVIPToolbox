function file_name = nearest_centroid_set_cvip(file_tr)
% NEAREST_CENTROID_SET_CVIP – reads test and training files of feature vectors and calculates centroids for each class
%
% Syntax :
% -------
% file_name = nearest_centroid_set_cvip(file_tr)
%   
% Input Parameters include :
% ------------------------ 
%   'file_tr'       Name of the training set file. 
%                   A CSV file with a predefined structure.
%
%
% Output Parameters include :  
% ------------------------- 
%   'file_name'     The name of the output file saved in the current directory.
%                   It contains the centroid vector for each class.
%
%
% Example :
% -------
%                   file_tr = 'myTrainingVectors.CSV';
%                   d = nearest_centroid_set_cvip(file_tr)
%
% Reference
% ---------
% 1. Scott E Umbaugh. DIGITAL IMAGE PROCESSING AND ANALYSIS: Applications with MATLAB and CVIPtools, 3rd Edition.

%==========================================================================
%
%           Author:                 Mehrdad Alvandipour
%           Initial coding date:    3/13/2017
%           Latest update date:     02/22/2019
%           Updated by:             Julian Rene Cuellar Buritica
%           Credit:                 Scott Umbaugh 
%                                   CVIP Lab, SIUE
%           Copyright (C) 2016 Scott Umbaugh and SIUE
%
%==========================================================================

% Revision History
 % Revision 1.3  02/22/2019  13:03:53  
 % function was modified to extract the features of each class and get the
 % correct centroid for each class.
%
 % Revision 1.2  06/08/2018  15:39:04  jucuell
 % extraction od feature vector values according to the type of feature
 % data by using obj_id, Image name, or obj_id and Image name
%
 % Revision 1.1  07/29/2016  16:29:05  mealvan
 % Initial coding:
 % function creation and initial testing
%

% file_tr = 'dt11.csv';
training_set = readtable(file_tr);
%extract Features values
switch training_set.Properties.VariableNames{1,1}
    case 'obj_id'
        ini = 2;
    case 'row_obj'
        ini = 3;
    otherwise %case 'Name'
        ini = 4;
end
Train = training_set(:,ini:end-1);  %feature values
Vbles = Train.Properties.VariableNames;
class_vec = training_set{:,end};    %feature classes
classes = unique(class_vec);        %get clases from feature vector
siza = size(classes,1);             %number of classes in vector
T = training_set(1:siza, :);        %copy data with size of # classes
for i=1:siza                        %get indexes of each class
    a = find(strcmp(class_vec,classes{i}));
    T0 = Train(a,:);                %extrac data per class
    for j=1:size(Train,2)
        T(i,j+1) = {mean(eval(['T0.' Vbles{j}]))};
    end
end
T(:,1) = classes;                   %assign classes names to object id
T(:,end) = classes;                 %and classes

%set file name Save file in the same directory of the train vector
file_name = [file_tr(1,1:size(file_tr,2)-4) '_centroids.csv'];
writetable(T,file_name);

end