function varargout = Preprocessing(varargin)
% PREPROCESSING MATLAB code for Preprocessing.fig
%      PREPROCESSING, by itself, creates a new PREPROCESSING or raises the existing
%      singleton*.
%
%      H = PREPROCESSING returns the handle to a new PREPROCESSING or the handle to
%      the existing singleton*.
%
%      PREPROCESSING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PREPROCESSING.M with the given input arguments.
%
%      PREPROCESSING('Property','Value',...) creates a new PREPROCESSING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Preprocessing_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Preprocessing_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Preprocessing

% Last Modified by GUIDE v2.5 10-Aug-2023 14:23:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Preprocessing_OpeningFcn, ...
                   'gui_OutputFcn',  @Preprocessing_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% Reference 
% ---------
%  1. Scott E Umbaugh. DIGITAL IMAGE PROCESSING AND ANALYSIS: Applications 
%     with MATLAB and CVIPtools, 3rd Edition.

%==========================================================================
%
%           Author:                 Julian Rene Cuellar Buritica (GUIDE)
%           Initial coding date:    11/21/2017
%           Updated by:             Julian Rene Cuellar Buritica
%           Latest update date:     05/24/2019
%           Credit:                 Scott Umbaugh 
%                                   CVIP Lab, SIUE
%           Copyright (C) 2018 Scott Umbaugh and SIUE
%
%==========================================================================

% --- Executes just before Preprocessing is made visible.
function Preprocessing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Preprocessing (see VARARGIN)

% Choose default command line output for Preprocessing
handles.output = hObject;

% % Slider Edit Start
% Shrink the GUI
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pos =  get(handles.Preproc,'position');
% pos(4) = 33;
set(handles.Preproc,'position',pos)
pos =  get(handles.slider1,'position');
% pos(4) = 31;
set(handles.slider1,'position',pos)

% Create the list of the objects to move
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
handles.hListe =  [handles.uibuttongroup4;...
    handles.uibuttongroup5; ...
    handles.uibuttongroup6;...
    handles.uibuttongroup7; ...
%     handles.uibuttongroup9; ...
%     handles.bCA; ...
%     handles.uibuttongroup6; ...
%     handles.edit8; ...
%     handles.txtTrain; ...
%     handles.txtTest; ...
%     handles.txtOut; ...
%     handles.bTrain; ...
%     handles.bTest; ...
%     handles.bOut; ...
    handles.uibuttongroup9];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Save the original positions of save Objects to move
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
handles.pos = get(handles.hListe,'position');
% % Slider Edit End

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Preprocessing wait for user response (see UIRESUME)
% uiwait(handles.Preprocessing);
%call menu creation function

menu_add_cvip(hObject);

% Arithmatic
handles.curImage.Visible = 'On';
handles.secImage.Visible = 'On';
handles.selFirstimage.Visible = 'On';
handles.selSecondimage.Visible = 'On';
handles.cByC.Visible = 'Off';
handles.bIma1.Visible = 'On';
handles.bIma2.Visible = 'On';

% Mean
handles.p1.Visible = 'Off';
handles.p1.String = {'3';'5';'7';'9';'11'};
handles.maskSize.Visible = 'Off';
%Median
handles.MedianType.Visible = 'Off';
handles.ButtonMedianType.Visible = 'Off';
% Gaussian, Only Mask Size
% Laplacian
handles.LaplacianType.Visible = 'Off';
handles.LaplaType.Visible = 'Off';
% Difference
handles.DiffMask.Visible = 'Off';
handles.DiffType.Visible = 'Off';

% Crop
handles.UpLeftCol.Visible = 'Off';
handles.UpLeftRow.Visible = 'Off';
handles.Width.Visible = 'Off';
handles.Height.Visible = 'Off';
handles.popCcol.Visible = 'Off';
handles.popCcol.String = {'1';'8';'16';'32';'64';'128';'256';'512'};
handles.popCrow.Visible = 'Off';
handles.popCrow.String = {'1';'8';'16';'32';'64';'128';'256';'512'};
handles.popCwid.Visible = 'Off';
handles.popCwid.String = {'1';'8';'16';'32';'64';'100';'128';'256';'512'};
handles.popChei.Visible = 'Off';
handles.popChei.String = {'1';'8';'16';'32';'64';'100';'128';'256';'512'};

% Zoom
handles.By.Visible = 'Off';
handles.popCfac.Visible = 'Off';
handles.popBmet.Visible = 'Off';

% Grey Level Quant
handles.popGquant.Visible = 'Off';
handles.NumGrayLevel.Visible = 'Off';
handles.popNgray.Visible = 'Off';

%Spat Quant
handles.WidSpat.Visible = 'Off';
handles.popRwid.Visible = 'Off';
handles.HeiSpat.Visible = 'Off';
handles.popRhei.Visible = 'Off';
handles.MetSpat.Visible = 'Off';
handles.popMSpa.Visible = 'Off';

% HistEqual

handles.popHistEqu.Visible = 'Off';
handles.OnBand.Visible = 'Off';

% Hist Stretch
handles.LowLim.Visible = 'Off';
handles.HighLim.Visible = 'Off';
handles.popLLim.Visible = 'Off';
handles.popLLim.String = {'0';'1';'10';'20';'30';'40';'50';'75';'100'};
handles.popHLim.Visible = 'Off';
handles.popHLim.String = {'10';'20';'30';'40';'50';'75';'100';'200';'254';'255'};
handles.LowClipPer.Visible = 'Off';
handles.HighClipPer.Visible = 'Off';
handles.popLClip.Visible = 'Off';
handles.popLClip.String = {'0.01';'0.02';'0.025';'0.03';'0.04';'0.05';'0.075';'0.1';'0.15'};
handles.popHClip.Visible = 'Off';
handles.popHClip.String = {'0.01';'0.02';'0.025';'0.03';'0.04';'0.05';'0.075';'0.1';'0.15'};
handles.text27.Visible = 'Off';


handles.text41.Visible = 'Off';
handles.text44.Visible = 'Off';
handles.text45.Visible = 'Off';
handles.popRwid.Visible = 'Off';
handles.popRwid.String = {'32';'64';'128';'256'};
handles.popRhei.Visible = 'Off';
handles.popRhei.String = {'32';'64';'128';'256'};
handles.popMSpa.Visible = 'Off';
handles.popMSpa.String = {'Average Value';'Median Value';'Decimation'};

handles.Standard.Visible = 'Off';
handles.Adaptive.Visible = 'Off';
handles.radiobutton43.Visible = 'Off';
handles.radiobutton44.Visible = 'Off';
handles.radiobutton45.Visible = 'Off';
handles.radiobutton46.Visible = 'Off';
handles.radiobutton47.Visible = 'Off';
handles.radiobutton48.Visible = 'Off';
handles.radiobutton49.Visible = 'Off';
handles.radiobutton50.Visible = 'Off';
handles.radiobutton50.String = 'Type 1';
handles.radiobutton51.Visible = 'Off';
handles.radiobutton51.String = 'Type 2';
handles.radiobutton52.Visible = 'Off';
handles.radiobutton52.String = 'Type 3';
handles.radiobutton53.Visible = 'Off';
handles.radiobutton54.Visible = 'Off';
handles.radiobutton55.Visible = 'Off';
handles.radiobutton56.Visible = 'Off';
handles.radiobutton57.Visible = 'Off';
handles.checkbox14.Visible = 'Off';
handles.EditMask.Visible = 'Off';
handles.EditMask.String = 'Edit Mask';
% for Difference
%handles for spatial filters
handles.bMean.Value = 0;
handles.bMedian.Value = 0;
handles.bGauss.Value = 0;
handles.bLap.Value = 0;
handles.bDiff.Value = 0;
%handles for Geometry
handles.bCrop.Value = 0;
handles.bZoom.Value = 0;
%handles for Quantization
handles.bGray.Value = 0;
handles.bSpaQ.Value = 0;
%handles for Histogram
handles.bHisEqu.Value = 0;
handles.bHisStre.Value = 0;



% --- Outputs from this function are returned to the command line.
function varargout = Preprocessing_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function showImages(handles, cpath, file)
    InIma = imastruc_cvip([cpath file]);
    %check if need to show function information
    hVfinfo = findobj('Tag','mVfi');    %get handle of menu view fun information
    if strcmp(hVfinfo(1).Checked,'on')
        if ~isa(InIma.fInfo.history_info,'char')
            histo = ['yes size= ' num2str(size(InIma.fInfo.history_info,1))];
        else
            histo = 'none';
        end
        hIlist = findobj('Tag','txtIlist');     %get handle of text element
        txtInfo = [{' '};{'Opening Image:'};{[InIma.fInfo.filename]};...
            {'Image Information:'};{['Mod. Date: ' InIma.fInfo.file_mod_date]};...
            {['Image Format: ' InIma.fInfo.image_format ', Color Format: ' ...
            InIma.fInfo.color_format]};{['Data Type: ' InIma.fInfo.cvip_type ...
            ', Data Format: ' InIma.fInfo.data_format]};{['Compression: ' ...
            InIma.fInfo.cmpr_format ', Rows: ' num2str(InIma.fInfo.no_of_rows)...
            ', Cols: ' num2str(InIma.fInfo.no_of_cols) ', Bands: ' ...
            num2str(InIma.fInfo.no_of_bands)]}; {['File Size: ' ...
            num2str(InIma.fInfo.file_size)]}; {['History: ' histo]}];

        for i=1:size(txtInfo,1)
            sInfo = txtInfo{i};                 %exract row to print
            hIlist.String(end+1,1:size(sInfo,2)) = sInfo;
        end
        hIlist.Value = size(hIlist.String,1);   %goto last line
        figure(handles.Main);
    end
    showgui_cvip(InIma, file);

% --------------------------------------------------------------------
function fOpen_Callback(hObject, eventdata, handles)
% hObject    handle to fOpen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% clc;
cpath = handles.fOpen.UserData;                   %recover image path
if cpath == 0
    cpath = mfilename( 'fullpath' );
    cpath = [cpath(1:end-15) 'Images'];
elseif isempty(cpath)
    cpath = mfilename( 'fullpath' );
    cpath = [cpath(1:end-15) 'Images'];
end

% [InIma, file, cpath] = open_image(cpath);   %open image file
%open file selection dialog box to input image
[file, cpath] = uigetfile({'*.*', 'All Files (*.*)';...
    '*.vipm','CVIPTools VIPM (*.vipm)';'*.bmp','Windows Bitmap (*.bmp)';...
    '*.tif','Tagged Image File (*.tif)'; '*.gif','Graphic Interchange (*.gif)'; ... 
     '*.jpg', 'JPEG/JPEG2000 (*.jpg)'; ...
    '*.png','Portable Network Graphics (*.png)'; '*.pbm ; *.ppm;*.pgm; *.pnm',...
    'Portable Image File (*.pbm,*.ppm,*.pgm, *.pnm)'}, ...
    'Select an input image file', 'MultiSelect','on',cpath); %mulitple file

%check if user has successfuly made the file selection
if ~isequal(file,0)
    if strcmp(class(file),'char')       %just one file selected
        showImages(handles, cpath, file);
    else
        for i=1:size(file,2)
            fileN = file{i};
            showImages(handles, cpath, fileN);
        end
    end
end

if cpath ~= 0
    handles.fOpen.UserData = cpath;                   %save new image path
end

% --------------------------------------------------------------------
function uifOPen_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uifOPen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hMain = findobj('Tag','Main');              %get the handle of Main form
% get handles and other user-defined data associated to Gui1
g1data = guidata(hMain);
if ~isempty(hMain)
    CVIPToolbox('fOpen_Callback',g1data.fOpen,eventdata,guidata(g1data.fOpen))
end

% --- Executes on button press in bCancel.
function bCancel_Callback(hObject, eventdata, handles)
% hObject    handle to bCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Prepare to close application window
close(handles.Preproc)

% --- Executes on button press in bReset.
function bReset_Callback(hObject, eventdata, handles)
% hObject    handle to bReset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% CODE CALLBACKS ORDER:
% - Buttons (bApply, bCancel, bReset, ...)
% - Radio Buttons (Options, choices)
% - Pop-up Men�s
% - Figure Callbacks (Resize, Click, ...)
% - Main Menus (fOpen, fSave)
% - Ui Main Menus (uiOpen, uiSave)
% - Menus (Others: View, Analysis, Compression...)


% --- Executes on button press in bApply.
function bApply_Callback(hObject, eventdata, handles)
% hObject    handle to bApply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% clc                             %clear screen

%changing pointer arrow to watch on cursor
figure_set = findall(groot,'Type','Figure');
set(figure_set,'pointer','watch');

hMain = findobj('Tag','Main');  %get the handle of Main form
hSHisto = findobj('Tag','mVsaveHis'); %get handle of Save history menu
hVfinfo = findobj('Tag','mVfi');    %get handle of menu view fun information
hNfig = hMain.UserData;         %get image handle
if hNfig == 0 || isempty(hNfig) || ~isfield(hNfig.UserData,'cvipIma')
    errordlg('Please select the image to Process', 'Filter Error', 'modal');
else
Ima=hNfig.UserData;             %Get image information
InIma = Ima.cvipIma;            %read image data
file = get(hNfig,'Name');       %get image name
histo = 0; OutIma = 0;          %initial vbles values

if handles.bAdd.Value||handles.bSub.Value||handles.bMul.Value||handles.bDiv.Value||handles.bAnd.Value||handles.bNOT.Value||...
        handles.bOr.Value||handles.bXor.Value
%for arithmatic

        Ima1 = handles.bIma1.UserData;       %get image handle
        hNfig2 = handles.bIma2.UserData;    %get image handle
        %check for Image to process
        if isempty(Ima1) && ~isfield(Ima1,'cvipIma') 
            errordlg(['There is nothing to process. Please select an Image and '...
                'try again.'],'Arith/Logic Error','modal'); 
        %check if a second image is required
        elseif ~handles.cByC.Value && isempty(hNfig2)
            warndlg(['This operation requires 2 Images. Select a 2nd'...
                        ' Image and try again!'],'Arith/Logic Warning','modal');
                    else
            if handles.cByC.Value           %get constant value
                if handles.bMul.Value || handles.bDiv.Value
                    InIma2 = str2double(handles.popMCons.String(handles.popMCons.Value));
                else
                    InIma2 = str2double(handles.popCons.String(handles.popCons.Value));
                end
                file2 = num2str(InIma2);    %second image name
                va = InIma2;                %value for history
            else                            %2 images operation
                InIma2=hNfig2.cvipIma;      %get 2nd image
                file2=handles.selSecondimage.String;%second image name
                va = -1;                    %value for history         
            end

            InIma1 = Ima1.cvipIma;           %read image data
            file1=handles.selFirstimage.String;   %get file name
        end

        %IMAGE OPERATIONS

        %perform image operations arithmatic
            if handles.bAdd.Value                       %perform Add 
                OutIma = add_cvip(InIma1, InIma2);      %call Add function
                Name=strcat(file1,' > Add > ', file2);  %create image name
                histo = [001 va];                       %update image history

            elseif handles.bSub.Value                   %perform Subtraction
                OutIma = subtract_cvip(InIma1, InIma2); %call Sub function
                Name=strcat(file1,' > Sub > ', file2);  %create image name
                histo = [002 va];                       %update image history

            elseif handles.bMul.Value                   %perform Multiplication
                OutIma = multiply_cvip(InIma1, InIma2); %call Mul function
                Name=strcat(file1,' > Mul > ', file2);  %create image name
                histo = [004 va];                       %update image history

            elseif handles.bDiv.Value                   %perform Division
                OutIma = divide_cvip(InIma1, InIma2);   %call Div function
                Name=strcat(file1,' > Div > ', file2);  %create image name
                histo = [006 va];                       %update image history

            elseif handles.bAnd.Value                   %perform And 
                OutIma = and_cvip(InIma1, InIma2);      %call And function
                Name=strcat(file1,' > AND > ', file2);  %create image name
                histo = [003 va];                       %update image history

            elseif handles.bNOT.Value                   %perform NOT
                OutIma = not_cvip(InIma1);              %call NOT function
                Name=strcat(file1,' > NOT >');          %create image name
                histo = [005 va];                       %update image history
                if handles.cNotB.Value
                    OutIma2 = not_cvip(InIma2);         %call NOT function
                    Name2=strcat(file2,' > NOT >');     %create image name
                    hNfig2.cvipIma = OutIma2;           %update image info
                    showgui_cvip(hNfig2, Name2);        %show image in viewer
                end
            elseif handles.bOr.Value                    %perform Or
                OutIma = or_cvip(InIma1, InIma2);       %call Or function
                Name=strcat(file1,' > OR > ', file2);   %create image name
                histo = [008 va];                       %update image history

            elseif handles.bXor.Value                   %perform Xor
                OutIma = xor_cvip(InIma1, InIma2);      %call Xor function
                Name=strcat(file1,' > XOR > ', file2);  %create image name
                histo = [007 va];                       %update image history

            end

elseif handles.bMean.Value||handles.bMedian.Value||handles.bGauss.Value||handles.bLap.Value||handles.bDiff.Value    
        %mean filter
        if handles.bMean.Value
            mask_size = str2double(handles.p1.String(handles.p1.Value));
            OutIma = arithmetic_mean_cvip(InIma,mask_size);
            Name = strcat(file, ' > Mean(',num2str(mask_size),'x',num2str(mask_size));


        %median filter
        elseif handles.bMedian.Value
            mask_size = str2double(handles.p1.String(handles.p1.Value));
            if handles.Standard.Value       
                OutIma = median_filter_cvip(InIma,mask_size);
                type = 'Stand';
            elseif handles.Adaptive.Value
                OutIma = adapt_median_filter_cvip(InIma,mask_size);
                type = 'Adapt';
            end
            Name = strcat(file, ' > ',type,'Median(',num2str(mask_size),'x',num2str(mask_size));
        %guassian filter
        elseif handles.bGauss.Value
            mask_size = str2double(handles.p1.String(handles.p1.Value));
            Mask = h_image_cvip(3,mask_size,mask_size);
            OutIma = convolve_filter_cvip(InIma,Mask);
            Name = strcat(file, ' > Guassian(',num2str(mask_size),'x',num2str(mask_size));


        % laplasian
        elseif handles.bLap.Value==1 
            if handles.LaplaType.Value==1
                handles.Mask.Data = [0.00,-1.00,0.00;-1.00,4.00,-1.00;0.00,-1.00,0.00]
        %     end%Laplacian filtering
            elseif handles.LaplaType.Value==2
                handles.Mask.Data = [1.00,-2.00,1.00;-2.00,4.00,-2.00;1.00,-2.00,1.00]
            elseif handles.LaplaType.Value==3
                handles.Mask.Data = [-1.00,-1.00,-1.00;-1.00,8.00,-1.00;-1.00,-1.00,-1.00]
            end%Laplacian filtering
            Mask = handles.Mask.Data;
            OutIma = convolve_filter_cvip(InIma,Mask);
            %update image history
            histo = 202;
            Name=strcat(file,' > LaplaceFilt(',num2str(handles.LaplaType.Value),')');

            %Difference filtering
        elseif handles.bDiff.Value==1  	

            if handles.DiffType.Value==1
                handles.Mask.Data = [0.00,1.00,0.00;0.00,1.00,0.00;0.00,-1.00,0.00]
                mSize = 'Vertical';
            elseif handles.DiffType.Value==2
                handles.Mask.Data = [0.00,0.00,0.00;1.00,1.00,-1.00;0.00,0.00,0.00]
                mSize = 'Horizontal';
            elseif handles.DiffType.Value==3
                handles.Mask.Data = [1.00,0.00,0.00;0.00,1.00,0.00;-1.00,0.00,0.00]
                mSize = 'Diagonal_1';
            elseif handles.DiffType.Value==4
                handles.Mask.Data = [0.00,0.00,1.00;0.00,1.00,0.00;-1.00,0.00,0.00]
                mSize = 'Diagonal_2';
            end
            Mask = handles.Mask.Data;
            OutIma = convolve_filter_cvip(InIma,Mask);
            OutIma = subtract_cvip(OutIma, InIma);
            %update image history
            histo = 202;
            Name=strcat(file,' > DiffFilt(',mSize,')'); 
        end

elseif handles.bCrop.Value||handles.bZoom.Value 
        % Crop  Zoom
        [row,col,band]=size(InIma);         %size of input image
        if handles.bCrop.Value              %perform Hist Stretch
            %capture parameters from GUI
            cCol = str2double(handles.popCcol.String(handles.popCcol.Value));
            cRow = str2double(handles.popCrow.String(handles.popCrow.Value));
            cWidth = str2double(handles.popCwid.String(handles.popCwid.Value));
            cHeight = str2double(handles.popChei.String(handles.popChei.Value));
            if cCol > col || cRow > row
               errordlg('Selected Row and Column are beyond Image size', ...
                   'Size Error', 'modal');
            elseif cCol+cWidth > col || cRow+cHeight > row
               Ans = questdlg(['Width or Height are bigger than image size. ' ...
                   'Do you want to continue?'],'Size Warning','Continue', ...
                   'Cancel','Cancel');
               if strcmp(Ans,'Continue')
                    %call crop function
                    OutIma = crop_cvip(InIma, [cHeight cWidth], [cRow cCol]);
               end

            else
                %call crop function
                OutIma = crop_cvip(InIma, [cHeight cWidth], [cRow cCol]);
            end
            %name and show image
            Name = strcat(file,' > Crop (',num2str(cCol),',',num2str(cCol),')(',...
                num2str(cWidth),'-',num2str(cHeight),')');
            %update image history
            histo = [62 cHeight cWidth cCol cCol];     %update image history


        elseif handles.bZoom.Value 

            %capture parameters from GUI
            cCol = str2double(handles.popCcol.String(handles.popCcol.Value));
            cRow = str2double(handles.popCrow.String(handles.popCrow.Value));
            cWidth = str2double(handles.popCwid.String(handles.popCwid.Value));
            cHeight = str2double(handles.popChei.String(handles.popChei.Value));
            cfactor = str2double(handles.popCfac.String(handles.popCfac.Value));
            Met=handles.popBmet.Value;
            if cCol > col || cRow > row
               errordlg('Selected Row and Column are beyond Image size', ...
                   'Size Error', 'modal');
            elseif cCol+cWidth > col || cRow+cHeight > row
               Ans = questdlg(['Width or Height are bigger than image size. ' ...
                   'Do you want to continue?'],'Size Warning','Continue', ...
                   'Cancel','Cancel');
               if strcmp(Ans,'Continue')
            %call zoom function
                    OutIma = zoom_cvip( InIma, 'def', cfactor, Met-1, [cRow cCol], [cWidth cHeight])
               end
                else
                %call crop function
                OutIma = zoom_cvip( InIma, 'def', cfactor, Met-1, [cCol cRow ], [cHeight cWidth ])
            end
            %name and show image
            Name = strcat(file,' > Zoom (',num2str(cCol),',',num2str(cCol),')(',...
                num2str(cWidth),'-',num2str(cHeight),')');
            %update image history
            histo = [62 cHeight cWidth cCol cCol];     %update image history

        end

elseif handles.bGray.Value||handles.bSpaQ.Value

% Grey Level Quantization
if handles.bGray.Value==1           %perform Gray quantization
    Quanti = handles.popGquant.Value;   %get selected method
    Gray  = str2double(handles.popNgray.String(handles.popNgray.Value));

    if Quanti == 1                      %standard gray
        OutIma = gray_quant_cvip(InIma, Gray);
        histo = [173 Gray];            	%update image history
        Name = strcat(file, ' > GrayQuant (Std-',num2str(Gray),') ');
    else                                %IGS gray quant
        OutIma = igs_cvip(InIma, Gray);
        histo = [175 Gray];            	%update image history
        Name = strcat(file, ' > GrayQuant (IGS-',num2str(Gray),') ');
    end
    
% Spat Quantization    
elseif handles.bSpaQ.Value
    %returns resize width
    Col=str2double(handles.popRwid.String(handles.popRwid.Value)); 
    %returns returns Height
    Row=str2double(handles.popRhei.String(handles.popRhei.Value)); 
    Met=handles.popMSpa.Value;           %returns returns Height
    if (Row <= row) && (Col <= col)  	%Reduce image with spatial quant
        %call spatial quant function
        OutIma=spatial_quant_cvip(InIma, Row, Col, Met);
        %update image history
        histo = [066 Row Col Met];              %update image history
        switch Met
            case 1
                Name=strcat(file,' > Resize - Spa.Quan.(Avg)');
            case 2
                Name=strcat(file,' > Resize - Spa.Quan.(Med)');
            case 3
                Name=strcat(file,' > Resize - Spa.Quan.(Dec)');
            case 4
                Name=strcat(file,' > Resize - Spa.Quan.(Max)');
            case 5
                Name=strcat(file,' > Resize - Spa.Quan.(Min)');
        end
    else
        errordlg(['Spatial Quantization is to reduce image size. Check ' ...
           'desired size and try again!.'],'Size Error', 'modal');
    end
end

elseif handles.bHisEqu.Value||handles.bHisStre.Value
% Hist Equalization
if handles.bHisEqu.Value==1        	%Histogram Equalization
    Method = handles.popHistEqu.Value; 	%get selected method
    if size(InIma,3) == 1
        OutIma = histeq_cvip(InIma,0); 	%call function
        Func = 'HistEquGray';
        %update image history
        histo = [73 1];
    else
        switch Method
            case 1             %lightness
            OutIma = rgb2hsl_cvip(InIma,1);%convert to hsl OutIma(1:10)
            Light = OutIma(:,:,3);%extract lightness
            Light = histeq_cvip(floor(Light*255),0);%call function
            OutIma(:,:,3) = double(Light)/255;%assemble new light band
            OutIma = uint8(hsl2rgb_cvip(OutIma,1)*255);%call function
            Func = 'HistEquL'; 	%image function for image name
            %update image history
            histo = [22 1; 10 3; 73 1; 9 3; 14 1];
            
            case 2              %equalize red band
            OutIma = (histeq_cvip(InIma,0));%call function
            Func = 'HistEquR';
            %update image history
            histo = [73 1];
            
            case 3              %equalize green band
            OutIma = (histeq_cvip(InIma,1));%call function
            Func = 'HistEquG';
            %update image history
            histo = [73 2];
            
            case 4              %equalize blue band
            OutIma = (histeq_cvip(InIma,2));%call function
            Func = 'HistEquB';
            %update image history
            histo = [73 3];
            
        end
    end
    Name = strcat(file,' > ',Func);
    
    elseif handles.bHisStre.Value==1           %perform Gray quantization
    %get low gray level value
    Low=str2double(handles.popLLim.String(handles.popLLim.Value));
    %get high gray level value
    High=str2double(handles.popHLim.String(handles.popHLim.Value));
    %get low clip % value
    lClip=str2double(handles.popLClip.String(handles.popLClip.Value));
    %get high clip %  value
    hClip=str2double(handles.popHClip.String(handles.popHClip.Value));
    OutIma=hist_stretch_cvip(InIma,Low,High,lClip,hClip);   %call function
    %update image history
    histo = [79 Low High lClip hClip];
    Func = 'HistStre';
    Name=strcat(file,' > ',Func,'(',num2str(Low),',',num2str(High),...
        ',',num2str(lClip),',',num2str(hClip),')'); 
end
end

%END OF IMAGE OPERATIONS

if sum(histo) ~= 0
%check if need to save history
if strcmp(hSHisto(1).Checked,'on')              %save new image history
    Ima.fInfo.history_info = historyupdate_cvip(Ima.fInfo.history_info,histo);  
end
%check if need to show function information
if strcmp(hVfinfo(1).Checked,'on')
    hIlist = findobj('Tag','txtIlist');         %get handle of text element
    hIlist.String(end+1,1)=' ';                 %print an empty line
    txtInfo = historydeco_cvip(histo);     
    hIlist.String(end+1,1:size(file,2)+1)=[file ':']; 
    for i=1:size(txtInfo)
        sInfo = txtInfo{i};                     %extract row to print
        sInfo = sprintf(sInfo);
        [~,rr] = size(sInfo);
        hIlist.String(end+1,1:rr) = sInfo;
    end
    hIlist.Value = size(hIlist.String,1);       %goto last line
    figure(hMain);
end

end
if size(OutIma,1) > 3
    [row,col,band]=size(OutIma);                    %get new image size
    %update image information
    Ima.fInfo.no_of_bands=band;             
    Ima.fInfo.no_of_cols=col;              
    Ima.fInfo.no_of_rows=row;
    %update image structure
    Ima.cvipIma = OutIma;                           %read image data
    showgui_cvip(Ima, Name);                        %show image in viewer
end

end

%changing pointer watch back to arrow on cursor
set(figure_set,'pointer','arrow');


% --------------------------------------------------------------------

% --------------------------------------------------------------------
function fSave_Callback(hObject, eventdata, handles)
% hObject    handle to fSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hMain = findobj('Tag','Main');              %get the handle of Main form
% get handles and other user-defined data associated to Gui1
g1data = guidata(hMain);
if ~isempty(hMain)
    CVIPToolbox('fSave_Callback',g1data.fSave,eventdata,guidata(g1data.fSave))
end

% --------------------------------------------------------------------
function uiOpenIma_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uiOpenIma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hMain = findobj('Tag','Main');              %get the handle of Main form
% get handles and other user-defined data associated to Gui1
g1data = guidata(hMain);
if ~isempty(hMain)
    CVIPToolbox('fOpen_Callback',g1data.fOpen,eventdata,guidata(g1data.fOpen))
end

% --------------------------------------------------------------------
function uiSaveIma_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uiSaveIma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hMain = findobj('Tag','Main');              %get the handle of Main form
% get handles and other user-defined data associated to Gui1
g1data = guidata(hMain);
if ~isempty(hMain)
    CVIPToolbox('fSave_Callback',g1data.fSave,eventdata,guidata(g1data.fSave))
end

% --------------------------------------------------------------------
function mFile_Callback(hObject, eventdata, handles)
% hObject    handle to mFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mAna_Callback(hObject, eventdata, handles)
% hObject    handle to mAna (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mGeo_Callback(hObject, eventdata, handles)
% hObject    handle to mGeo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CVIPToolbox('mGeo_Callback',hObject,eventdata,guidata(hObject))

% --------------------------------------------------------------------
function mEdge_Callback(hObject, eventdata, handles)
% hObject    handle to mEdge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CVIPToolbox('mEdge_Callback',hObject,eventdata,guidata(hObject))

% --------------------------------------------------------------------
function mSeg_Callback(hObject, eventdata, handles)
% hObject    handle to mSeg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CVIPToolbox('mSeg_Callback',hObject,eventdata,guidata(hObject))

% --------------------------------------------------------------------
function mTrans_Callback(hObject, eventdata, handles)
% hObject    handle to mTrans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CVIPToolbox('mTrans_Callback',hObject,eventdata,guidata(hObject))

% --------------------------------------------------------------------
function mFeat_Callback(hObject, eventdata, handles)
% hObject    handle to mFeat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CVIPToolbox('mFeat_Callback',hObject,eventdata,guidata(hObject))

% --------------------------------------------------------------------
function mPatt_Callback(hObject, eventdata, handles)
% hObject    handle to mPatt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CVIPToolbox('mPatt_Callback',hObject,eventdata,guidata(hObject))


% --- Executes during object creation, after setting all properties.
function Preprocessing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Preprocessing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes on button press in bMean.
function bMean_Callback(hObject, eventdata, handles)
% hObject    handle to bMean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Arithmatic
handles.curImage.Visible = 'Off';
handles.secImage.Visible = 'Off';
handles.selFirstimage.Visible = 'Off';
handles.selSecondimage.Visible = 'Off';
handles.cByC.Visible = 'Off';
handles.bIma1.Visible = 'Off';
handles.bIma2.Visible = 'Off';


%handles for arithmatic/logic
handles.bAdd.Value = 0;
handles.bSub.Value = 0;
handles.bMul.Value = 0;
handles.bDiv.Value = 0;
handles.bAnd.Value = 0;
handles.bNOT.Value = 0;
handles.bOr.Value = 0;
handles.bXor.Value = 0;

% Mean
handles.bMean.Value = 1;
handles.p1.Visible = 'On';
handles.p1.String = {'3';'5';'7';'9';'11'};
handles.maskSize.Visible = 'On';
%Median
handles.MedianType.Visible = 'Off';
handles.ButtonMedianType.Visible = 'Off';
% Gaussian, Only Mask Size
% Laplacian
handles.LaplacianType.Visible = 'Off';
handles.LaplaType.Visible = 'Off';
% Difference
handles.DiffMask.Visible = 'Off';
handles.DiffType.Visible = 'Off';

% Crop
handles.UpLeftCol.Visible = 'Off';
handles.UpLeftRow.Visible = 'Off';
handles.Width.Visible = 'Off';
handles.Height.Visible = 'Off';
handles.popCcol.Visible = 'Off';
handles.popCcol.String = {'0';'8';'16';'32';'64';'128';'256';'512'};
handles.popCrow.Visible = 'Off';
handles.popCrow.String = {'0';'8';'16';'32';'64';'128';'256';'512'};
handles.popCwid.Visible = 'Off';
handles.popCwid.String = {'0';'8';'16';'32';'64';'100';'128';'256';'512'};
handles.popChei.Visible = 'Off';
handles.popChei.String = {'0';'8';'16';'32';'64';'100';'128';'256';'512'};

% Zoom

handles.By.Visible = 'Off';
handles.popCfac.Visible = 'Off';
handles.popBmet.Visible = 'Off';

% Grey Level Quant
handles.popGquant.Visible = 'Off';
handles.NumGrayLevel.Visible = 'Off';
handles.popNgray.Visible = 'Off';

%Spat Quant
handles.WidSpat.Visible = 'Off';
handles.popRwid.Visible = 'Off';
handles.HeiSpat.Visible = 'Off';
handles.popRhei.Visible = 'Off';
handles.MetSpat.Visible = 'Off';
handles.popMSpa.Visible = 'Off';

% HistEqual

handles.popHistEqu.Visible = 'Off';
handles.OnBand.Visible = 'Off';

% Hist Stretch
handles.LowLim.Visible = 'Off';
handles.HighLim.Visible = 'Off';
handles.popLLim.Visible = 'Off';
handles.popLLim.String = {'0';'1';'10';'20';'30';'40';'50';'75';'100'};
handles.popHLim.Visible = 'Off';
handles.popHLim.String = {'10';'20';'30';'40';'50';'75';'100';'200';'254';'255'};
handles.LowClipPer.Visible = 'Off';
handles.HighClipPer.Visible = 'Off';
handles.popLClip.Visible = 'Off';
handles.popLClip.String = {'0.01';'0.02';'0.025';'0.03';'0.04';'0.05';'0.075';'0.1';'0.15'};
handles.popHClip.Visible = 'Off';
handles.popHClip.String = {'0.01';'0.02';'0.025';'0.03';'0.04';'0.05';'0.075';'0.1';'0.15'};
handles.text27.Visible = 'Off';


handles.text41.Visible = 'Off';
handles.text44.Visible = 'Off';
handles.text45.Visible = 'Off';
handles.popRwid.Visible = 'Off';
handles.popRwid.String = {'32';'64';'128';'256'};
handles.popRhei.Visible = 'Off';
handles.popRhei.String = {'32';'64';'128';'256'};
handles.popMSpa.Visible = 'Off';
handles.popMSpa.String = {'Average Value';'Median Value';'Decimation'};

handles.Standard.Visible = 'Off';
handles.Adaptive.Visible = 'Off';
handles.radiobutton43.Visible = 'Off';
handles.radiobutton44.Visible = 'Off';
handles.radiobutton45.Visible = 'Off';
handles.radiobutton46.Visible = 'Off';
handles.radiobutton47.Visible = 'Off';
handles.radiobutton48.Visible = 'Off';
handles.radiobutton49.Visible = 'Off';
handles.radiobutton50.Visible = 'Off';
handles.radiobutton50.String = 'Type 1';
handles.radiobutton51.Visible = 'Off';
handles.radiobutton51.String = 'Type 2';
handles.radiobutton52.Visible = 'Off';
handles.radiobutton52.String = 'Type 3';
handles.radiobutton53.Visible = 'Off';
handles.radiobutton54.Visible = 'Off';
handles.radiobutton55.Visible = 'Off';
handles.radiobutton56.Visible = 'Off';
handles.radiobutton57.Visible = 'Off';
handles.checkbox14.Visible = 'Off';
handles.EditMask.Visible = 'Off';
handles.EditMask.String = 'Edit Mask';
% for Difference
%handles for spatial filters
handles.bMedian.Value = 0;
handles.bGauss.Value = 0;
handles.bLap.Value = 0;
handles.bDiff.Value = 0;
%handles for Geometry
handles.bCrop.Value = 0;
handles.bZoom.Value = 0;
%handles for Quantization
handles.bGray.Value = 0;
handles.bSpaQ.Value = 0;
%handles for Histogram
handles.bHisEqu.Value = 0;
handles.bHisStre.Value = 0;

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in selSecondimage.
function selSecondimage_Callback(hObject, eventdata, handles)
% hObject    handle to selSecondimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns selSecondimage contents as cell array
%        contents{get(hObject,'Value')} returns selected item from selSecondimage


% --- Executes during object creation, after setting all properties.
function selSecondimage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selSecondimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popCcol.
function popCcol_Callback(hObject, eventdata, handles)
% hObject    handle to popCcol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popCcol contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popCcol


% --- Executes during object creation, after setting all properties.
function popCcol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popCcol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popCrow.
function popCrow_Callback(hObject, eventdata, handles)
% hObject    handle to popCrow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popCrow contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popCrow


% --- Executes during object creation, after setting all properties.
function popCrow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popCrow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popCwid.
function popCwid_Callback(hObject, eventdata, handles)
% hObject    handle to popCwid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popCwid contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popCwid


% --- Executes during object creation, after setting all properties.
function popCwid_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popCwid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popChei.
function popChei_Callback(hObject, eventdata, handles)
% hObject    handle to popChei (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popChei contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popChei


% --- Executes during object creation, after setting all properties.
function popChei_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popChei (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in p1.
function p1_Callback(hObject, eventdata, handles)
% hObject    handle to p1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns p1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from p1


% --- Executes during object creation, after setting all properties.
function p1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popLLim.
function popLLim_Callback(hObject, eventdata, handles)
% hObject    handle to popLLim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popLLim contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popLLim


% --- Executes during object creation, after setting all properties.
function popLLim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popLLim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popHLim.
function popHLim_Callback(hObject, eventdata, handles)
% hObject    handle to popHLim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popHLim contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popHLim


% --- Executes during object creation, after setting all properties.
function popHLim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popHLim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popLClip.
function popLClip_Callback(hObject, eventdata, handles)
% hObject    handle to popLClip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popLClip contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popLClip


% --- Executes during object creation, after setting all properties.
function popLClip_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popLClip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popHClip.
function popHClip_Callback(hObject, eventdata, handles)
% hObject    handle to popHClip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popHClip contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popHClip


% --- Executes during object creation, after setting all properties.
function popHClip_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popHClip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popNgray.
function popNgray_Callback(hObject, eventdata, handles)
% hObject    handle to popNgray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popNgray contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popNgray


% --- Executes during object creation, after setting all properties.
function popNgray_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popNgray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popRwid.
function popRwid_Callback(hObject, eventdata, handles)
% hObject    handle to popRwid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popRwid contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popRwid


% --- Executes during object creation, after setting all properties.
function popRwid_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popRwid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popRhei.
function popRhei_Callback(hObject, eventdata, handles)
% hObject    handle to popRhei (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popRhei contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popRhei


% --- Executes during object creation, after setting all properties.
function popRhei_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popRhei (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popMSpa.
function popMSpa_Callback(hObject, eventdata, handles)
% hObject    handle to popMSpa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popMSpa contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popMSpa


% --- Executes during object creation, after setting all properties.
function popMSpa_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popMSpa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bMedian.
function bMedian_Callback(hObject, eventdata, handles)
% hObject    handle to bMedian (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Arithmatic
handles.curImage.Visible = 'Off';
handles.secImage.Visible = 'Off';
handles.selFirstimage.Visible = 'Off';
handles.selSecondimage.Visible = 'Off';
handles.cByC.Visible = 'Off';
handles.bIma1.Visible = 'Off';
handles.bIma2.Visible = 'Off';
handles.bAdd.Value = 0;
handles.bSub.Value = 0;
handles.bMul.Value = 0;
handles.bDiv.Value = 0;
handles.bAnd.Value = 0;
handles.bNOT.Value = 0;
handles.bOr.Value = 0;
handles.bXor.Value = 0;

% Mean
handles.bMean.Value = 0;
handles.p1.Visible = 'On';
handles.p1.String = {'3';'5';'7';'9';'11'};
handles.maskSize.Visible = 'On';

%Median
handles.bMedian.Value = 1;
handles.MedianType.Visible = 'On';
handles.ButtonMedianType.Visible = 'On';
handles.Standard.Visible = 'On';
handles.Adaptive.Visible = 'On';
% Gaussian, Only Mask Size
% Laplacian
handles.LaplacianType.Visible = 'Off';
handles.LaplaType.Visible = 'Off';
% Difference
handles.DiffMask.Visible = 'Off';
handles.DiffType.Visible = 'Off';

% Crop
handles.UpLeftCol.Visible = 'Off';
handles.UpLeftRow.Visible = 'Off';
handles.Width.Visible = 'Off';
handles.Height.Visible = 'Off';
handles.popCcol.Visible = 'Off';
handles.popCcol.String = {'0';'8';'16';'32';'64';'128';'256';'512'};
handles.popCrow.Visible = 'Off';
handles.popCrow.String = {'0';'8';'16';'32';'64';'128';'256';'512'};
handles.popCwid.Visible = 'Off';
handles.popCwid.String = {'0';'8';'16';'32';'64';'100';'128';'256';'512'};
handles.popChei.Visible = 'Off';
handles.popChei.String = {'0';'8';'16';'32';'64';'100';'128';'256';'512'};

% Zoom

handles.By.Visible = 'Off';
handles.popCfac.Visible = 'Off';
handles.popBmet.Visible = 'Off';

% Grey Level Quant
handles.popGquant.Visible = 'Off';
handles.NumGrayLevel.Visible = 'Off';
handles.popNgray.Visible = 'Off';

%Spat Quant
handles.WidSpat.Visible = 'Off';
handles.popRwid.Visible = 'Off';
handles.HeiSpat.Visible = 'Off';
handles.popRhei.Visible = 'Off';
handles.MetSpat.Visible = 'Off';
handles.popMSpa.Visible = 'Off';

% HistEqual

handles.popHistEqu.Visible = 'Off';
handles.OnBand.Visible = 'Off';

% Hist Stretch
handles.LowLim.Visible = 'Off';
handles.HighLim.Visible = 'Off';
handles.popLLim.Visible = 'Off';
handles.popLLim.String = {'0';'1';'10';'20';'30';'40';'50';'75';'100'};
handles.popHLim.Visible = 'Off';
handles.popHLim.String = {'10';'20';'30';'40';'50';'75';'100';'200';'254';'255'};
handles.LowClipPer.Visible = 'Off';
handles.HighClipPer.Visible = 'Off';
handles.popLClip.Visible = 'Off';
handles.popLClip.String = {'0.01';'0.02';'0.025';'0.03';'0.04';'0.05';'0.075';'0.1';'0.15'};
handles.popHClip.Visible = 'Off';
handles.popHClip.String = {'0.01';'0.02';'0.025';'0.03';'0.04';'0.05';'0.075';'0.1';'0.15'};
handles.text27.Visible = 'Off';


handles.text41.Visible = 'Off';
handles.text44.Visible = 'Off';
handles.text45.Visible = 'Off';
handles.popRwid.Visible = 'Off';
handles.popRwid.String = {'32';'64';'128';'256'};
handles.popRhei.Visible = 'Off';
handles.popRhei.String = {'32';'64';'128';'256'};
handles.popMSpa.Visible = 'Off';
handles.popMSpa.String = {'Average Value';'Median Value';'Decimation'};


handles.radiobutton43.Visible = 'Off';
handles.radiobutton44.Visible = 'Off';
handles.radiobutton45.Visible = 'Off';
handles.radiobutton46.Visible = 'Off';
handles.radiobutton47.Visible = 'Off';
handles.radiobutton48.Visible = 'Off';
handles.radiobutton49.Visible = 'Off';
handles.radiobutton50.Visible = 'Off';
handles.radiobutton50.String = 'Type 1';
handles.radiobutton51.Visible = 'Off';
handles.radiobutton51.String = 'Type 2';
handles.radiobutton52.Visible = 'Off';
handles.radiobutton52.String = 'Type 3';
handles.radiobutton53.Visible = 'Off';
handles.radiobutton54.Visible = 'Off';
handles.radiobutton55.Visible = 'Off';
handles.radiobutton56.Visible = 'Off';
handles.radiobutton57.Visible = 'On';
handles.checkbox14.Visible = 'Off';
handles.EditMask.Visible = 'Off';
handles.EditMask.String = 'Edit Mask';

% for Difference
%handles for spatial filters
handles.bGauss.Value = 0;
handles.bLap.Value = 0;
handles.bDiff.Value = 0;
%handles for Geometry
handles.bCrop.Value = 0;
handles.bZoom.Value = 0;
%handles for Quantization
handles.bGray.Value = 0;
handles.bSpaQ.Value = 0;
%handles for Histogram
handles.bHisEqu.Value = 0;
handles.bHisStre.Value = 0;

% Hint: get(hObject,'Value') returns toggle state of bMedian


% --- Executes on button press in bLap.
function bLap_Callback(hObject, eventdata, handles)
% hObject    handle to bLap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.LaplaType.Visible = 'On';
handles.curImage.Visible = 'Off';
handles.secImage.Visible = 'Off';
handles.maskSize.Visible = 'Off';
handles.maskSize.String = 'Off';
handles.selFirstimage.Visible = 'Off';
handles.bIma1.Visible = 'Off';
handles.bIma2.Visible = 'Off';
handles.selSecondimage.Visible = 'Off';
handles.p1.Visible = 'Off';
handles.p1.String = {'3';'5';'7';'9';'11'};
handles.MedianType.Visible = 'Off';
handles.text27.Visible = 'Off';
handles.LaplacianType.Visible = 'On';
handles.DiffMask.Visible = 'Off';
handles.UpLeftCol.Visible = 'Off';
handles.UpLeftRow.Visible = 'Off';
handles.Width.Visible = 'Off';
handles.Height.Visible = 'Off';
handles.NumGrayLevel.Visible = 'Off';
handles.WidSpat.Visible = 'Off';
handles.HeiSpat.Visible = 'Off';
handles.MetSpat.Visible = 'Off';
handles.OnBand.Visible = 'Off';
handles.LowLim.Visible = 'Off';
handles.HighLim.Visible = 'Off';
handles.text41.Visible = 'Off';
handles.LowClipPer.Visible = 'Off';
handles.HighClipPer.Visible = 'Off';
handles.text44.Visible = 'Off';
handles.text45.Visible = 'Off';
handles.popCcol.Visible = 'Off';
handles.popCrow.Visible = 'Off';
handles.popCwid.Visible = 'Off';
handles.popChei.Visible = 'Off';
handles.popNgray.Visible = 'Off';
handles.popRwid.Visible = 'Off';
handles.popRhei.Visible = 'Off';
handles.popMSpa.Visible = 'Off';
handles.popLLim.Visible = 'Off';
handles.popHLim.Visible = 'Off';
handles.popLClip.Visible = 'Off';
handles.popHClip.Visible = 'Off';
handles.radiobutton43.Visible = 'Off';
handles.radiobutton44.Visible = 'Off';
handles.radiobutton45.Visible = 'Off';
handles.radiobutton46.Visible = 'Off';
handles.radiobutton47.Visible = 'Off';
handles.radiobutton48.Visible = 'Off';
handles.radiobutton49.Visible = 'Off';
handles.radiobutton50.Visible = 'On';
handles.radiobutton51.Visible = 'On';
handles.radiobutton52.Visible = 'On';
handles.radiobutton53.Visible = 'Off';
handles.radiobutton54.Visible = 'Off';
handles.radiobutton55.Visible = 'Off';
handles.radiobutton56.Visible = 'Off';
handles.radiobutton57.Visible = 'Off';
handles.checkbox14.Visible = 'Off';
handles.EditMask.Visible = 'On';
handles.EditMask.String = 'Edit Mask';
% for Difference
handles.DiffType.Visible = 'Off';
%handles for arithmatic/logic
handles.bAdd.Value = 0;
handles.bSub.Value = 0;
handles.bMul.Value = 0;
handles.bDiv.Value = 0;
handles.bAnd.Value = 0;
handles.bNOT.Value = 0;
handles.bOr.Value = 0;
handles.bXor.Value = 0;
%handles for geometry
handles.bCrop.Value = 0;
handles.bZoom.Value = 0;
%handles for Quantization
handles.bGray.Value = 0;
handles.bSpaQ.Value = 0;
%handles for Hisogram
handles.bHisEqu.Value = 0;
handles.bHisStre.Value = 0;

% Hint: get(hObject,'Value') returns toggle state of bLap


% --- Executes on button press in bGauss.
function bGauss_Callback(hObject, eventdata, handles)
% hObject    handle to bGauss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.Standard.Visible = 'Off';
handles.Adaptive.Visible = 'Off';
handles.Standard.Value = 0;
handles.Adaptive.Value = 0;
handles.curImage.Visible = 'Off';
handles.secImage.Visible = 'Off';
handles.maskSize.Visible = 'On';
handles.maskSize.String = 'Mask Size:';
handles.selFirstimage.Visible = 'Off';
handles.bIma1.Visible = 'Off';
handles.bIma2.Visible = 'Off';
handles.selSecondimage.Visible = 'Off';
handles.p1.Visible = 'On';
handles.p1.String = {'3';'5';'7';'9';'11'};
handles.MedianType.Visible = 'Off';
handles.text27.Visible = 'Off';
handles.LaplacianType.Visible = 'Off';
handles.DiffMask.Visible = 'Off';
handles.UpLeftCol.Visible = 'Off';
handles.UpLeftRow.Visible = 'Off';
handles.Width.Visible = 'Off';
handles.Height.Visible = 'Off';
handles.NumGrayLevel.Visible = 'Off';
handles.WidSpat.Visible = 'Off';
handles.HeiSpat.Visible = 'Off';
handles.MetSpat.Visible = 'Off';
handles.OnBand.Visible = 'Off';
handles.LowLim.Visible = 'Off';
handles.HighLim.Visible = 'Off';
handles.text41.Visible = 'Off';
handles.LowClipPer.Visible = 'Off';
handles.HighClipPer.Visible = 'Off';
handles.text44.Visible = 'Off';
handles.text45.Visible = 'Off';
handles.popCcol.Visible = 'Off';
handles.popCrow.Visible = 'Off';
handles.popCwid.Visible = 'Off';
handles.popChei.Visible = 'Off';
handles.popNgray.Visible = 'Off';
handles.popRwid.Visible = 'Off';
handles.popRhei.Visible = 'Off';
handles.popMSpa.Visible = 'Off';
handles.popLLim.Visible = 'Off';
handles.popHLim.Visible = 'Off';
handles.popLClip.Visible = 'Off';
handles.popHClip.Visible = 'Off';
handles.radiobutton43.Visible = 'Off';
handles.radiobutton44.Visible = 'Off';
handles.radiobutton45.Visible = 'Off';
handles.radiobutton46.Visible = 'Off';
handles.radiobutton47.Visible = 'Off';
handles.radiobutton48.Visible = 'Off';
handles.radiobutton49.Visible = 'Off';
handles.radiobutton50.Visible = 'Off';
handles.radiobutton50.String = 'Type 1';
handles.radiobutton51.Visible = 'Off';
handles.radiobutton51.String = 'Type 2';
handles.radiobutton52.Visible = 'Off';
handles.radiobutton52.String = 'Type 3';
handles.radiobutton53.Visible = 'Off';
handles.radiobutton54.Visible = 'Off';
handles.radiobutton55.Visible = 'Off';
handles.radiobutton56.Visible = 'Off';
handles.radiobutton57.Visible = 'Off';
handles.checkbox14.Visible = 'Off';
handles.EditMask.Visible = 'On';
% for median
handles.ButtonMedianType.Visible = 'Off';
% for Laplasian
handles.LaplaType.Visible = 'Off';
handles.EditMask.Visible = 'Off';
% for Difference
handles.DiffType.Visible = 'Off';
%handles for arithmatic/logic
handles.bAdd.Value = 0;
handles.bSub.Value = 0;
handles.bMul.Value = 0;
handles.bDiv.Value = 0;
handles.bAnd.Value = 0;
handles.bNOT.Value = 0;
handles.bOr.Value = 0;
handles.bXor.Value = 0;
%handles for geometry
handles.bCrop.Value = 0;
handles.bZoom.Value = 0;
%handles for Quantization
handles.bGray.Value = 0;
handles.bSpaQ.Value = 0;
%handles for Hisogram
handles.bHisEqu.Value = 0;
handles.bHisStre.Value = 0;

% Hint: get(hObject,'Value') returns toggle state of bGauss


% --- Executes on button press in bDiff.
function bDiff_Callback(hObject, eventdata, handles)
% hObject    handle to bDiff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.curImage.Visible = 'Off';
handles.secImage.Visible = 'Off';
handles.maskSize.Visible = 'Off';
handles.maskSize.String = 'Off';
handles.selFirstimage.Visible = 'Off';
handles.bIma1.Visible = 'Off';
handles.bIma2.Visible = 'Off';
handles.selSecondimage.Visible = 'Off';
handles.p1.Visible = 'Off';
handles.p1.String = {'3';'5';'7';'9';'11'};
handles.MedianType.Visible = 'Off';
handles.text27.Visible = 'On';
handles.LaplacianType.Visible = 'Off';
handles.DiffMask.Visible = 'On';
handles.DiffType.Visible = 'On';
handles.UpLeftCol.Visible = 'Off';
handles.UpLeftRow.Visible = 'Off';
handles.Width.Visible = 'Off';
handles.Height.Visible = 'Off';
handles.NumGrayLevel.Visible = 'Off';
handles.WidSpat.Visible = 'Off';
handles.HeiSpat.Visible = 'Off';
handles.MetSpat.Visible = 'Off';
handles.OnBand.Visible = 'Off';
handles.LowLim.Visible = 'Off';
handles.HighLim.Visible = 'Off';
handles.text41.Visible = 'Off';
handles.LowClipPer.Visible = 'Off';
handles.HighClipPer.Visible = 'Off';
handles.text44.Visible = 'Off';
handles.text45.Visible = 'Off';
handles.popCcol.Visible = 'Off';
handles.popCrow.Visible = 'Off';
handles.popCwid.Visible = 'Off';
handles.popChei.Visible = 'Off';
handles.popNgray.Visible = 'Off';
handles.popRwid.Visible = 'Off';
handles.popRhei.Visible = 'Off';
handles.popMSpa.Visible = 'Off';
handles.popLLim.Visible = 'Off';
handles.popHLim.Visible = 'Off';
handles.popLClip.Visible = 'Off';
handles.popHClip.Visible = 'Off';
handles.Stand.Visible = 'Off';
handles.radiobutton43.Visible = 'Off';
handles.radiobutton44.Visible = 'Off';
handles.radiobutton45.Visible = 'Off';
handles.radiobutton46.Visible = 'Off';
handles.radiobutton47.Visible = 'Off';
handles.radiobutton48.Visible = 'Off';
handles.radiobutton49.Visible = 'Off';
handles.radiobutton50.Visible = 'Off';
handles.radiobutton50.String = 'Type 1';
handles.radiobutton51.Visible = 'Off';
handles.radiobutton51.String = 'Type 2';
handles.radiobutton52.Visible = 'Off';
handles.radiobutton52.String = 'Type 3';
handles.radiobutton53.Visible = 'On';
handles.radiobutton54.Visible = 'On';
handles.radiobutton55.Visible = 'On';
handles.radiobutton56.Visible = 'On';
handles.radiobutton57.Visible = 'On';
handles.checkbox14.Visible = 'Off';
handles.EditMask.Visible = 'On';
handles.EditMask.String = 'Edit Mask';
% for median
handles.ButtonMedianType.Visible = 'Off';
% for Laplasian
handles.LaplaType.Visible = 'Off';
handles.EditMask.Visible = 'Off';
%handles for arithmatic/logic
handles.bAdd.Value = 0;
handles.bSub.Value = 0;
handles.bMul.Value = 0;
handles.bDiv.Value = 0;
handles.bAnd.Value = 0;
handles.bNOT.Value = 0;
handles.bOr.Value = 0;
handles.bXor.Value = 0;
%handles for geometry
handles.bCrop.Value = 0;
handles.bZoom.Value = 0;
%handles for Quantization
handles.bGray.Value = 0;
handles.bSpaQ.Value = 0;
%handles for Hisogram
handles.bHisEqu.Value = 0;
handles.bHisStre.Value = 0;

% Hint: get(hObject,'Value') returns toggle state of bDiff


% --- Executes on button press in checkbox14.
function checkbox14_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox14


% --- Executes on button press in bCrop.
function bCrop_Callback(hObject, eventdata, handles)
% hObject    handle to bCrop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Arithmatic
handles.curImage.Visible = 'Off';
handles.secImage.Visible = 'Off';
handles.selFirstimage.Visible = 'Off';
handles.selSecondimage.Visible = 'Off';
handles.cByC.Visible = 'Off';
handles.bIma1.Visible = 'Off';
handles.bIma2.Visible = 'Off';
handles.bAdd.Value = 0;
handles.bSub.Value = 0;
handles.bMul.Value = 0;
handles.bDiv.Value = 0;
handles.bAnd.Value = 0;
handles.bNOT.Value = 0;
handles.bOr.Value = 0;
handles.bXor.Value = 0;

% Mean
handles.bMean.Value = 0;
handles.p1.Visible = 'Off';
handles.p1.String = {'3';'5';'7';'9';'11'};
handles.maskSize.Visible = 'Off';

%Median
handles.bMedian.Value = 0;
handles.MedianType.Visible = 'Off';
handles.ButtonMedianType.Visible = 'Off';
handles.Standard.Visible = 'Off';
handles.Adaptive.Visible = 'Off';
% Gaussian, Only Mask Size
% Laplacian
handles.LaplacianType.Visible = 'Off';
handles.LaplaType.Visible = 'Off';
% Difference
handles.DiffMask.Visible = 'Off';
handles.DiffType.Visible = 'Off';

% Crop
handles.bCrop.Value = 1;
handles.UpLeftCol.Visible = 'On';
handles.UpLeftRow.Visible = 'On';
handles.Width.Visible = 'On';
handles.Height.Visible = 'On';
handles.popCcol.Visible = 'On';
handles.popCcol.String = {'1';'8';'16';'32';'64';'128';'256';'512'};
handles.popCrow.Visible = 'On';
handles.popCrow.String = {'1';'8';'16';'32';'64';'128';'256';'512'};
handles.popCwid.Visible = 'On';
handles.popCwid.String = {'8';'16';'32';'64';'100';'128';'256';'512'};
handles.popChei.Visible = 'On';
handles.popChei.String = {'8';'16';'32';'64';'100';'128';'256';'512'};

% Zoom

handles.By.Visible = 'Off';
handles.popCfac.Visible = 'Off';
handles.popBmet.Visible = 'Off';

% Grey Level Quant
handles.popGquant.Visible = 'Off';
handles.NumGrayLevel.Visible = 'Off';
handles.popNgray.Visible = 'Off';

%Spat Quant
handles.WidSpat.Visible = 'Off';
handles.popRwid.Visible = 'Off';
handles.HeiSpat.Visible = 'Off';
handles.popRhei.Visible = 'Off';
handles.MetSpat.Visible = 'Off';
handles.popMSpa.Visible = 'Off';

% HistEqual

handles.popHistEqu.Visible = 'Off';
handles.OnBand.Visible = 'Off';

% Hist Stretch
handles.LowLim.Visible = 'Off';
handles.HighLim.Visible = 'Off';
handles.popLLim.Visible = 'Off';
handles.popLLim.String = {'0';'1';'10';'20';'30';'40';'50';'75';'100'};
handles.popHLim.Visible = 'Off';
handles.popHLim.String = {'10';'20';'30';'40';'50';'75';'100';'200';'254';'255'};
handles.LowClipPer.Visible = 'Off';
handles.HighClipPer.Visible = 'Off';
handles.popLClip.Visible = 'Off';
handles.popLClip.String = {'0.01';'0.02';'0.025';'0.03';'0.04';'0.05';'0.075';'0.1';'0.15'};
handles.popHClip.Visible = 'Off';
handles.popHClip.String = {'0.01';'0.02';'0.025';'0.03';'0.04';'0.05';'0.075';'0.1';'0.15'};
handles.text27.Visible = 'Off';


handles.text41.Visible = 'Off';
handles.text44.Visible = 'Off';
handles.text45.Visible = 'Off';
handles.popRwid.Visible = 'Off';
handles.popRwid.String = {'32';'64';'128';'256'};
handles.popRhei.Visible = 'Off';
handles.popRhei.String = {'32';'64';'128';'256'};
handles.popMSpa.Visible = 'Off';
handles.popMSpa.String = {'Average Value';'Median Value';'Decimation'};


handles.radiobutton43.Visible = 'Off';
handles.radiobutton44.Visible = 'Off';
handles.radiobutton45.Visible = 'Off';
handles.radiobutton46.Visible = 'Off';
handles.radiobutton47.Visible = 'Off';
handles.radiobutton48.Visible = 'Off';
handles.radiobutton49.Visible = 'Off';
handles.radiobutton50.Visible = 'Off';
handles.radiobutton50.String = 'Type 1';
handles.radiobutton51.Visible = 'Off';
handles.radiobutton51.String = 'Type 2';
handles.radiobutton52.Visible = 'Off';
handles.radiobutton52.String = 'Type 3';
handles.radiobutton53.Visible = 'Off';
handles.radiobutton54.Visible = 'Off';
handles.radiobutton55.Visible = 'Off';
handles.radiobutton56.Visible = 'Off';
handles.radiobutton57.Visible = 'Off';
handles.checkbox14.Visible = 'Off';
handles.EditMask.Visible = 'Off';
handles.EditMask.String = 'Edit Mask';
% for Difference
%handles for spatial filters
handles.bGauss.Value = 0;
handles.bLap.Value = 0;
handles.bDiff.Value = 0;
%handles for Geometry
handles.bZoom.Value = 0;
%handles for Quantization
handles.bGray.Value = 0;
handles.bSpaQ.Value = 0;
%handles for Histogram
handles.bHisEqu.Value = 0;
handles.bHisStre.Value = 0;


% Hint: get(hObject,'Value') returns toggle state of bCrop


% --- Executes on button press in bZoom.
function bZoom_Callback(hObject, eventdata, handles)
% hObject    handle to bZoom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Arithmatic
handles.curImage.Visible = 'Off';
handles.secImage.Visible = 'Off';
handles.selFirstimage.Visible = 'Off';
handles.selSecondimage.Visible = 'Off';
handles.cByC.Visible = 'Off';
handles.bIma1.Visible = 'Off';
handles.bIma2.Visible = 'Off';
handles.bAdd.Value = 0;
handles.bSub.Value = 0;
handles.bMul.Value = 0;
handles.bDiv.Value = 0;
handles.bAnd.Value = 0;
handles.bNOT.Value = 0;
handles.bOr.Value = 0;
handles.bXor.Value = 0;

% Mean
handles.bMean.Value = 0;
handles.p1.Visible = 'Off';
handles.p1.String = {'3';'5';'7';'9';'11'};
handles.maskSize.Visible = 'Off';

%Median
handles.bMedian.Value = 0;
handles.MedianType.Visible = 'Off';
handles.ButtonMedianType.Visible = 'Off';
handles.Standard.Visible = 'Off';
handles.Adaptive.Visible = 'Off';
% Gaussian, Only Mask Size
% Laplacian
handles.LaplacianType.Visible = 'Off';
handles.LaplaType.Visible = 'Off';
% Difference
handles.DiffMask.Visible = 'Off';
handles.DiffType.Visible = 'Off';

% Crop
handles.bCrop.Value = 0;
handles.UpLeftCol.Visible = 'On';
handles.UpLeftRow.Visible = 'On';
handles.Width.Visible = 'On';
handles.Height.Visible = 'On';
handles.popCcol.Visible = 'On';
handles.popCcol.String = {'0';'8';'16';'32';'64';'128';'256';'512'};
handles.popCrow.Visible = 'On';
handles.popCrow.String = {'0';'8';'16';'32';'64';'128';'256';'512'};
handles.popCwid.Visible = 'On';
handles.popCwid.String = {'0';'8';'16';'32';'64';'100';'128';'256';'512'};
handles.popChei.Visible = 'On';
handles.popChei.String = {'0';'8';'16';'32';'64';'100';'128';'256';'512'};

% Zoom
handles.bZoom.Value = 1;
handles.By.Visible = 'On';
handles.popCfac.Visible = 'On';
handles.popBmet.Visible = 'On';


% Grey Level Quant
handles.popGquant.Visible = 'Off';
handles.NumGrayLevel.Visible = 'Off';
handles.popNgray.Visible = 'Off';

%Spat Quant
handles.WidSpat.Visible = 'Off';
handles.popRwid.Visible = 'Off';
handles.HeiSpat.Visible = 'Off';
handles.popRhei.Visible = 'Off';
handles.MetSpat.Visible = 'Off';
handles.popMSpa.Visible = 'Off';

% HistEqual

handles.popHistEqu.Visible = 'Off';
handles.OnBand.Visible = 'Off';

% Hist Stretch
handles.LowLim.Visible = 'Off';
handles.HighLim.Visible = 'Off';
handles.popLLim.Visible = 'Off';
handles.popLLim.String = {'0';'1';'10';'20';'30';'40';'50';'75';'100'};
handles.popHLim.Visible = 'Off';
handles.popHLim.String = {'10';'20';'30';'40';'50';'75';'100';'200';'254';'255'};
handles.LowClipPer.Visible = 'Off';
handles.HighClipPer.Visible = 'Off';
handles.popLClip.Visible = 'Off';
handles.popLClip.String = {'0.01';'0.02';'0.025';'0.03';'0.04';'0.05';'0.075';'0.1';'0.15'};
handles.popHClip.Visible = 'Off';
handles.popHClip.String = {'0.01';'0.02';'0.025';'0.03';'0.04';'0.05';'0.075';'0.1';'0.15'};
handles.text27.Visible = 'Off';


handles.text41.Visible = 'Off';
handles.text44.Visible = 'Off';
handles.text45.Visible = 'Off';
handles.popRwid.Visible = 'Off';
handles.popRwid.String = {'32';'64';'128';'256'};
handles.popRhei.Visible = 'Off';
handles.popRhei.String = {'32';'64';'128';'256'};
handles.popMSpa.Visible = 'Off';
handles.popMSpa.String = {'Average Value';'Median Value';'Decimation'};


handles.radiobutton43.Visible = 'Off';
handles.radiobutton44.Visible = 'Off';
handles.radiobutton45.Visible = 'Off';
handles.radiobutton46.Visible = 'Off';
handles.radiobutton47.Visible = 'Off';
handles.radiobutton48.Visible = 'Off';
handles.radiobutton49.Visible = 'Off';
handles.radiobutton50.Visible = 'Off';
handles.radiobutton50.String = 'Type 1';
handles.radiobutton51.Visible = 'Off';
handles.radiobutton51.String = 'Type 2';
handles.radiobutton52.Visible = 'Off';
handles.radiobutton52.String = 'Type 3';
handles.radiobutton53.Visible = 'Off';
handles.radiobutton54.Visible = 'Off';
handles.radiobutton55.Visible = 'Off';
handles.radiobutton56.Visible = 'Off';
handles.radiobutton57.Visible = 'Off';
handles.checkbox14.Visible = 'Off';
handles.EditMask.Visible = 'Off';
handles.EditMask.String = 'Edit Mask';
% for Difference
%handles for spatial filters
handles.bGauss.Value = 0;
handles.bLap.Value = 0;
handles.bDiff.Value = 0;
%handles for Geometry

%handles for Quantization
handles.bGray.Value = 0;
handles.bSpaQ.Value = 0;
%handles for Histogram
handles.bHisEqu.Value = 0;
handles.bHisStre.Value = 0;

% Hint: get(hObject,'Value') returns toggle state of bZoom


% --- Executes on button press in bGray.
function bGray_Callback(hObject, eventdata, handles)
% hObject    handle to bGray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Arithmatic
handles.curImage.Visible = 'Off';
handles.secImage.Visible = 'Off';
handles.selFirstimage.Visible = 'Off';
handles.selSecondimage.Visible = 'Off';
handles.cByC.Visible = 'Off';
handles.bIma1.Visible = 'Off';
handles.bIma2.Visible = 'Off';
handles.bAdd.Value = 0;
handles.bSub.Value = 0;
handles.bMul.Value = 0;
handles.bDiv.Value = 0;
handles.bAnd.Value = 0;
handles.bNOT.Value = 0;
handles.bOr.Value = 0;
handles.bXor.Value = 0;

% Mean
handles.bMean.Value = 0;
handles.p1.Visible = 'Off';
handles.p1.String = {'3';'5';'7';'9';'11'};
handles.maskSize.Visible = 'Off';

%Median
handles.bMedian.Value = 0;
handles.MedianType.Visible = 'Off';
handles.ButtonMedianType.Visible = 'Off';
handles.Standard.Visible = 'Off';
handles.Adaptive.Visible = 'Off';
% Gaussian, Only Mask Size
% Laplacian
handles.LaplacianType.Visible = 'Off';
handles.LaplaType.Visible = 'Off';
% Difference
handles.DiffMask.Visible = 'Off';
handles.DiffType.Visible = 'Off';

% Crop
handles.bCrop.Value = 0;
handles.UpLeftCol.Visible = 'Off';
handles.UpLeftRow.Visible = 'Off';
handles.Width.Visible = 'Off';
handles.Height.Visible = 'Off';
handles.popCcol.Visible = 'Off';
handles.popCcol.String = {'0';'8';'16';'32';'64';'128';'256';'512'};
handles.popCrow.Visible = 'Off';
handles.popCrow.String = {'0';'8';'16';'32';'64';'128';'256';'512'};
handles.popCwid.Visible = 'Off';
handles.popCwid.String = {'0';'8';'16';'32';'64';'100';'128';'256';'512'};
handles.popChei.Visible = 'Off';
handles.popChei.String = {'0';'8';'16';'32';'64';'100';'128';'256';'512'};

% Zoom
handles.bZoom.Value = 0;
handles.By.Visible = 'Off';
handles.popCfac.Visible = 'Off';
handles.popBmet.Visible = 'Off';

% Grey Level Quant
handles.bGray.Value = 1;
handles.popGquant.Visible = 'On';
handles.NumGrayLevel.Visible = 'On';
handles.popNgray.Visible = 'On';

%Spat Quant
handles.WidSpat.Visible = 'Off';
handles.popRwid.Visible = 'Off';
handles.HeiSpat.Visible = 'Off';
handles.popRhei.Visible = 'Off';
handles.MetSpat.Visible = 'Off';
handles.popMSpa.Visible = 'Off';

% HistEqual

handles.popHistEqu.Visible = 'Off';
handles.OnBand.Visible = 'Off';

% Hist Stretch
handles.LowLim.Visible = 'Off';
handles.HighLim.Visible = 'Off';
handles.popLLim.Visible = 'Off';
handles.popLLim.String = {'0';'1';'10';'20';'30';'40';'50';'75';'100'};
handles.popHLim.Visible = 'Off';
handles.popHLim.String = {'10';'20';'30';'40';'50';'75';'100';'200';'254';'255'};
handles.LowClipPer.Visible = 'Off';
handles.HighClipPer.Visible = 'Off';
handles.popLClip.Visible = 'Off';
handles.popLClip.String = {'0.01';'0.02';'0.025';'0.03';'0.04';'0.05';'0.075';'0.1';'0.15'};
handles.popHClip.Visible = 'Off';
handles.popHClip.String = {'0.01';'0.02';'0.025';'0.03';'0.04';'0.05';'0.075';'0.1';'0.15'};
handles.text27.Visible = 'Off';


handles.text41.Visible = 'Off';
handles.text44.Visible = 'Off';
handles.text45.Visible = 'Off';
handles.popRwid.Visible = 'Off';
handles.popRwid.String = {'32';'64';'128';'256'};
handles.popRhei.Visible = 'Off';
handles.popRhei.String = {'32';'64';'128';'256'};
handles.popMSpa.Visible = 'Off';
handles.popMSpa.String = {'Average Value';'Median Value';'Decimation'};


handles.radiobutton43.Visible = 'Off';
handles.radiobutton44.Visible = 'Off';
handles.radiobutton45.Visible = 'Off';
handles.radiobutton46.Visible = 'Off';
handles.radiobutton47.Visible = 'Off';
handles.radiobutton48.Visible = 'Off';
handles.radiobutton49.Visible = 'Off';
handles.radiobutton50.Visible = 'Off';
handles.radiobutton50.String = 'Type 1';
handles.radiobutton51.Visible = 'Off';
handles.radiobutton51.String = 'Type 2';
handles.radiobutton52.Visible = 'Off';
handles.radiobutton52.String = 'Type 3';
handles.radiobutton53.Visible = 'Off';
handles.radiobutton54.Visible = 'Off';
handles.radiobutton55.Visible = 'Off';
handles.radiobutton56.Visible = 'Off';
handles.radiobutton57.Visible = 'Off';
handles.checkbox14.Visible = 'Off';
handles.EditMask.Visible = 'Off';
handles.EditMask.String = 'Edit Mask';
% for Difference
%handles for spatial filters
handles.bGauss.Value = 0;
handles.bLap.Value = 0;
handles.bDiff.Value = 0;
%handles for Geometry

%handles for Quantization
handles.bSpaQ.Value = 0;
%handles for Histogram
handles.bHisEqu.Value = 0;
handles.bHisStre.Value = 0;





% Hint: get(hObject,'Value') returns toggle state of bGray


% --- Executes on button press in bSpaQ.
function bSpaQ_Callback(hObject, eventdata, handles)
% hObject    handle to bSpaQ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Arithmatic
handles.curImage.Visible = 'Off';
handles.secImage.Visible = 'Off';
handles.selFirstimage.Visible = 'Off';
handles.selSecondimage.Visible = 'Off';
handles.cByC.Visible = 'Off';
handles.bIma1.Visible = 'Off';
handles.bIma2.Visible = 'Off';
handles.bAdd.Value = 0;
handles.bSub.Value = 0;
handles.bMul.Value = 0;
handles.bDiv.Value = 0;
handles.bAnd.Value = 0;
handles.bNOT.Value = 0;
handles.bOr.Value = 0;
handles.bXor.Value = 0;

% Mean
handles.bMean.Value = 0;
handles.p1.Visible = 'Off';
handles.p1.String = {'3';'5';'7';'9';'11'};
handles.maskSize.Visible = 'Off';

%Median
handles.bMedian.Value = 0;
handles.MedianType.Visible = 'Off';
handles.ButtonMedianType.Visible = 'Off';
handles.Standard.Visible = 'Off';
handles.Adaptive.Visible = 'Off';
% Gaussian, Only Mask Size
% Laplacian
handles.LaplacianType.Visible = 'Off';
handles.LaplaType.Visible = 'Off';
% Difference
handles.DiffMask.Visible = 'Off';
handles.DiffType.Visible = 'Off';

% Crop
handles.bCrop.Value = 0;
handles.UpLeftCol.Visible = 'Off';
handles.UpLeftRow.Visible = 'Off';
handles.Width.Visible = 'Off';
handles.Height.Visible = 'Off';
handles.popCcol.Visible = 'Off';
handles.popCcol.String = {'0';'8';'16';'32';'64';'128';'256';'512'};
handles.popCrow.Visible = 'Off';
handles.popCrow.String = {'0';'8';'16';'32';'64';'128';'256';'512'};
handles.popCwid.Visible = 'Off';
handles.popCwid.String = {'0';'8';'16';'32';'64';'100';'128';'256';'512'};
handles.popChei.Visible = 'Off';
handles.popChei.String = {'0';'8';'16';'32';'64';'100';'128';'256';'512'};

% Zoom
handles.bZoom.Value = 0;
handles.By.Visible = 'Off';
handles.popCfac.Visible = 'Off';
handles.popBmet.Visible = 'Off';

% Grey Level Quant
handles.bGray.Value = 0;
handles.popGquant.Visible = 'Off';
handles.NumGrayLevel.Visible = 'Off';
handles.popNgray.Visible = 'Off';

%Spat Quant
handles.bSpaQ.Value = 1;
handles.WidSpat.Visible = 'On';
handles.popRwid.Visible = 'On';
handles.HeiSpat.Visible = 'On';
handles.popRhei.Visible = 'On';
handles.MetSpat.Visible = 'On';
handles.popMSpa.Visible = 'On';
handles.popRwid.String = {'32';'64';'128';'256'};
handles.popRhei.String = {'32';'64';'128';'256'};
handles.popMSpa.String = {'Average Value';'Median Value';'Decimation'};


% HistEqual

handles.popHistEqu.Visible = 'Off';
handles.OnBand.Visible = 'Off';

% Hist Stretch
handles.LowLim.Visible = 'Off';
handles.HighLim.Visible = 'Off';
handles.popLLim.Visible = 'Off';
handles.popLLim.String = {'0';'1';'10';'20';'30';'40';'50';'75';'100'};
handles.popHLim.Visible = 'Off';
handles.popHLim.String = {'10';'20';'30';'40';'50';'75';'100';'200';'254';'255'};
handles.LowClipPer.Visible = 'Off';
handles.HighClipPer.Visible = 'Off';
handles.popLClip.Visible = 'Off';
handles.popLClip.String = {'0.01';'0.02';'0.025';'0.03';'0.04';'0.05';'0.075';'0.1';'0.15'};
handles.popHClip.Visible = 'Off';
handles.popHClip.String = {'0.01';'0.02';'0.025';'0.03';'0.04';'0.05';'0.075';'0.1';'0.15'};
handles.text27.Visible = 'Off';


handles.text41.Visible = 'Off';
handles.text44.Visible = 'Off';
handles.text45.Visible = 'Off';


handles.radiobutton43.Visible = 'Off';
handles.radiobutton44.Visible = 'Off';
handles.radiobutton45.Visible = 'Off';
handles.radiobutton46.Visible = 'Off';
handles.radiobutton47.Visible = 'Off';
handles.radiobutton48.Visible = 'Off';
handles.radiobutton49.Visible = 'Off';
handles.radiobutton50.Visible = 'Off';
handles.radiobutton50.String = 'Type 1';
handles.radiobutton51.Visible = 'Off';
handles.radiobutton51.String = 'Type 2';
handles.radiobutton52.Visible = 'Off';
handles.radiobutton52.String = 'Type 3';
handles.radiobutton53.Visible = 'Off';
handles.radiobutton54.Visible = 'Off';
handles.radiobutton55.Visible = 'Off';
handles.radiobutton56.Visible = 'Off';
handles.radiobutton57.Visible = 'Off';
handles.checkbox14.Visible = 'Off';
handles.EditMask.Visible = 'Off';
handles.EditMask.String = 'Edit Mask';
% for Difference
%handles for spatial filters
handles.bGauss.Value = 0;
handles.bLap.Value = 0;
handles.bDiff.Value = 0;
%handles for Geometry

%handles for Quantization
%handles for Histogram
handles.bHisEqu.Value = 0;
handles.bHisStre.Value = 0;
% Hint: get(hObject,'Value') returns toggle state of bSpaQ


% --- Executes on button press in bHisEqu.
function bHisEqu_Callback(hObject, eventdata, handles)
% hObject    handle to bHisEqu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Arithmatic
handles.curImage.Visible = 'Off';
handles.secImage.Visible = 'Off';
handles.selFirstimage.Visible = 'Off';
handles.selSecondimage.Visible = 'Off';
handles.cByC.Visible = 'Off';
handles.bIma1.Visible = 'Off';
handles.bIma2.Visible = 'Off';
handles.bAdd.Value = 0;
handles.bSub.Value = 0;
handles.bMul.Value = 0;
handles.bDiv.Value = 0;
handles.bAnd.Value = 0;
handles.bNOT.Value = 0;
handles.bOr.Value = 0;
handles.bXor.Value = 0;

% Mean
handles.bMean.Value = 0;
handles.p1.Visible = 'Off';
handles.p1.String = {'3';'5';'7';'9';'11'};
handles.maskSize.Visible = 'Off';

%Median
handles.bMedian.Value = 0;
handles.MedianType.Visible = 'Off';
handles.ButtonMedianType.Visible = 'Off';
handles.Standard.Visible = 'Off';
handles.Adaptive.Visible = 'Off';
% Gaussian, Only Mask Size
% Laplacian
handles.LaplacianType.Visible = 'Off';
handles.LaplaType.Visible = 'Off';
% Difference
handles.DiffMask.Visible = 'Off';
handles.DiffType.Visible = 'Off';

% Crop
handles.bCrop.Value = 0;
handles.UpLeftCol.Visible = 'Off';
handles.UpLeftRow.Visible = 'Off';
handles.Width.Visible = 'Off';
handles.Height.Visible = 'Off';
handles.popCcol.Visible = 'Off';
handles.popCcol.String = {'0';'8';'16';'32';'64';'128';'256';'512'};
handles.popCrow.Visible = 'Off';
handles.popCrow.String = {'0';'8';'16';'32';'64';'128';'256';'512'};
handles.popCwid.Visible = 'Off';
handles.popCwid.String = {'0';'8';'16';'32';'64';'100';'128';'256';'512'};
handles.popChei.Visible = 'Off';
handles.popChei.String = {'0';'8';'16';'32';'64';'100';'128';'256';'512'};

% Zoom
handles.bZoom.Value = 0;
handles.By.Visible = 'Off';
handles.popCfac.Visible = 'Off';
handles.popBmet.Visible = 'Off';

% Grey Level Quant
handles.bGray.Value = 0;
handles.popGquant.Visible = 'Off';
handles.NumGrayLevel.Visible = 'Off';
handles.popNgray.Visible = 'Off';

%Spat Quant
handles.bSpaQ.Value = 0;
handles.WidSpat.Visible = 'Off';
handles.popRwid.Visible = 'Off';
handles.HeiSpat.Visible = 'Off';
handles.popRhei.Visible = 'Off';
handles.MetSpat.Visible = 'Off';
handles.popMSpa.Visible = 'Off';
handles.popRwid.String = {'32';'64';'128';'256'};
handles.popRhei.String = {'32';'64';'128';'256'};
handles.popMSpa.String = {'Average Value';'Median Value';'Decimation'};


% HistEqual
handles.bHisEqu.Value = 1;
handles.popHistEqu.Visible = 'On';
handles.OnBand.Visible = 'On';

% Hist Stretch
handles.LowLim.Visible = 'Off';
handles.HighLim.Visible = 'Off';
handles.popLLim.Visible = 'Off';
handles.popLLim.String = {'0';'1';'10';'20';'30';'40';'50';'75';'100'};
handles.popHLim.Visible = 'Off';
handles.popHLim.String = {'10';'20';'30';'40';'50';'75';'100';'200';'254';'255'};
handles.LowClipPer.Visible = 'Off';
handles.HighClipPer.Visible = 'Off';
handles.popLClip.Visible = 'Off';
handles.popLClip.String = {'0.01';'0.02';'0.025';'0.03';'0.04';'0.05';'0.075';'0.1';'0.15'};
handles.popHClip.Visible = 'Off';
handles.popHClip.String = {'0.01';'0.02';'0.025';'0.03';'0.04';'0.05';'0.075';'0.1';'0.15'};
handles.text27.Visible = 'Off';


handles.text41.Visible = 'Off';
handles.text44.Visible = 'Off';
handles.text45.Visible = 'Off';


handles.radiobutton43.Visible = 'Off';
handles.radiobutton44.Visible = 'Off';
handles.radiobutton45.Visible = 'Off';
handles.radiobutton46.Visible = 'Off';
handles.radiobutton47.Visible = 'Off';
handles.radiobutton48.Visible = 'Off';
handles.radiobutton49.Visible = 'Off';
handles.radiobutton50.Visible = 'Off';
handles.radiobutton50.String = 'Type 1';
handles.radiobutton51.Visible = 'Off';
handles.radiobutton51.String = 'Type 2';
handles.radiobutton52.Visible = 'Off';
handles.radiobutton52.String = 'Type 3';
handles.radiobutton53.Visible = 'Off';
handles.radiobutton54.Visible = 'Off';
handles.radiobutton55.Visible = 'Off';
handles.radiobutton56.Visible = 'Off';
handles.radiobutton57.Visible = 'Off';
handles.checkbox14.Visible = 'Off';
handles.EditMask.Visible = 'Off';
handles.EditMask.String = 'Edit Mask';
% for Difference
%handles for spatial filters
handles.bGauss.Value = 0;
handles.bLap.Value = 0;
handles.bDiff.Value = 0;
%handles for Geometry

%handles for Quantization
%handles for Histogram
handles.bHisStre.Value = 0;

% Hint: get(hObject,'Value') returns toggle state of bHisEqu


% --- Executes on button press in bHisStre.
function bHisStre_Callback(hObject, eventdata, handles)
% hObject    handle to bHisStre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Arithmatic
handles.curImage.Visible = 'Off';
handles.secImage.Visible = 'Off';
handles.selFirstimage.Visible = 'Off';
handles.selSecondimage.Visible = 'Off';
handles.cByC.Visible = 'Off';
handles.bIma1.Visible = 'Off';
handles.bIma2.Visible = 'Off';
handles.bAdd.Value = 0;
handles.bSub.Value = 0;
handles.bMul.Value = 0;
handles.bDiv.Value = 0;
handles.bAnd.Value = 0;
handles.bNOT.Value = 0;
handles.bOr.Value = 0;
handles.bXor.Value = 0;

% Mean
handles.bMean.Value = 0;
handles.p1.Visible = 'Off';
handles.p1.String = {'3';'5';'7';'9';'11'};
handles.maskSize.Visible = 'Off';

%Median
handles.bMedian.Value = 0;
handles.MedianType.Visible = 'Off';
handles.ButtonMedianType.Visible = 'Off';
handles.Standard.Visible = 'Off';
handles.Adaptive.Visible = 'Off';
% Gaussian, Only Mask Size
% Laplacian
handles.LaplacianType.Visible = 'Off';
handles.LaplaType.Visible = 'Off';
% Difference
handles.DiffMask.Visible = 'Off';
handles.DiffType.Visible = 'Off';

% Crop
handles.bCrop.Value = 0;
handles.UpLeftCol.Visible = 'Off';
handles.UpLeftRow.Visible = 'Off';
handles.Width.Visible = 'Off';
handles.Height.Visible = 'Off';
handles.popCcol.Visible = 'Off';
handles.popCcol.String = {'0';'8';'16';'32';'64';'128';'256';'512'};
handles.popCrow.Visible = 'Off';
handles.popCrow.String = {'0';'8';'16';'32';'64';'128';'256';'512'};
handles.popCwid.Visible = 'Off';
handles.popCwid.String = {'0';'8';'16';'32';'64';'100';'128';'256';'512'};
handles.popChei.Visible = 'Off';
handles.popChei.String = {'0';'8';'16';'32';'64';'100';'128';'256';'512'};

% Zoom
handles.bZoom.Value = 0;
handles.By.Visible = 'Off';
handles.popCfac.Visible = 'Off';
handles.popBmet.Visible = 'Off';

% Grey Level Quant
handles.bGray.Value = 0;
handles.popGquant.Visible = 'Off';
handles.NumGrayLevel.Visible = 'Off';
handles.popNgray.Visible = 'Off';

%Spat Quant
handles.bSpaQ.Value = 0;
handles.WidSpat.Visible = 'Off';
handles.popRwid.Visible = 'Off';
handles.HeiSpat.Visible = 'Off';
handles.popRhei.Visible = 'Off';
handles.MetSpat.Visible = 'Off';
handles.popMSpa.Visible = 'Off';
handles.popRwid.String = {'32';'64';'128';'256'};
handles.popRhei.String = {'32';'64';'128';'256'};
handles.popMSpa.String = {'Average Value';'Median Value';'Decimation'};


% HistEqual
handles.bHisEqu.Value = 0;
handles.popHistEqu.Visible = 'Off';
handles.OnBand.Visible = 'Off';

% Hist Stretch
handles.bHisStre.Value = 1;
handles.LowLim.Visible = 'On';
handles.HighLim.Visible = 'On';
handles.popLLim.Visible = 'On';
handles.popLLim.String = {'0';'1';'10';'20';'30';'40';'50';'75';'100'};
handles.popHLim.Visible = 'On';
handles.popHLim.String = {'10';'20';'30';'40';'50';'75';'100';'200';'254';'255'};
handles.LowClipPer.Visible = 'On';
handles.HighClipPer.Visible = 'On';
handles.popLClip.Visible = 'On';
handles.popLClip.String = {'0.01';'0.02';'0.025';'0.03';'0.04';'0.05';'0.075';'0.1';'0.15'};
handles.popHClip.Visible = 'On';
handles.popHClip.String = {'0.01';'0.02';'0.025';'0.03';'0.04';'0.05';'0.075';'0.1';'0.15'};
handles.text27.Visible = 'On';


handles.text41.Visible = 'Off';
handles.text44.Visible = 'Off';
handles.text45.Visible = 'Off';


handles.radiobutton43.Visible = 'Off';
handles.radiobutton44.Visible = 'Off';
handles.radiobutton45.Visible = 'Off';
handles.radiobutton46.Visible = 'Off';
handles.radiobutton47.Visible = 'Off';
handles.radiobutton48.Visible = 'Off';
handles.radiobutton49.Visible = 'Off';
handles.radiobutton50.Visible = 'Off';
handles.radiobutton50.String = 'Type 1';
handles.radiobutton51.Visible = 'Off';
handles.radiobutton51.String = 'Type 2';
handles.radiobutton52.Visible = 'Off';
handles.radiobutton52.String = 'Type 3';
handles.radiobutton53.Visible = 'Off';
handles.radiobutton54.Visible = 'Off';
handles.radiobutton55.Visible = 'Off';
handles.radiobutton56.Visible = 'Off';
handles.radiobutton57.Visible = 'Off';
handles.checkbox14.Visible = 'Off';
handles.EditMask.Visible = 'Off';
handles.EditMask.String = 'Edit Mask';
% for Difference
%handles for spatial filters
handles.bGauss.Value = 0;
handles.bLap.Value = 0;
handles.bDiff.Value = 0;



% Hint: get(hObject,'Value') returns toggle state of bHisStre


% --- Executes on button press in bAdd.
function bAdd_Callback(hObject, eventdata, handles)
% hObject    handle to bAdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Arithmatic
handles.curImage.Visible = 'On';
handles.secImage.Visible = 'On';
handles.selFirstimage.Visible = 'On';
handles.selSecondimage.Visible = 'On';
handles.cByC.Visible = 'Off';
handles.bIma1.Visible = 'On';
handles.bIma2.Visible = 'On';

% Mean
handles.p1.Visible = 'Off';
handles.p1.String = {'3';'5';'7';'9';'11'};
handles.maskSize.Visible = 'Off';
%Median
handles.MedianType.Visible = 'Off';
handles.ButtonMedianType.Visible = 'Off';
% Gaussian, Only Mask Size
% Laplacian
handles.LaplacianType.Visible = 'Off';
handles.LaplaType.Visible = 'Off';
% Difference
handles.DiffMask.Visible = 'Off';
handles.DiffType.Visible = 'Off';

% Crop
handles.UpLeftCol.Visible = 'Off';
handles.UpLeftRow.Visible = 'Off';
handles.Width.Visible = 'Off';
handles.Height.Visible = 'Off';
handles.popCcol.Visible = 'Off';
handles.popCcol.String = {'0';'8';'16';'32';'64';'128';'256';'512'};
handles.popCrow.Visible = 'Off';
handles.popCrow.String = {'0';'8';'16';'32';'64';'128';'256';'512'};
handles.popCwid.Visible = 'Off';
handles.popCwid.String = {'0';'8';'16';'32';'64';'100';'128';'256';'512'};
handles.popChei.Visible = 'Off';
handles.popChei.String = {'0';'8';'16';'32';'64';'100';'128';'256';'512'};

% Zoom

handles.By.Visible = 'Off';
handles.popCfac.Visible = 'Off';
handles.popBmet.Visible = 'Off';

% Grey Level Quant
handles.popGquant.Visible = 'Off';
handles.NumGrayLevel.Visible = 'Off';
handles.popNgray.Visible = 'Off';

%Spat Quant
handles.WidSpat.Visible = 'Off';
handles.popRwid.Visible = 'Off';
handles.HeiSpat.Visible = 'Off';
handles.popRhei.Visible = 'Off';
handles.MetSpat.Visible = 'Off';
handles.popMSpa.Visible = 'Off';

% HistEqual

handles.popHistEqu.Visible = 'Off';
handles.OnBand.Visible = 'Off';

% Hist Stretch
handles.LowLim.Visible = 'Off';
handles.HighLim.Visible = 'Off';
handles.popLLim.Visible = 'Off';
handles.popLLim.String = {'0';'1';'10';'20';'30';'40';'50';'75';'100'};
handles.popHLim.Visible = 'Off';
handles.popHLim.String = {'10';'20';'30';'40';'50';'75';'100';'200';'254';'255'};
handles.LowClipPer.Visible = 'Off';
handles.HighClipPer.Visible = 'Off';
handles.popLClip.Visible = 'Off';
handles.popLClip.String = {'0.01';'0.02';'0.025';'0.03';'0.04';'0.05';'0.075';'0.1';'0.15'};
handles.popHClip.Visible = 'Off';
handles.popHClip.String = {'0.01';'0.02';'0.025';'0.03';'0.04';'0.05';'0.075';'0.1';'0.15'};
handles.text27.Visible = 'Off';
handles.EditMask.Visible = 'Off';


% Hint: get(hObject,'Value') returns toggle state of bAdd


% --- Executes on button press in bSub.
function bSub_Callback(hObject, eventdata, handles)
% hObject    handle to bSub (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Arithmatic
handles.curImage.Visible = 'On';
handles.secImage.Visible = 'On';
handles.selFirstimage.Visible = 'On';
handles.selSecondimage.Visible = 'On';
handles.cByC.Visible = 'Off';
handles.bIma1.Visible = 'On';
handles.bIma2.Visible = 'On';

% Mean
handles.p1.Visible = 'Off';
handles.p1.String = {'3';'5';'7';'9';'11'};
handles.maskSize.Visible = 'Off';
%Median
handles.MedianType.Visible = 'Off';
handles.ButtonMedianType.Visible = 'Off';
% Gaussian, Only Mask Size
% Laplacian
handles.LaplacianType.Visible = 'Off';
handles.LaplaType.Visible = 'Off';
% Difference
handles.DiffMask.Visible = 'Off';
handles.DiffType.Visible = 'Off';

% Crop
handles.UpLeftCol.Visible = 'Off';
handles.UpLeftRow.Visible = 'Off';
handles.Width.Visible = 'Off';
handles.Height.Visible = 'Off';
handles.popCcol.Visible = 'Off';
handles.popCcol.String = {'0';'8';'16';'32';'64';'128';'256';'512'};
handles.popCrow.Visible = 'Off';
handles.popCrow.String = {'0';'8';'16';'32';'64';'128';'256';'512'};
handles.popCwid.Visible = 'Off';
handles.popCwid.String = {'0';'8';'16';'32';'64';'100';'128';'256';'512'};
handles.popChei.Visible = 'Off';
handles.popChei.String = {'0';'8';'16';'32';'64';'100';'128';'256';'512'};

% Zoom

handles.By.Visible = 'Off';
handles.popCfac.Visible = 'Off';
handles.popBmet.Visible = 'Off';

% Grey Level Quant
handles.popGquant.Visible = 'Off';
handles.NumGrayLevel.Visible = 'Off';
handles.popNgray.Visible = 'Off';

%Spat Quant
handles.WidSpat.Visible = 'Off';
handles.popRwid.Visible = 'Off';
handles.HeiSpat.Visible = 'Off';
handles.popRhei.Visible = 'Off';
handles.MetSpat.Visible = 'Off';
handles.popMSpa.Visible = 'Off';

% HistEqual

handles.popHistEqu.Visible = 'Off';
handles.OnBand.Visible = 'Off';

% Hist Stretch
handles.LowLim.Visible = 'Off';
handles.HighLim.Visible = 'Off';
handles.popLLim.Visible = 'Off';
handles.popLLim.String = {'0';'1';'10';'20';'30';'40';'50';'75';'100'};
handles.popHLim.Visible = 'Off';
handles.popHLim.String = {'10';'20';'30';'40';'50';'75';'100';'200';'254';'255'};
handles.LowClipPer.Visible = 'Off';
handles.HighClipPer.Visible = 'Off';
handles.popLClip.Visible = 'Off';
handles.popLClip.String = {'0.01';'0.02';'0.025';'0.03';'0.04';'0.05';'0.075';'0.1';'0.15'};
handles.popHClip.Visible = 'Off';
handles.popHClip.String = {'0.01';'0.02';'0.025';'0.03';'0.04';'0.05';'0.075';'0.1';'0.15'};
handles.text27.Visible = 'Off';
handles.EditMask.Visible = 'Off';



% Hint: get(hObject,'Value') returns toggle state of bSub


% --- Executes on button press in bMul.
function bMul_Callback(hObject, eventdata, handles)
% hObject    handle to bMul (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Arithmatic
handles.curImage.Visible = 'On';
handles.secImage.Visible = 'On';
handles.selFirstimage.Visible = 'On';
handles.selSecondimage.Visible = 'On';
handles.cByC.Visible = 'Off';
handles.bIma1.Visible = 'On';
handles.bIma2.Visible = 'On';

% Mean
handles.p1.Visible = 'Off';
handles.p1.String = {'3';'5';'7';'9';'11'};
handles.maskSize.Visible = 'Off';
%Median
handles.MedianType.Visible = 'Off';
handles.ButtonMedianType.Visible = 'Off';
% Gaussian, Only Mask Size
% Laplacian
handles.LaplacianType.Visible = 'Off';
handles.LaplaType.Visible = 'Off';
% Difference
handles.DiffMask.Visible = 'Off';
handles.DiffType.Visible = 'Off';

% Crop
handles.UpLeftCol.Visible = 'Off';
handles.UpLeftRow.Visible = 'Off';
handles.Width.Visible = 'Off';
handles.Height.Visible = 'Off';
handles.popCcol.Visible = 'Off';
handles.popCcol.String = {'0';'8';'16';'32';'64';'128';'256';'512'};
handles.popCrow.Visible = 'Off';
handles.popCrow.String = {'0';'8';'16';'32';'64';'128';'256';'512'};
handles.popCwid.Visible = 'Off';
handles.popCwid.String = {'0';'8';'16';'32';'64';'100';'128';'256';'512'};
handles.popChei.Visible = 'Off';
handles.popChei.String = {'0';'8';'16';'32';'64';'100';'128';'256';'512'};

% Zoom

handles.By.Visible = 'Off';
handles.popCfac.Visible = 'Off';
handles.popBmet.Visible = 'Off';

% Grey Level Quant
handles.popGquant.Visible = 'Off';
handles.NumGrayLevel.Visible = 'Off';
handles.popNgray.Visible = 'Off';

%Spat Quant
handles.WidSpat.Visible = 'Off';
handles.popRwid.Visible = 'Off';
handles.HeiSpat.Visible = 'Off';
handles.popRhei.Visible = 'Off';
handles.MetSpat.Visible = 'Off';
handles.popMSpa.Visible = 'Off';

% HistEqual

handles.popHistEqu.Visible = 'Off';
handles.OnBand.Visible = 'Off';

% Hist Stretch
handles.LowLim.Visible = 'Off';
handles.HighLim.Visible = 'Off';
handles.popLLim.Visible = 'Off';
handles.popLLim.String = {'0';'1';'10';'20';'30';'40';'50';'75';'100'};
handles.popHLim.Visible = 'Off';
handles.popHLim.String = {'10';'20';'30';'40';'50';'75';'100';'200';'254';'255'};
handles.LowClipPer.Visible = 'Off';
handles.HighClipPer.Visible = 'Off';
handles.popLClip.Visible = 'Off';
handles.popLClip.String = {'0.01';'0.02';'0.025';'0.03';'0.04';'0.05';'0.075';'0.1';'0.15'};
handles.popHClip.Visible = 'Off';
handles.popHClip.String = {'0.01';'0.02';'0.025';'0.03';'0.04';'0.05';'0.075';'0.1';'0.15'};
handles.text27.Visible = 'Off';
handles.EditMask.Visible = 'Off';



% Hint: get(hObject,'Value') returns toggle state of bMul


% --- Executes on button press in bDiv.
function bDiv_Callback(hObject, eventdata, handles)
% hObject    handle to bDiv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Arithmatic
handles.curImage.Visible = 'On';
handles.secImage.Visible = 'On';
handles.selFirstimage.Visible = 'On';
handles.selSecondimage.Visible = 'On';
handles.cByC.Visible = 'Off';
handles.bIma1.Visible = 'On';
handles.bIma2.Visible = 'On';

% Mean
handles.p1.Visible = 'Off';
handles.p1.String = {'3';'5';'7';'9';'11'};
handles.maskSize.Visible = 'Off';
%Median
handles.MedianType.Visible = 'Off';
handles.ButtonMedianType.Visible = 'Off';
% Gaussian, Only Mask Size
% Laplacian
handles.LaplacianType.Visible = 'Off';
handles.LaplaType.Visible = 'Off';
% Difference
handles.DiffMask.Visible = 'Off';
handles.DiffType.Visible = 'Off';

% Crop
handles.UpLeftCol.Visible = 'Off';
handles.UpLeftRow.Visible = 'Off';
handles.Width.Visible = 'Off';
handles.Height.Visible = 'Off';
handles.popCcol.Visible = 'Off';
handles.popCcol.String = {'0';'8';'16';'32';'64';'128';'256';'512'};
handles.popCrow.Visible = 'Off';
handles.popCrow.String = {'0';'8';'16';'32';'64';'128';'256';'512'};
handles.popCwid.Visible = 'Off';
handles.popCwid.String = {'0';'8';'16';'32';'64';'100';'128';'256';'512'};
handles.popChei.Visible = 'Off';
handles.popChei.String = {'0';'8';'16';'32';'64';'100';'128';'256';'512'};

% Zoom

handles.By.Visible = 'Off';
handles.popCfac.Visible = 'Off';
handles.popBmet.Visible = 'Off';

% Grey Level Quant
handles.popGquant.Visible = 'Off';
handles.NumGrayLevel.Visible = 'Off';
handles.popNgray.Visible = 'Off';

%Spat Quant
handles.WidSpat.Visible = 'Off';
handles.popRwid.Visible = 'Off';
handles.HeiSpat.Visible = 'Off';
handles.popRhei.Visible = 'Off';
handles.MetSpat.Visible = 'Off';
handles.popMSpa.Visible = 'Off';

% HistEqual

handles.popHistEqu.Visible = 'Off';
handles.OnBand.Visible = 'Off';

% Hist Stretch
handles.LowLim.Visible = 'Off';
handles.HighLim.Visible = 'Off';
handles.popLLim.Visible = 'Off';
handles.popLLim.String = {'0';'1';'10';'20';'30';'40';'50';'75';'100'};
handles.popHLim.Visible = 'Off';
handles.popHLim.String = {'10';'20';'30';'40';'50';'75';'100';'200';'254';'255'};
handles.LowClipPer.Visible = 'Off';
handles.HighClipPer.Visible = 'Off';
handles.popLClip.Visible = 'Off';
handles.popLClip.String = {'0.01';'0.02';'0.025';'0.03';'0.04';'0.05';'0.075';'0.1';'0.15'};
handles.popHClip.Visible = 'Off';
handles.popHClip.String = {'0.01';'0.02';'0.025';'0.03';'0.04';'0.05';'0.075';'0.1';'0.15'};
handles.text27.Visible = 'Off';
handles.EditMask.Visible = 'Off';


% Hint: get(hObject,'Value') returns toggle state of bDiv


% --- Executes on button press in bAnd.
function bAnd_Callback(hObject, eventdata, handles)
% hObject    handle to bAnd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Arithmatic
handles.curImage.Visible = 'On';
handles.secImage.Visible = 'On';
handles.selFirstimage.Visible = 'On';
handles.selSecondimage.Visible = 'On';
handles.cByC.Visible = 'Off';
handles.bIma1.Visible = 'On';
handles.bIma2.Visible = 'On';

% Mean
handles.p1.Visible = 'Off';
handles.p1.String = {'3';'5';'7';'9';'11'};
handles.maskSize.Visible = 'Off';
%Median
handles.MedianType.Visible = 'Off';
handles.ButtonMedianType.Visible = 'Off';
% Gaussian, Only Mask Size
% Laplacian
handles.LaplacianType.Visible = 'Off';
handles.LaplaType.Visible = 'Off';
% Difference
handles.DiffMask.Visible = 'Off';
handles.DiffType.Visible = 'Off';

% Crop
handles.UpLeftCol.Visible = 'Off';
handles.UpLeftRow.Visible = 'Off';
handles.Width.Visible = 'Off';
handles.Height.Visible = 'Off';
handles.popCcol.Visible = 'Off';
handles.popCcol.String = {'0';'8';'16';'32';'64';'128';'256';'512'};
handles.popCrow.Visible = 'Off';
handles.popCrow.String = {'0';'8';'16';'32';'64';'128';'256';'512'};
handles.popCwid.Visible = 'Off';
handles.popCwid.String = {'0';'8';'16';'32';'64';'100';'128';'256';'512'};
handles.popChei.Visible = 'Off';
handles.popChei.String = {'0';'8';'16';'32';'64';'100';'128';'256';'512'};

% Zoom

handles.By.Visible = 'Off';
handles.popCfac.Visible = 'Off';
handles.popBmet.Visible = 'Off';

% Grey Level Quant
handles.popGquant.Visible = 'Off';
handles.NumGrayLevel.Visible = 'Off';
handles.popNgray.Visible = 'Off';

%Spat Quant
handles.WidSpat.Visible = 'Off';
handles.popRwid.Visible = 'Off';
handles.HeiSpat.Visible = 'Off';
handles.popRhei.Visible = 'Off';
handles.MetSpat.Visible = 'Off';
handles.popMSpa.Visible = 'Off';

% HistEqual

handles.popHistEqu.Visible = 'Off';
handles.OnBand.Visible = 'Off';

% Hist Stretch
handles.LowLim.Visible = 'Off';
handles.HighLim.Visible = 'Off';
handles.popLLim.Visible = 'Off';
handles.popLLim.String = {'0';'1';'10';'20';'30';'40';'50';'75';'100'};
handles.popHLim.Visible = 'Off';
handles.popHLim.String = {'10';'20';'30';'40';'50';'75';'100';'200';'254';'255'};
handles.LowClipPer.Visible = 'Off';
handles.HighClipPer.Visible = 'Off';
handles.popLClip.Visible = 'Off';
handles.popLClip.String = {'0.01';'0.02';'0.025';'0.03';'0.04';'0.05';'0.075';'0.1';'0.15'};
handles.popHClip.Visible = 'Off';
handles.popHClip.String = {'0.01';'0.02';'0.025';'0.03';'0.04';'0.05';'0.075';'0.1';'0.15'};
handles.text27.Visible = 'Off';


% Hint: get(hObject,'Value') returns toggle state of bAnd


% --- Executes on button press in bNOT.
function bNOT_Callback(hObject, eventdata, handles)
% hObject    handle to bNOT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Arithmatic
handles.curImage.Visible = 'On';
handles.secImage.Visible = 'On';
handles.selFirstimage.Visible = 'On';
handles.selSecondimage.Visible = 'On';
handles.cByC.Visible = 'Off';
handles.bIma1.Visible = 'On';
handles.bIma2.Visible = 'On';

% Mean
handles.p1.Visible = 'Off';
handles.p1.String = {'3';'5';'7';'9';'11'};
handles.maskSize.Visible = 'Off';
%Median
handles.MedianType.Visible = 'Off';
handles.ButtonMedianType.Visible = 'Off';
% Gaussian, Only Mask Size
% Laplacian
handles.LaplacianType.Visible = 'Off';
handles.LaplaType.Visible = 'Off';
% Difference
handles.DiffMask.Visible = 'Off';
handles.DiffType.Visible = 'Off';

% Crop
handles.UpLeftCol.Visible = 'Off';
handles.UpLeftRow.Visible = 'Off';
handles.Width.Visible = 'Off';
handles.Height.Visible = 'Off';
handles.popCcol.Visible = 'Off';
handles.popCcol.String = {'0';'8';'16';'32';'64';'128';'256';'512'};
handles.popCrow.Visible = 'Off';
handles.popCrow.String = {'0';'8';'16';'32';'64';'128';'256';'512'};
handles.popCwid.Visible = 'Off';
handles.popCwid.String = {'0';'8';'16';'32';'64';'100';'128';'256';'512'};
handles.popChei.Visible = 'Off';
handles.popChei.String = {'0';'8';'16';'32';'64';'100';'128';'256';'512'};

% Zoom

handles.By.Visible = 'Off';
handles.popCfac.Visible = 'Off';
handles.popBmet.Visible = 'Off';

% Grey Level Quant
handles.popGquant.Visible = 'Off';
handles.NumGrayLevel.Visible = 'Off';
handles.popNgray.Visible = 'Off';

%Spat Quant
handles.WidSpat.Visible = 'Off';
handles.popRwid.Visible = 'Off';
handles.HeiSpat.Visible = 'Off';
handles.popRhei.Visible = 'Off';
handles.MetSpat.Visible = 'Off';
handles.popMSpa.Visible = 'Off';

% HistEqual

handles.popHistEqu.Visible = 'Off';
handles.OnBand.Visible = 'Off';

% Hist Stretch
handles.LowLim.Visible = 'Off';
handles.HighLim.Visible = 'Off';
handles.popLLim.Visible = 'Off';
handles.popLLim.String = {'0';'1';'10';'20';'30';'40';'50';'75';'100'};
handles.popHLim.Visible = 'Off';
handles.popHLim.String = {'10';'20';'30';'40';'50';'75';'100';'200';'254';'255'};
handles.LowClipPer.Visible = 'Off';
handles.HighClipPer.Visible = 'Off';
handles.popLClip.Visible = 'Off';
handles.popLClip.String = {'0.01';'0.02';'0.025';'0.03';'0.04';'0.05';'0.075';'0.1';'0.15'};
handles.popHClip.Visible = 'Off';
handles.popHClip.String = {'0.01';'0.02';'0.025';'0.03';'0.04';'0.05';'0.075';'0.1';'0.15'};
handles.text27.Visible = 'Off';
handles.EditMask.Visible = 'Off';


% Hint: get(hObject,'Value') returns toggle state of bNOT


% --- Executes on button press in bOr.
function bOr_Callback(hObject, eventdata, handles)
% hObject    handle to bOr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Arithmatic
handles.curImage.Visible = 'On';
handles.secImage.Visible = 'On';
handles.selFirstimage.Visible = 'On';
handles.selSecondimage.Visible = 'On';
handles.cByC.Visible = 'Off';
handles.bIma1.Visible = 'On';
handles.bIma2.Visible = 'On';

% Mean
handles.p1.Visible = 'Off';
handles.p1.String = {'3';'5';'7';'9';'11'};
handles.maskSize.Visible = 'Off';
%Median
handles.MedianType.Visible = 'Off';
handles.ButtonMedianType.Visible = 'Off';
% Gaussian, Only Mask Size
% Laplacian
handles.LaplacianType.Visible = 'Off';
handles.LaplaType.Visible = 'Off';
% Difference
handles.DiffMask.Visible = 'Off';
handles.DiffType.Visible = 'Off';

% Crop
handles.UpLeftCol.Visible = 'Off';
handles.UpLeftRow.Visible = 'Off';
handles.Width.Visible = 'Off';
handles.Height.Visible = 'Off';
handles.popCcol.Visible = 'Off';
handles.popCcol.String = {'0';'8';'16';'32';'64';'128';'256';'512'};
handles.popCrow.Visible = 'Off';
handles.popCrow.String = {'0';'8';'16';'32';'64';'128';'256';'512'};
handles.popCwid.Visible = 'Off';
handles.popCwid.String = {'0';'8';'16';'32';'64';'100';'128';'256';'512'};
handles.popChei.Visible = 'Off';
handles.popChei.String = {'0';'8';'16';'32';'64';'100';'128';'256';'512'};

% Zoom

handles.By.Visible = 'Off';
handles.popCfac.Visible = 'Off';
handles.popBmet.Visible = 'Off';

% Grey Level Quant
handles.popGquant.Visible = 'Off';
handles.NumGrayLevel.Visible = 'Off';
handles.popNgray.Visible = 'Off';

%Spat Quant
handles.WidSpat.Visible = 'Off';
handles.popRwid.Visible = 'Off';
handles.HeiSpat.Visible = 'Off';
handles.popRhei.Visible = 'Off';
handles.MetSpat.Visible = 'Off';
handles.popMSpa.Visible = 'Off';

% HistEqual

handles.popHistEqu.Visible = 'Off';
handles.OnBand.Visible = 'Off';

% Hist Stretch
handles.LowLim.Visible = 'Off';
handles.HighLim.Visible = 'Off';
handles.popLLim.Visible = 'Off';
handles.popLLim.String = {'0';'1';'10';'20';'30';'40';'50';'75';'100'};
handles.popHLim.Visible = 'Off';
handles.popHLim.String = {'10';'20';'30';'40';'50';'75';'100';'200';'254';'255'};
handles.LowClipPer.Visible = 'Off';
handles.HighClipPer.Visible = 'Off';
handles.popLClip.Visible = 'Off';
handles.popLClip.String = {'0.01';'0.02';'0.025';'0.03';'0.04';'0.05';'0.075';'0.1';'0.15'};
handles.popHClip.Visible = 'Off';
handles.popHClip.String = {'0.01';'0.02';'0.025';'0.03';'0.04';'0.05';'0.075';'0.1';'0.15'};
handles.text27.Visible = 'Off';
handles.EditMask.Visible = 'Off';


% Hint: get(hObject,'Value') returns toggle state of bOr


% --- Executes on button press in bXor.
function bXor_Callback(hObject, eventdata, handles)
% hObject    handle to bXor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Arithmatic
handles.curImage.Visible = 'On';
handles.secImage.Visible = 'On';
handles.selFirstimage.Visible = 'On';
handles.selSecondimage.Visible = 'On';
handles.cByC.Visible = 'Off';
handles.bIma1.Visible = 'On';
handles.bIma2.Visible = 'On';

% Mean
handles.p1.Visible = 'Off';
handles.p1.String = {'3';'5';'7';'9';'11'};
handles.maskSize.Visible = 'Off';
%Median
handles.MedianType.Visible = 'Off';
handles.ButtonMedianType.Visible = 'Off';
% Gaussian, Only Mask Size
% Laplacian
handles.LaplacianType.Visible = 'Off';
handles.LaplaType.Visible = 'Off';
% Difference
handles.DiffMask.Visible = 'Off';
handles.DiffType.Visible = 'Off';

% Crop
handles.UpLeftCol.Visible = 'Off';
handles.UpLeftRow.Visible = 'Off';
handles.Width.Visible = 'Off';
handles.Height.Visible = 'Off';
handles.popCcol.Visible = 'Off';
handles.popCcol.String = {'0';'8';'16';'32';'64';'128';'256';'512'};
handles.popCrow.Visible = 'Off';
handles.popCrow.String = {'0';'8';'16';'32';'64';'128';'256';'512'};
handles.popCwid.Visible = 'Off';
handles.popCwid.String = {'0';'8';'16';'32';'64';'100';'128';'256';'512'};
handles.popChei.Visible = 'Off';
handles.popChei.String = {'0';'8';'16';'32';'64';'100';'128';'256';'512'};

% Zoom

handles.By.Visible = 'Off';
handles.popCfac.Visible = 'Off';
handles.popBmet.Visible = 'Off';

% Grey Level Quant
handles.popGquant.Visible = 'Off';
handles.NumGrayLevel.Visible = 'Off';
handles.popNgray.Visible = 'Off';

%Spat Quant
handles.WidSpat.Visible = 'Off';
handles.popRwid.Visible = 'Off';
handles.HeiSpat.Visible = 'Off';
handles.popRhei.Visible = 'Off';
handles.MetSpat.Visible = 'Off';
handles.popMSpa.Visible = 'Off';

% HistEqual

handles.popHistEqu.Visible = 'Off';
handles.OnBand.Visible = 'Off';

% Hist Stretch
handles.LowLim.Visible = 'Off';
handles.HighLim.Visible = 'Off';
handles.popLLim.Visible = 'Off';
handles.popLLim.String = {'0';'1';'10';'20';'30';'40';'50';'75';'100'};
handles.popHLim.Visible = 'Off';
handles.popHLim.String = {'10';'20';'30';'40';'50';'75';'100';'200';'254';'255'};
handles.LowClipPer.Visible = 'Off';
handles.HighClipPer.Visible = 'Off';
handles.popLClip.Visible = 'Off';
handles.popLClip.String = {'0.01';'0.02';'0.025';'0.03';'0.04';'0.05';'0.075';'0.1';'0.15'};
handles.popHClip.Visible = 'Off';
handles.popHClip.String = {'0.01';'0.02';'0.025';'0.03';'0.04';'0.05';'0.075';'0.1';'0.15'};
handles.text27.Visible = 'Off';
handles.EditMask.Visible = 'Off';


% --- Executes on button press in Stand.
function Stand_Callback(hObject, eventdata, handles)
% hObject    handle to Stand (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% Hint: get(hObject,'Value') returns toggle state of Stand


% --- Executes during object creation, after setting all properties.
function Stand_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Stand (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in radiobutton43.
function radiobutton43_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton43


% --- Executes on button press in Standard.
function Standard_Callback(hObject, eventdata, handles)
% hObject    handle to Standard (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Standard


% --- Executes on button press in Adaptive.
function Adaptive_Callback(hObject, eventdata, handles)
% hObject    handle to Adaptive (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Adaptive


% --- Executes on selection change in LaplaType.
function LaplaType_Callback(hObject, eventdata, handles)
% hObject    handle to LaplaType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns LaplaType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from LaplaType


% --- Executes during object creation, after setting all properties.
function LaplaType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LaplaType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in MedianType.
function MedianType_Callback(hObject, eventdata, handles)
% hObject    handle to MedianType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns MedianType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from MedianType


% --- Executes during object creation, after setting all properties.
function MedianType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MedianType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in DiffType.
function DiffType_Callback(hObject, eventdata, handles)
% hObject    handle to DiffType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns DiffType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from DiffType


% --- Executes during object creation, after setting all properties.
function DiffType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DiffType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function DiffMask_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DiffMask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in selFirstimage.
function selFirstimage_Callback(hObject, eventdata, handles)
% hObject    handle to selFirstimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns selFirstimage contents as cell array
%        contents{get(hObject,'Value')} returns selected item from selFirstimage


% --- Executes during object creation, after setting all properties.
function selFirstimage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selFirstimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to selFirstimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of selFirstimage as text
%        str2double(get(hObject,'String')) returns contents of selFirstimage as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selFirstimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to selSecondimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of selSecondimage as text
%        str2double(get(hObject,'String')) returns contents of selSecondimage as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selSecondimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bIma1.
function bIma1_Callback(hObject, eventdata, handles)
% hObject    handle to bIma1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc                             %clear screen
hMain = findobj('Tag','Main');  %get the handle of Main form
hNfig = hMain.UserData;         %get image handle
if hNfig ~= 0 && isfield(hNfig.UserData,'cvipIma')%check for Image to save
    file=get(hNfig,'Name');    	%get image name
    hObject.UserData = hNfig.UserData;%read image info
    handles.selFirstimage.String = file;  %show image name
end


% --- Executes on button press in bIma2.
function bIma2_Callback(hObject, eventdata, handles)
% hObject    handle to bIma2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc                             %clear screen
hMain = findobj('Tag','Main');  %get the handle of Main form
hNfig = hMain.UserData;         %get image handle
if hNfig ~= 0 && isfield(hNfig.UserData,'cvipIma')%check for Image to save
    file=get(hNfig,'Name');    	%get image name
    hObject.UserData = hNfig.UserData;%read image info
    handles.selSecondimage.String = file;  %show image name
end


% --- Executes on button press in cByC.
function cByC_Callback(hObject, eventdata, handles)
% hObject    handle to cByC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.cByC.Value && (handles.bAdd.Value || handles.bSub.Value)
    handles.popMCons.Visible = 'Off';
    handles.popCons.Visible = 'On';
    handles.cBClip.Visible = 'Off';
    handles.selSecondimage.Enable = 'Off';
    handles.bIma2.Enable = 'Off';
elseif handles.cByC.Value && (handles.bMul.Value || handles.bDiv.Value)
    handles.popMCons.Visible = 'On';
    handles.popCons.Visible = 'Off';    
    handles.cBClip.Visible = 'Off';
    handles.selSecondimage.Enable = 'Off';
    handles.bIma2.Enable = 'Off';
else
    handles.popMCons.Visible = 'Off';
    handles.popCons.Visible = 'Off';    
    handles.cBClip.Visible = 'Off';
    handles.selSecondimage.Enable = 'On';
    handles.bIma2.Enable = 'On';
end

% Hint: get(hObject,'Value') returns toggle state of cByC


% --- Executes on selection change in popCons.
function popCons_Callback(hObject, eventdata, handles)
% hObject    handle to popCons (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popCons contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popCons


% --- Executes during object creation, after setting all properties.
function popCons_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popCons (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cBClip.
function cBClip_Callback(hObject, eventdata, handles)
% hObject    handle to cBClip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cBClip


% --- Executes on button press in cNotB.
function cNotB_Callback(hObject, eventdata, handles)
% hObject    handle to cNotB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cNotB


% --- Executes on selection change in popGquant.
function popGquant_Callback(hObject, eventdata, handles)
% hObject    handle to popGquant (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popGquant contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popGquant


% --- Executes during object creation, after setting all properties.
function popGquant_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popGquant (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popHistEqu.
function popHistEqu_Callback(hObject, eventdata, handles)
% hObject    handle to popHistEqu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popHistEqu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popHistEqu


% --- Executes during object creation, after setting all properties.
function popHistEqu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popHistEqu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popCfac.
function popCfac_Callback(hObject, eventdata, handles)
% hObject    handle to popCfac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popCfac contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popCfac


% --- Executes during object creation, after setting all properties.
function popCfac_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popCfac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popBmet.
function popBmet_Callback(hObject, eventdata, handles)
% hObject    handle to popBmet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popBmet contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popBmet


% --- Executes during object creation, after setting all properties.
function popBmet_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popBmet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% % --- Executes during object creation, after setting all properties.
% function bHist_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to Preproc (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% 
% % --- Executes during object creation, after setting all properties.
% function uibuttongroup5_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to uibuttongroup5 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
pos = cellfun(@(x) {x-[0 get(handles.slider1,'value') 0 0]},handles.pos);
% added for stepping
set(handles.slider1, 'Min', 1);
set(handles.slider1, 'Max', 15); 
% set(handles.slider1, 'Value', 1);
set(handles.slider1, 'SliderStep', [1/(10-1) , 9/(10-1) ]);
% added close
set(handles.hListe,{'position'},pos)


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function Preproc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Preproc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function uibuttongroup5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uibuttongroup5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function Prepro_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Prepro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in cNotB.
function checkbox18_Callback(hObject, eventdata, handles)
% hObject    handle to cNotB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cNotB
