function varargout = mUCreate(varargin)
% MUCREATE MATLAB code for mUCreate.fig
%      MUCREATE, by itself, creates a new MUCREATE or raises the existing
%      singleton*.
%
%      H = MUCREATE returns the handle to a new MUCREATE or the handle to
%      the existing singleton*.
%
%      MUCREATE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MUCREATE.M with the given input arguments.
%
%      MUCREATE('Property','Value',...) creates a new MUCREATE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mUCreate_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mUCreate_OpeningFcn via
%      varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mUCreate

% Last Modified by GUIDE v2.5 08-Oct-2019 02:13:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mUCreate_OpeningFcn, ...
                   'gui_OutputFcn',  @mUCreate_OutputFcn, ...
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
%           Initial coding date:    /10/2017
%           Updated by:             Hridoy Biswas
%           Latest update date:     7/14/2020
%           Credit:                 Scott Umbaugh 
%                                   CVIP Lab, SIUE
%           Copyright (C) 2018 Scott Umbaugh and SIUE
%
%==========================================================================

% Revision History
 % Revision 1.5  10/02/2019 15:18:34 jolden
 % included the generalized function for creating a polygon
%
 % Revision 1.4  06/04/2019  22:33:25  jucuell
 % including functions to create sine, cosine and square waves, including
 % the creation of gray and black images in the grayscale image.
%
 % Revision 1.3  12/12/2018  17:11:54  jucuell
 % updating menu creation programmatically, callbacks to Main figure and
 % the use of the utilities menus in the Main figure.
%
 % Revision 1.1  11/21/2017  15:23:31  jucuell
 % Initial revision: Initial coding and testing
%Revision 7/14/20 Hridoy
% Add border image and border mask,update ellipse 

% --- Executes just before mUCreate is made visible.
function mUCreate_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mUCreate (see VARARGIN)

% Choose default command line output for mUCreate
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
handles.msg.Visible='Off';
% create figure menus linked to menu functions in CVIPToolbox figure
menu_add_cvip(hObject);
handles.mAna.Visible = 'Off';%hide Analysis menu
handles.popPoly.Visible = 'Off';
handles.cPHole.Visible = 'Off';
handles.popHole.Visible = 'Off';

hUtil = findobj('Tag','mUshos');
% hUtil(1).MenuSelectedFcn=@(hObject,eventdata)CVIPToolbox('mUshow_Callback',...
%     hObject,'Crea',guidata(hObject));
hUtil(1).Callback=@(hObject,eventdata)CVIPToolbox('mUshow_Callback',...
    hObject,'Crea',guidata(hObject));

% --- Outputs from this function are returned to the command line.
function varargout = mUCreate_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in bCancel.
function bCancel_Callback(hObject, eventdata, handles)
% hObject    handle to bCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Prepare to close application window
 close(handles.Crea)


% --- Executes on button press in bReset.
function bReset_Callback(hObject, eventdata, handles)
% hObject    handle to bReset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in bApply.
function bApply_Callback(hObject, eventdata, handles)
% hObject    handle to bApply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc

%changing pointer arrow to watch on cursor
figure_set = findall(groot,'Type','Figure');
set(figure_set,'pointer','watch');

hMain = findobj('Tag','Main');      %get the handle of Main figure
hSHisto = findobj('Tag','mVsaveHis');%get handle of Save history menu
hVfinfo = findobj('Tag','mVfi');    %get handle of menu view fun information

if ~handles.bAddN.Value && ~handles.bExtrac.Value && ~handles.bAssB.Value && ~handles.bor_mask.Value && ~handles.border_image.Value
%Image creation operations    
if handles.bCCheck.Value==1         %Create Checkerboard 
    height = str2double(handles.popGWidth.String(handles.popGWidth.Value));
    width = str2double(handles.popGHeight.String(handles.popGHeight.Value));
    startrow = str2double(handles.popY.String(handles.popY.Value));
    startcol = str2double(handles.popX.String(handles.popX.Value));
    rectwidth = str2double(handles.popOWid.String(handles.popOWid.Value));
    rectheight = str2double(handles.popOHei.String(handles.popOHei.Value));
    R = str2double(handles.popGR.String(handles.popGR.Value));
    G = str2double(handles.popGG.String(handles.popGG.Value));
    B = str2double(handles.popGB.String(handles.popGB.Value));
    if handles.cCGrgb.Value
        bands = 3;                  %RGB filled
        Name = strcat('Checkerboard [',num2str(rectwidth),'x',num2str(rectheight),'](',num2str(R),',',num2str(G),',',num2str(B),')');
    else
        bands = 1;                  %Black and Whithe Image
        Name = strcat('Checkerboard [',num2str(rectwidth),'x',num2str(rectheight),'](B/W)');
    end
    %call create image function
    OutIma = checkboard_cvip(height, width, startrow, startcol, rectheight, rectwidth, bands, R, G, B);
    objec = 10;
    
elseif handles.bCRec.Value==1         %Create Rectangle 
    width = str2double(handles.popGWidth.String(handles.popGWidth.Value));
    height = str2double(handles.popGHeight.String(handles.popGHeight.Value));
    startrow = str2double(handles.popY.String(handles.popY.Value));
    startcol = str2double(handles.popX.String(handles.popX.Value));
    endrow = str2double(handles.popOWid.String(handles.popOWid.Value));
    endcol = str2double(handles.popOHei.String(handles.popOHei.Value));
    R = str2double(handles.popGR.String(handles.popGR.Value));
    G = str2double(handles.popGG.String(handles.popGG.Value));
    B = str2double(handles.popGB.String(handles.popGB.Value));
    if handles.cCGrgb.Value
        bands = 3;                  %RGB filled
    else
        bands = 1;                  %Black and Whithe Image
    end
    if handles.cOutl.Value
        objec = 3;                  %Rect Outline
        if bands == 1
            Name = strcat('Rectangle Outline [',num2str(endrow),'x',num2str(endcol),'](B/W)');
        else
            Name = strcat('Rectangle Outline [',num2str(endrow),'x',num2str(endcol),'](',num2str(R),',',num2str(G),',',num2str(B),')');
        end
    else
        objec = 4;                  %Filled Rect
        if bands == 1
            Name = strcat('Filled Rectangle [',num2str(endrow),'x',num2str(endcol),'](B/W)');
        else
            Name = strcat('Filled Rectangle [',num2str(endrow),'x',num2str(endcol),'](',num2str(R),',',num2str(G),',',num2str(B),')');
        end
    end
    %call create image function
    OutIma = create_image_cvip(height, width, objec, startrow, startcol, endrow, endcol, bands, R, G, B);

elseif handles.bCCir.Value==1         %Create Circle 
    width = str2double(handles.popGWidth.String(handles.popGWidth.Value));
    height = str2double(handles.popGHeight.String(handles.popGHeight.Value));
    startrow = str2double(handles.popY.String(handles.popY.Value));
    startcol = str2double(handles.popX.String(handles.popX.Value));
    radius = str2double(handles.popOWid.String(handles.popOWid.Value));
    radius2 = str2double(handles.popOHei.String(handles.popOHei.Value));
    R = str2double(handles.popGR.String(handles.popGR.Value));
    G = str2double(handles.popGG.String(handles.popGG.Value));
    B = str2double(handles.popGB.String(handles.popGB.Value));
    if handles.cCGrgb.Value
        bands = 3;                  %RGB filled
    else
        bands = 1;                  %Black and Whithe Image
    end
    if handles.cOutl.Value
        objec = 7;                  %Circle Outline
        if bands == 1
            Name = strcat('Circle Outline [',num2str(radius),'](B/W)');
        else
            Name = strcat('Circle Outline [',num2str(radius),'](',num2str(R),',',num2str(G),',',num2str(B),')');
        end
    else
        objec = 8;                  %Filled Circle
        if bands == 1
            Name = strcat('Filled Circle [',num2str(radius),'](B/W)');
        else
            Name = strcat('Filled Circle [',num2str(radius),'](',num2str(R),',',num2str(G),',',num2str(B),')');
        end
    end
    %call create image function
    if handles.cBlur.Value          %Blur circle
        OutIma = create_image_cvip(height, width, 9, startrow, startcol, radius, radius2, bands, R, G, B);
        Name = strcat('Blur Circle [',num2str(radius),'-',num2str(radius2),'],(',num2str(R),',',num2str(G),',',num2str(B),')');
    else
        OutIma = create_image_cvip(height, width, objec, startrow, startcol, radius, bands, R, G, B);
    end

elseif handles.bCElli.Value==1         %Create Ellipse 
    width = str2double(handles.popGWidth.String(handles.popGWidth.Value));
    height = str2double(handles.popGHeight.String(handles.popGHeight.Value));
    startrow = str2double(handles.popY.String(handles.popY.Value));
    startcol = str2double(handles.popX.String(handles.popX.Value));
    endrow = str2double(handles.popOWid.String(handles.popOWid.Value));
    endcol = str2double(handles.popOHei.String(handles.popOHei.Value));
    R = str2double(handles.popGR.String(handles.popGR.Value));
    G = str2double(handles.popGG.String(handles.popGG.Value));
    B = str2double(handles.popGB.String(handles.popGB.Value));
    
    if handles.cCGrgb.Value
        bands = 3;                  %RGB filled
        Name = strcat('Ellipse [',num2str(endrow),'x',num2str(endcol),'](',num2str(R),',',num2str(G),',',num2str(B),')');
    else
        bands = 1;                  %Black and Whithe Image
        Name = strcat('Ellipse [',num2str(endrow),'x',num2str(endcol),'](B/W)');
    end
    
    %call create image function
    OutIma = create_image_cvip(height, width, 5, startrow, startcol, endrow, endcol, bands, R, G, B);
    objec = 5;

elseif handles.bCDia.Value==1         %Create Diamond 
    width = str2double(handles.popGWidth.String(handles.popGWidth.Value));
    height = str2double(handles.popGHeight.String(handles.popGHeight.Value));
    startrow = str2double(handles.popY.String(handles.popY.Value));
    startcol = str2double(handles.popX.String(handles.popX.Value));
    endrow = str2double(handles.popOWid.String(handles.popOWid.Value));
    endcol = str2double(handles.popOHei.String(handles.popOHei.Value));
    R = str2double(handles.popGR.String(handles.popGR.Value));
    G = str2double(handles.popGG.String(handles.popGG.Value));
    B = str2double(handles.popGB.String(handles.popGB.Value));
    
    if handles.cCGrgb.Value
        bands = 3;                  %RGB filled
        Name = strcat('Diamond [',num2str(endrow),'x',num2str(endcol),'](',num2str(R),',',num2str(G),',',num2str(B),')');
    else
        bands = 1;                  %Black and Whithe Image
        Name = strcat('Diamond [',num2str(endrow),'x',num2str(endcol),'](B/W)');
    end
    
    %call create image function
    OutIma = create_image_cvip(height, width, 6, startrow, startcol, endrow, endcol, bands, R, G, B);
    objec = 6;

elseif handles.bCLin.Value==1         %Create Line
    width = str2double(handles.popGWidth.String(handles.popGWidth.Value));
    height = str2double(handles.popGHeight.String(handles.popGHeight.Value));
    startrow = str2double(handles.popY.String(handles.popY.Value));
    startcol = str2double(handles.popX.String(handles.popX.Value));
    endrow = str2double(handles.popOWid.String(handles.popOWid.Value));
    endcol = str2double(handles.popOHei.String(handles.popOHei.Value));
    R = str2double(handles.popGR.String(handles.popGR.Value));
    G = str2double(handles.popGG.String(handles.popGG.Value));
    B = str2double(handles.popGB.String(handles.popGB.Value));
    
    if startrow == 0
        startrow = 1;
    end
    if startcol == 0
        startcol = 1;
    end
    if handles.cCGrgb.Value
        bands = 3;                  %RGB Outline
        Name = strcat('Line [',num2str(startcol),',',num2str(startrow),'-',num2str(endcol),',',num2str(endrow),'](',num2str(R),',',num2str(G),',',num2str(B),')');
    else
        bands = 1;                  %Black and Whithe Outline
        Name = strcat('Line [',num2str(startcol),',',num2str(startrow),'-',num2str(endcol),',',num2str(endrow),'](B/W)');
    end
    
    %call create image function
    OutIma = create_image_cvip(height, width, 2, startrow, startcol, endrow, endcol, bands, R, G, B);
    objec = 2;
    
elseif handles.bPoly.Value == 1 %Polygon
    if handles.cPHole.Value && handles.cOutl.Value
        error('Cannot perform the operation with both a hole and only an outline');
    end
    ImSize = [str2double(handles.popGWidth.String(handles.popGWidth.Value))... 
              str2double(handles.popGHeight.String(handles.popGHeight.Value))];
    radius = str2double(handles.popOWid.String(handles.popOWid.Value));
    sides = str2double(handles.popPoly.String(handles.popPoly.Value));
    center = [str2double(handles.popX.String(handles.popX.Value))... 
              str2double(handles.popY.String(handles.popY.Value))];
    color = [str2double(handles.popGR.String(handles.popGR.Value))... 
             str2double(handles.popGG.String(handles.popGG.Value))... 
             str2double(handles.popGB.String(handles.popGB.Value))];
    if handles.cPHole.Value == 1
        hole_radius = str2double(handles.popHole.String(handles.popHole.Value));
        OutIma = polygon_cvip(ImSize,sides,radius,center,color,[]);
        OutIma = polygon_cvip(ImSize,sides,hole_radius,center,[0 0 0],[],OutIma);
    elseif handles.cOutl.Value == 1
        OutIma = polygon_cvip(ImSize,sides,radius,center,color,[]);
        OutIma = polygon_cvip(ImSize,sides,radius-2,center,[0 0 0],[],OutIma);
    else 
        OutIma = polygon_cvip(ImSize,sides,radius,center,color,[]);
    end
    objec = 14;
elseif handles.bCblak.Value==1      %Create Gray Level Image 
    width = str2double(handles.popIWid.String(handles.popIWid.Value));
    height = str2double(handles.popIHei.String(handles.popIHei.Value));
    Gray = str2double(handles.popGray.String(handles.popGray.Value));
    %call create image function
    OutIma = create_image_cvip(height, width, 1, 1, Gray);
    objec = 1;
elseif handles.bCrgb.Value==1       %Create RGB Image
    width = str2double(handles.popIWid.String(handles.popIWid.Value));
    height = str2double(handles.popIHei.String(handles.popIHei.Value));
    R = str2double(handles.popCRed.String(handles.popCRed.Value));
    G = str2double(handles.popCGre.String(handles.popCGre.Value));
    B = str2double(handles.popCBlu.String(handles.popCBlu.Value));
    %call create image function
    OutIma = create_image_cvip(height, width, 1, 3, R, G, B);
    objec = 1;
elseif handles.bCCos.Value==1       %Create Cosine Wave
    width = str2double(handles.popWWid.String(handles.popWWid.Value));
    height = str2double(handles.popWHei.String(handles.popWHei.Value));
    freq = str2double(handles.popWFreq.String(handles.popWFreq.Value));
    dir = handles.popWDir.Value;
    R = str2double(handles.popWred.String(handles.popWred.Value));
    G = str2double(handles.popWgre.String(handles.popWgre.Value));
    B = str2double(handles.popWblu.String(handles.popWblu.Value));
    bands = double(handles.cWrgb.Value)*2+1;
    %call create image function
    OutIma = create_image_cvip(height, width, 11, freq, dir, bands, R, G, B);
    objec = 11;
elseif handles.bCSin.Value==1       %Create Sine
    width = str2double(handles.popWWid.String(handles.popWWid.Value));
    height = str2double(handles.popWHei.String(handles.popWHei.Value));
    freq = str2double(handles.popWFreq.String(handles.popWFreq.Value));
    dir = handles.popWDir.Value;
    R = str2double(handles.popWred.String(handles.popWred.Value));
    G = str2double(handles.popWgre.String(handles.popWgre.Value));
    B = str2double(handles.popWblu.String(handles.popWblu.Value));
    bands = double(handles.cWrgb.Value)*2+1;
    %call create image function
    OutIma = create_image_cvip(height, width, 12, freq, dir, bands, R, G, B);
    objec = 12;
elseif handles.bCSqu.Value==1       %Create Square Wave
    width = str2double(handles.popWWid.String(handles.popWWid.Value));
    height = str2double(handles.popWHei.String(handles.popWHei.Value));
    freq = str2double(handles.popWFreq.String(handles.popWFreq.Value));
    dir = handles.popWDir.Value;
    R = str2double(handles.popWred.String(handles.popWred.Value));
    G = str2double(handles.popWgre.String(handles.popWgre.Value));
    B = str2double(handles.popWblu.String(handles.popWblu.Value));
    bands = double(handles.cWrgb.Value)*2+1;
    %call create image function
    OutIma = create_image_cvip(height, width, 13, freq, dir, bands, R, G, B);
    objec = 13;    
end
histo = [37 objec]; file ='Create Object';
[row,col,band]=size(OutIma);      
Ima.fInfo.file_size = row*col*band*8;       	%file size
Ima.fInfo.filename = file;
Ima.fInfo.file_mod_date = date;                 %File modification date
Ima.fInfo.image_format = 'rgb';                 %image format
Ima.fInfo.color_format = 'rgb';                 %Colorspace format
Ima.fInfo.cvip_type = 'DOUBLE';                  %Data type 
Ima.fInfo.data_format= 'real'; 
Ima.fInfo.cmpr_format = 'none';
Ima.fInfo.history_info = 'none';
Name = [file ' > ' num2str(objec)];

%operations that requires input images
else
hNfig = hMain.UserData;       %get image handle    
if handles.bAssB.Value
    Ima1 = handles.bRIma.UserData;	%get image1 handle
    Ima2 = handles.bGIma.UserData;	%get image2 handle
    Ima3 = handles.bBIma.UserData;	%get image3 handle
end

histo = 0; OutIma = 0;              %initial  vbles values
%check for Image to process
if hNfig == 0 || isempty(hNfig) || ~isfield(hNfig.UserData,'cvipIma')
    errordlg(['There is nothing to process. Please select an Image and '...
        'try again.'],'Create Error','modal'); 
    
%check for Image to process
elseif handles.bExtrac.Value && size(hNfig.UserData.cvipIma,3) ~= 3
    errordlg(['This operation requires a Color Image. Please select a '...
        'Color Image and try again.'],'Create Error','modal');     

%check for required second and third images
elseif handles.bAssB.Value && (isempty(Ima2.cvipIma) || ~isfield(Ima2,'cvipIma')...
        || isempty(Ima3.cvipIma) || ~isfield(Ima3,'cvipIma'))
    errordlg(['This operation requires 3 Images. Select 3'...
                ' Images and try again!'],'Create Error','modal');
else
Ima = hNfig.UserData;               %get image information    
InIma = Ima.cvipIma;                %read image data
file=get(hNfig,'Name');

if handles.bAddN.Value==1           %add noise
    width = str2double(handles.popIWid.String(handles.popIWid.Value));
    height = str2double(handles.popIHei.String(handles.popIHei.Value));
    if handles.cNBlac.Value         %use black image
        InIma = [];
        file = 'Black Image';
    end
    
    var = str2double(handles.popNVar.String(handles.popNVar.Value));
    alMe = str2double(handles.popNAlp.String(handles.popNAlp.Value));
    switch handles.popNTyp.Value
        case 1                      %Gamma noise
            OutIma = gamma_noise_cvip(InIma, [alMe var], [height width]);      %call noise function
            Name = strcat(file, '> Gamma Noise (',num2str(var),',',num2str(alMe),')');
        case 2                      %Gaussian noise
            OutIma = gaussian_noise_cvip(InIma, [alMe var], [height width]);    %call noise function
            Name = strcat(file, '> Gaussian Noise (',num2str(var),',',num2str(alMe),')');
        case 3                      %Neg Exponential noise
            OutIma = neg_exp_noise_cvip(InIma, var, [height width]);            %call noise function
            Name = strcat(file, '> Neg. Exponential Noise (',num2str(var),')');
        case 4                      %Rayleigh noise
            OutIma = rayleigh_noise_cvip(InIma, var, [height width]);      %call noise function
            Name = strcat(file, '> Rayleigh Noise (',num2str(var),')');
        case 5                      %Salt n Pepper noise
            Pepp = str2double(handles.popNPep.String(handles.popNPep.Value));
            Salt = str2double(handles.popNAlp.String(handles.popNAlp.Value));
            OutIma = salt_pepper_noise_cvip(InIma, [Salt Pepp], [height width]);      %call noise function
            Name = strcat(file, '> Salt n Pepper Noise (',num2str(Pepp),',',num2str(Salt),')');
        case 6                      %Uniform noise
            OutIma = uniform_noise_cvip(InIma, [alMe var], [height width]);      %call noise function
            Name = strcat(file, '> Uniform Noise (',num2str(var),',',num2str(alMe),')');
    end
    
elseif handles.bExtrac.Value

    if handles.cExtR.Value
        OutIma = extract_band_cvip(InIma, 1);
        Name = [file, '> Red Band '];       %image name
        histo = [10 1];
    end
    if handles.cExtG.Value
        if ~handles.cEAllB.Value
            OutIma = extract_band_cvip(InIma, 2);
            Name = [file, '> Green Band '];       %image name
        else
            OutIma1 = extract_band_cvip(InIma, 2);
            Name1 = [file, '> Green Band '];       %image name
        end
        
        histo = [10 2];
    end
    if handles.cExtB.Value
         if ~handles.cEAllB.Value
             OutIma = extract_band_cvip(InIma, 3);
             Name = [file, '> Blue Band '];       %image name
         else
             OutIma2 = extract_band_cvip(InIma, 3);
             Name2 = [file, '> Blue Band '];       %image name
         end
        
        histo = [10 3];
    end  
    if handles.cEAllB.Value
        [row,col,band]=size(OutIma1);                    %get new image size
        %update image information
        Ima.fInfo.no_of_bands=band;             
        Ima.fInfo.no_of_cols=col;              
        Ima.fInfo.no_of_rows=row;
        %update image structure
        Ima.cvipIma = OutIma1;                           %read image data
        showgui_cvip(Ima, Name1);                        %show image in viewer
        %update image structure
        Ima.cvipIma = OutIma2;                           %read image data
        showgui_cvip(Ima, Name2);                        %show image in viewer
        histo = [10 1; 10 2; 10 3];
    end
    
elseif handles.bAssB.Value
    R=Ima1.cvipIma(:,:,1);
    G=Ima2.cvipIma(:,:,1);
    B=Ima3.cvipIma(:,:,1);
    OutIma = assemble_bands_cvip(R,G,B);
    Name = [file,' > Assembled Image '];       %show image
    histo = 9;
elseif handles.bor_mask.Value %% create border mask
    hasIPT = license('test', 'image_toolbox');
     if ~hasIPT
  % User does not have the toolbox installed.
     message = sprintf('Sorry, but you do not seem to have imfreehand() function.');
%      reply = questdlg(message, 'Toolbox missing', 'Yes', 'No', 'Yes');
%      if strcmpi(reply, 'No')
%     % User said No, so exit.
%      return;
%      end
%      end
    else
    message = sprintf('First select the image and then left click and hold the mouse to begin drawing.\nSimply lift the mouse button to finish');
    uiwait(msgbox(message));
    hFH = imfreehand();
   % Create a binary image ("mask") from the ROI object.
    OutIma = hFH.createMask();
    delete(hFH);
    Name = [file ' > Border Mask '];       %show image
    histo = 10;
    end
elseif handles.border_image.Value %% create border mask
     hasIPT = license('test', 'image_toolbox');
     if ~hasIPT
  % User does not have the toolbox installed.
     message = sprintf('Sorry, but you do not seem to have imfreehand() function');

    else
    message = sprintf('First select the image and then left click and hold the mouse to begin drawing.\nSimply lift the mouse button to finish');
    uiwait(msgbox(message));
    hFH = imfreehand();
    mask = hFH.createMask();
% Create a binary image ("mask") from the ROI object.
     structBoundaries = bwboundaries(mask);
     xy=structBoundaries{1}; % Get n by 2 array of x,y coordinates.
     x = xy(:, 2); % Columns.
     y = xy(:, 1);
      % Don't blow away the image.
     delete(hFH);
     OutIma=InIma;
     
    
     Name = [file ' > Border Image '];       %show image
     histo = 11;
     end
end
end
end

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

showgui_cvip(Ima, Name); 
 %show image in viewer
 if handles.border_image.Value
%      plot(x, y, 'LineWidth', 2);
%      drawnow;
    R = str2double(handles.popCRed.String(handles.popCRed.Value))/255;
    G = str2double(handles.popCGre.String(handles.popCGre.Value))/255;
    B = str2double(handles.popCBlu.String(handles.popCBlu.Value))/255;
     hold on;
     plot(x, y,'Color',[R,G,B], 'LineWidth', 2);
%     draw now

 end
end



%changing pointer watch back to arrow on cursor
set(figure_set,'pointer','arrow');


%%BORDER MASK OR BORDER IMAGE:
% imshow(getimage(hNfig));
% h = imfreehand;
% pos = h.getPosition();

% dcm_obj = datacursormode(hNfig);
% set(dcm_obj,'DisplayStyle','datatip',...
% 'SnapToDataVertex','off','Enable','on')
% c_info = getCursorInfo(dcm_obj)


function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popIWid.
function popIWid_Callback(hObject, eventdata, handles)
% hObject    handle to popIWid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popIWid contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popIWid


% --- Executes during object creation, after setting all properties.
function popIWid_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popIWid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
hObject.UserData = struct ('count',0,'letra','');

% --- Executes on key press with focus on popIWid and none of its controls.
function popIWid_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popIWid (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clc
if ~strcmp(eventdata.Key, 'shift')
    hObject.UserData = struct ('count',hObject.UserData.count + 1,'letra',[hObject.UserData.letra eventdata.Character]);
    hObject.Value = 9;
    hObject.String{9,:} = hObject.UserData.letra;
    if strcmp(eventdata.Key, 'return')
        if isnan(str2double(hObject.String{9,:}))
            warndlg('Input value is Not a Number','Create Warning','Modal');
            hObject.Value = 6;
            hObject.String{9,:} = ' ';
            hObject.UserData.count = 0;
            hObject.UserData.letra = '';
        else
            hObject.UserData.count = 0;
            hObject.UserData.letra = '';
            hObject.Value = 9;
        end
    end
end


% --- Executes on selection change in popIHei.
function popIHei_Callback(hObject, eventdata, handles)
% hObject    handle to popIHei (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popIHei contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popIHei


% --- Executes during object creation, after setting all properties.
function popIHei_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popIHei (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
hObject.UserData = struct ('count',0,'letra','');

% --- Executes on key press with focus on popIHei and none of its controls.
function popIHei_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popIHei (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clc
if ~strcmp(eventdata.Key, 'shift')
    hObject.UserData = struct ('count',hObject.UserData.count + 1,'letra',[hObject.UserData.letra eventdata.Character]);
    hObject.Value = 9;
    hObject.String{9,:} = hObject.UserData.letra;
    if strcmp(eventdata.Key, 'return')
        if isnan(str2double(hObject.String{9,:}))
            warndlg('Input value is Not a Number','Create Warning','Modal');
            hObject.Value = 6;
            hObject.String{9,:} = ' ';
            hObject.UserData.count = 0;
            hObject.UserData.letra = '';
        else
            hObject.UserData.count = 0;
            hObject.UserData.letra = '';
            hObject.Value = 9;
        end
    end
end


% --- Executes on selection change in popCRed.
function popCRed_Callback(hObject, eventdata, handles)
% hObject    handle to popCRed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popCRed contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popCRed
if handles.cCrgb.Value
    R = str2double(handles.popCRed.String(handles.popCRed.Value));
    G = str2double(handles.popCGre.String(handles.popCGre.Value));
    B = str2double(handles.popCBlu.String(handles.popCBlu.Value));
    handles.pRGB.BackgroundColor = [R G B]/255;
end

% --- Executes during object creation, after setting all properties.
function popCRed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popCRed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
hObject.UserData = struct ('count',0,'letra','');

% --- Executes on selection change in popCGre.
function popCGre_Callback(hObject, eventdata, handles)
% hObject    handle to popCGre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popCGre contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popCGre
if handles.cCrgb.Value
    R = str2double(handles.popCRed.String(handles.popCRed.Value));
    G = str2double(handles.popCGre.String(handles.popCGre.Value));
    B = str2double(handles.popCBlu.String(handles.popCBlu.Value));
    handles.pRGB.BackgroundColor = [R G B]/255;
end

% --- Executes during object creation, after setting all properties.
function popCGre_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popCGre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
hObject.UserData = struct ('count',0,'letra','');

% --- Executes on selection change in popCBlu.
function popCBlu_Callback(hObject, eventdata, handles)
% hObject    handle to popCBlu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popCBlu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popCBlu
if handles.cCrgb.Value
    R = str2double(handles.popCRed.String(handles.popCRed.Value));
    G = str2double(handles.popCGre.String(handles.popCGre.Value));
    B = str2double(handles.popCBlu.String(handles.popCBlu.Value));
    handles.pRGB.BackgroundColor = [R G B]/255;

end

% --- Executes during object creation, after setting all properties.
function popCBlu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popCBlu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
hObject.UserData = struct ('count',0,'letra','');

% --- Executes on button press in cCrgb.
function cCrgb_Callback(hObject, eventdata, handles)
% hObject    handle to cCrgb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cCrgb
if hObject.Value
    R = str2double(handles.popCRed.String(handles.popCRed.Value));
    G = str2double(handles.popCGre.String(handles.popCGre.Value));
    B = str2double(handles.popCBlu.String(handles.popCBlu.Value));
    handles.pRGB.BackgroundColor = [R G B]/255;
    handles.pRGB.Visible = 'On';
else
    handles.pRGB.Visible = 'Off'; 
end

% --- Executes on key press with focus on popCGre and none of its controls.
function popCGre_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popCGre (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clc
if ~strcmp(eventdata.Key, 'shift')
    hObject.UserData = struct ('count',hObject.UserData.count + 1,'letra',[hObject.UserData.letra eventdata.Character]);
    hObject.Value = 10;
    hObject.String{10,:} = hObject.UserData.letra;
    if strcmp(eventdata.Key, 'return')
        if isnan(str2double(hObject.String{9,:}))
            warndlg('Input value is Not a Number','Create Warning','Modal');
            hObject.Value = 8;
            hObject.String{10,:} = ' ';
        else
            hObject.Value = 10;
        end
        hObject.UserData.count = 0;
        hObject.UserData.letra = '';
    end
end

% --- Executes on key press with focus on popCRed and none of its controls.
function popCRed_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popCRed (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clc
if ~strcmp(eventdata.Key, 'shift')
    hObject.UserData = struct ('count',hObject.UserData.count + 1,'letra',[hObject.UserData.letra eventdata.Character]);
    hObject.Value = 10;
    hObject.String{10,:} = hObject.UserData.letra;
    if strcmp(eventdata.Key, 'return')
        if isnan(str2double(hObject.String{9,:}))
            warndlg('Input value is Not a Number','Create Warning','Modal');
            hObject.Value = 8;
            hObject.String{10,:} = ' ';
        else
            hObject.Value = 10;
        end
        hObject.UserData.count = 0;
        hObject.UserData.letra = '';
    end
end


% --- Executes on key press with focus on popCBlu and none of its controls.
function popCBlu_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popCBlu (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clc
if ~strcmp(eventdata.Key, 'shift')
    hObject.UserData = struct ('count',hObject.UserData.count + 1,'letra',[hObject.UserData.letra eventdata.Character]);
    hObject.Value = 10;
    hObject.String{10,:} = hObject.UserData.letra;
    if strcmp(eventdata.Key, 'return')
        if isnan(str2double(hObject.String{9,:}))
            warndlg('Input value is Not a Number','Create Warning','Modal');
            hObject.Value = 8;
            hObject.String{10,:} = ' ';
        else
            hObject.Value = 10;
        end
        hObject.UserData.count = 0;
        hObject.UserData.letra = '';
    end
end


% --- Executes on button press in bCblak.
function bCblak_Callback(hObject, eventdata, handles)
% hObject    handle to bCblak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.msg.Visible='Off';
% Hint: get(hObject,'Value') returns toggle state of bCblak
%show and hide controls
handles.pCGeo.Visible = 'Off';
handles.pExAss.Visible = 'Off';

%show Gray RGB Noise panel
handles.pGRGBN.Visible = 'On';
handles.lblSize.String = 'Image Width:                       Image Height:                       Gray Lvl:';
handles.popIWid.Visible = 'On';
handles.popIHei.Visible = 'On';
handles.popGray.Visible = 'On';
handles.lblSize.Visible = 'On';

handles.lblCrgb.String = 'R Band:                       G Band:                       B Band:';
handles.lblCrgb.Visible = 'Off';
handles.popCRed.Visible = 'Off';
handles.popCGre.Visible = 'Off';
handles.popCBlu.Visible = 'Off';
handles.cCrgb.Visible = 'Off';
handles.pRGB.Visible = 'Off';

handles.cNBlac.Value = 0;
handles.cNBlac.Visible = 'Off';
handles.txtNIma.Visible = 'Off';
handles.bSNIma.Visible = 'Off';
handles.popNVar.Visible = 'Off';
handles.popNAlp.Visible = 'Off';
handles.popNTyp.Visible = 'Off';
handles.popNPep.Visible = 'Off';
handles.pWav.Visible = 'Off';

% --- Executes on button press in bCrgb.
function bCrgb_Callback(hObject, eventdata, handles)
% hObject    handle to bCrgb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.msg.Visible='Off';
% Hint: get(hObject,'Value') returns toggle state of bCrgb
%show and hide controls
handles.pCGeo.Visible = 'Off';
handles.pExAss.Visible = 'Off';

%show Gray RGB Noise panel
handles.pGRGBN.Visible = 'On';
handles.popGray.Visible = 'Off';
handles.lblSize.String = 'Image Width:                       Image Height:            ';
handles.popIWid.Visible = 'On';
handles.popIHei.Visible = 'On';
handles.lblSize.Visible = 'On';

handles.lblCrgb.String = 'R Band:                       G Band:                       B Band:';
handles.lblCrgb.Visible = 'On';
handles.popCRed.Visible = 'On';
handles.popCGre.Visible = 'On';
handles.popCBlu.Visible = 'On';
handles.cCrgb.Visible = 'On';
handles.pRGB.Visible = 'Off';

handles.cNBlac.Value = 0;
handles.cNBlac.Visible = 'Off';
handles.txtNIma.Visible = 'Off';
handles.bSNIma.Visible = 'Off';
handles.popNVar.Visible = 'Off';
handles.popNAlp.Visible = 'Off';
handles.popNTyp.Visible = 'Off';
handles.popNPep.Visible = 'Off';
handles.pWav.Visible = 'Off';


function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bCCheck.
function bCCheck_Callback(hObject, eventdata, handles)
% hObject    handle to bCCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.msg.Visible='Off';
% Hint: get(hObject,'Value') returns toggle state of bCCheck
%show and hide controls
handles.lblPos.String = 'Starting Column:                    Starting Row:';
handles.lblPos.Visible = 'On';
handles.popX.Visible = 'On';
handles.popY.Visible = 'On';
handles.lblOSize.String = 'Cell Width:                             Cell Height:';
handles.lblOSize.Visible = 'On';
handles.popOWid.Visible = 'On';
handles.popOHei.Enable = 'On';
handles.popOHei.Visible = 'On';
handles.cCGrgb.Value = 0;
handles.cBlur.Value = 0;
handles.cCGrgb.Visible = 'On';
handles.cBlur.Visible = 'Off';
handles.cOutl.Visible = 'Off';
handles.lblGRGB.Visible = 'Off';
handles.popGR.Visible = 'Off';
handles.popGG.Visible = 'Off';
handles.popGB.Visible = 'Off';
handles.cCGInter.Visible = 'Off';
handles.pGRGB.Visible = 'Off';
handles.popPoly.Visible = 'Off';
handles.cPHole.Visible = 'Off';
handles.popHole.Visible = 'Off';

%show panel create Geo
handles.pCGeo.Visible = 'On';

%hide panel create Gray RGB Noise
handles.pGRGBN.Visible = 'Off';
handles.pExAss.Visible = 'Off';
handles.pWav.Visible = 'Off';


% --- Executes on selection change in popGR.
function popGR_Callback(hObject, eventdata, handles)
% hObject    handle to popGR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popGR contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popGR
if handles.cCGrgb.Value
    R = str2double(handles.popGR.String(handles.popGR.Value));
    G = str2double(handles.popGG.String(handles.popGG.Value));
    B = str2double(handles.popGB.String(handles.popGB.Value));
    handles.pGRGB.BackgroundColor = [R G B]/255;
end

% --- Executes during object creation, after setting all properties.
function popGR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popGR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popGG.
function popGG_Callback(hObject, eventdata, handles)
% hObject    handle to popGG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.msg.Visible='Off';
% Hints: contents = cellstr(get(hObject,'String')) returns popGG contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popGG
if handles.cCGrgb.Value
    R = str2double(handles.popGR.String(handles.popGR.Value));
    G = str2double(handles.popGG.String(handles.popGG.Value));
    B = str2double(handles.popGB.String(handles.popGB.Value));
    handles.pGRGB.BackgroundColor = [R G B]/255;
end

% --- Executes during object creation, after setting all properties.
function popGG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popGG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popGB.
function popGB_Callback(hObject, eventdata, handles)
% hObject    handle to popGB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.msg.Visible='Off';
% Hints: contents = cellstr(get(hObject,'String')) returns popGB contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popGB
if handles.cCGrgb.Value
    R = str2double(handles.popGR.String(handles.popGR.Value));
    G = str2double(handles.popGG.String(handles.popGG.Value));
    B = str2double(handles.popGB.String(handles.popGB.Value));
    handles.pGRGB.BackgroundColor = [R G B]/255;
end

% --- Executes during object creation, after setting all properties.
function popGB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popGB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cCGInter.
function cCGInter_Callback(hObject, eventdata, handles)
% hObject    handle to cCGInter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.msg.Visible='Off';
% Hint: get(hObject,'Value') returns toggle state of cCGInter
if hObject.Value
    handles.pGRGB.Visible = 'On';
    R = str2double(handles.popGR.String(handles.popGR.Value));
    G = str2double(handles.popGG.String(handles.popGG.Value));
    B = str2double(handles.popGB.String(handles.popGB.Value));
    handles.pGRGB.BackgroundColor = [R G B]/255;
    
else
    handles.pGRGB.Visible = 'Off';
end

% --- Executes on selection change in popGWidth.
function popGWidth_Callback(hObject, eventdata, handles)
% hObject    handle to popGWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popGWidth contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popGWidth


% --- Executes during object creation, after setting all properties.
function popGWidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popGWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popGHeight.
function popGHeight_Callback(hObject, eventdata, handles)
% hObject    handle to popGHeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popGHeight contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popGHeight


% --- Executes during object creation, after setting all properties.
function popGHeight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popGHeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cCGrgb.
function cCGrgb_Callback(hObject, eventdata, handles)
% hObject    handle to cCGrgb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.msg.Visible='Off';
% Hint: get(hObject,'Value') returns toggle state of cCGrgb
if hObject.Value
    handles.lblGRGB.Visible = 'On';
    handles.popGR.Visible = 'On';
    handles.popGG.Visible = 'On';
    handles.popGB.Visible = 'On';
    handles.cCGInter.Visible = 'On';
else
   handles.lblGRGB.Visible = 'Off';
    handles.popGR.Visible = 'Off';
    handles.popGG.Visible = 'Off';
    handles.popGB.Visible = 'Off';
    handles.cCGInter.Visible = 'Off'; 
end
handles.pGRGB.Visible = 'Off';
handles.cCGInter.Value = 0;

% --- Executes on selection change in popX.
function popX_Callback(hObject, eventdata, handles)
% hObject    handle to popX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popX contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popX


% --- Executes during object creation, after setting all properties.
function popX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popY.
function popY_Callback(hObject, eventdata, handles)
% hObject    handle to popY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popY contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popY


% --- Executes during object creation, after setting all properties.
function popY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popOWid.
function popOWid_Callback(hObject, eventdata, handles)
% hObject    handle to popOWid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popOWid contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popOWid


% --- Executes during object creation, after setting all properties.
function popOWid_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popOWid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popOHei.
function popOHei_Callback(hObject, eventdata, handles)
% hObject    handle to popOHei (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popOHei contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popOHei


% --- Executes during object creation, after setting all properties.
function popOHei_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popOHei (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popGray.
function popGray_Callback(hObject, eventdata, handles)
% hObject    handle to popGray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popGray contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popGray


% --- Executes during object creation, after setting all properties.
function popGray_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popGray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bCCir.
function bCCir_Callback(hObject, eventdata, handles)
% hObject    handle to bCCir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.msg.Visible='Off';
% Hint: get(hObject,'Value') returns toggle state of bCCir
%show and hide control
handles.lblPos.Visible = 'On';
handles.popX.Visible = 'On';
handles.popX.Value = 8;
handles.popY.Visible = 'On';
handles.popY.Value = 8;
handles.lblOSize.String = 'Radius:';
handles.lblOSize.Visible = 'On';
handles.popOWid.Visible = 'On';
handles.popOHei.Enable = 'Off';
handles.popOHei.Visible = 'On';
handles.cCGrgb.Value = 0;
handles.cBlur.Value = 0;
handles.cBlur.Visible = 'On';
handles.cCGrgb.Visible = 'On';
handles.cOutl.Value = 0;
handles.cOutl.Visible = 'On';
handles.lblGRGB.Visible = 'Off';
handles.popGR.Visible = 'Off';
handles.popGG.Visible = 'Off';
handles.popGB.Visible = 'Off';
handles.cCGInter.Visible = 'Off';
handles.pGRGB.Visible = 'Off';
handles.popPoly.Visible = 'Off';
handles.cPHole.Visible = 'Off';
handles.popHole.Visible = 'Off';

%show panel create Geo
handles.pCGeo.Visible = 'On';

%hide panel create Gray RGB Noise
handles.pGRGBN.Visible = 'Off';
handles.pWav.Visible = 'Off';


% --- Executes on button press in cBlur.
function cBlur_Callback(hObject, eventdata, handles)
% hObject    handle to cBlur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cBlur
if hObject.Value
    handles.popOHei.Enable = 'On';
    handles.cOutl.Enable = 'Off';
else
    handles.popOHei.Enable = 'Off';
    handles.cOutl.Enable = 'On';
end


% --- Executes on button press in cOutl.
function cOutl_Callback(hObject, eventdata, handles)
% hObject    handle to cOutl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cOutl


% --- Executes on button press in bCElli.
function bCElli_Callback(hObject, eventdata, handles)
% hObject    handle to bCElli (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.msg.Visible='Off';
% Hint: get(hObject,'Value') returns toggle state of bCElli
%show and hide control
handles.lblPos.String = 'Center Column:                      Center Row:';
handles.lblPos.Visible = 'On';
handles.popX.Visible = 'On';
handles.popY.Visible = 'On';
handles.lblOSize.String = 'Ellipse Width:                         Ellipse Height:';
handles.lblOSize.Visible = 'On';
handles.popOWid.Visible = 'On';
handles.popOHei.Enable = 'On';
handles.popOHei.Visible = 'On';
handles.cCGrgb.Value = 0;
handles.cBlur.Value = 0;
handles.cBlur.Visible = 'Off';
handles.cCGrgb.Visible = 'On';
handles.cOutl.Value = 0;
handles.cOutl.Visible = 'Off';
handles.lblGRGB.Visible = 'Off';
handles.popGR.Visible = 'Off';
handles.popGG.Visible = 'Off';
handles.popGB.Visible = 'Off';
handles.cCGInter.Visible = 'Off';
handles.pGRGB.Visible = 'Off';
handles.popPoly.Visible = 'Off';
handles.cPHole.Visible = 'Off';
handles.popHole.Visible = 'Off';

%show panel create Geo
handles.pCGeo.Visible = 'On';

%hide panel create Gray RGB Noise
handles.pGRGBN.Visible = 'Off';
handles.pExAss.Visible = 'Off';
handles.pWav.Visible = 'Off';

% --- Executes on button press in bCDia.
function bCDia_Callback(hObject, eventdata, handles)
% hObject    handle to bCDia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.msg.Visible='Off';
% Hint: get(hObject,'Value') returns toggle state of bCDia
%show and hide control
handles.lblPos.String = 'Center Column:                      Center Row:';
handles.lblPos.Visible = 'On';
handles.popX.Visible = 'On';
handles.popY.Visible = 'On';
handles.lblOSize.String = 'Diamond Width:                     Diamond Height:';
handles.lblOSize.Visible = 'On';
handles.popOWid.Visible = 'On';
handles.popOHei.Enable = 'On';
handles.popOHei.Visible = 'On';
handles.cCGrgb.Value = 0;
handles.cBlur.Value = 0;
handles.cBlur.Visible = 'Off';
handles.cCGrgb.Visible = 'On';
handles.cOutl.Value = 0;
handles.cOutl.Visible = 'Off';
handles.lblGRGB.Visible = 'Off';
handles.popGR.Visible = 'Off';
handles.popGG.Visible = 'Off';
handles.popGB.Visible = 'Off';
handles.cCGInter.Visible = 'Off';
handles.pGRGB.Visible = 'Off';
handles.popPoly.Visible = 'Off';
handles.cPHole.Visible = 'Off';
handles.popHole.Visible = 'Off';

%show panel create Geo
handles.pCGeo.Visible = 'On';

%hide panel create Gray RGB Noise
handles.pGRGBN.Visible = 'Off';
handles.pExAss.Visible = 'Off';
handles.pWav.Visible = 'Off';

% --- Executes on button press in bCLin.
function bCLin_Callback(hObject, eventdata, handles)
% hObject    handle to bCLin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.msg.Visible='Off';
% Hint: get(hObject,'Value') returns toggle state of bCLin
%show and hide control
handles.lblPos.String = 'Starting Column:                    Starting Row:';
handles.lblPos.Visible = 'On';
handles.popX.Visible = 'On';
handles.popY.Visible = 'On';
handles.lblOSize.String = 'Ending Column:                      Ending Row:';
handles.lblOSize.Visible = 'On';
handles.popOWid.Visible = 'On';
handles.popOHei.Enable = 'On';
handles.popOHei.Visible = 'On';
handles.cCGrgb.Value = 0;
handles.cBlur.Value = 0;
handles.cBlur.Visible = 'Off';
handles.cCGrgb.Visible = 'On';
handles.cOutl.Value = 0;
handles.cOutl.Visible = 'Off';
handles.lblGRGB.Visible = 'Off';
handles.popGR.Visible = 'Off';
handles.popGG.Visible = 'Off';
handles.popGB.Visible = 'Off';
handles.cCGInter.Visible = 'Off';
handles.pGRGB.Visible = 'Off';
handles.popPoly.Visible = 'Off';
handles.cPHole.Visible = 'Off';
handles.popHole.Visible = 'Off';

%show panel create Geo
handles.pCGeo.Visible = 'On';

%hide panel create Gray RGB Noise
handles.pGRGBN.Visible = 'Off';
handles.pExAss.Visible = 'Off';
handles.pWav.Visible = 'Off';

% --- Executes on button press in bCRec.
function bCRec_Callback(hObject, eventdata, handles)
% hObject    handle to bCRec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.msg.Visible='Off';
% Hint: get(hObject,'Value') returns toggle state of bCRec
%show and hide control
handles.lblPos.String = 'Starting Column:                    Starting Row:';
handles.lblPos.Visible = 'On';
handles.popX.Visible = 'On';
handles.popY.Visible = 'On';
handles.lblOSize.String = 'Rectan. Width:               .       Rectan. Height:';
handles.lblOSize.Visible = 'On';
handles.popOWid.Visible = 'On';
handles.popOHei.Enable = 'On';
handles.popOHei.Visible = 'On';
handles.cCGrgb.Value = 0;
handles.cBlur.Value = 0;
handles.cBlur.Visible = 'Off';
handles.cCGrgb.Visible = 'On';
handles.cOutl.Value = 0;
handles.cOutl.Visible = 'On';
handles.lblGRGB.Visible = 'Off';
handles.popGR.Visible = 'Off';
handles.popGG.Visible = 'Off';
handles.popGB.Visible = 'Off';
handles.cCGInter.Visible = 'Off';
handles.pGRGB.Visible = 'Off';
handles.popPoly.Visible = 'Off';
handles.cPHole.Visible = 'Off';
handles.popHole.Visible = 'Off';

%show panel create Geo
handles.pCGeo.Visible = 'On';

%hide panel create Gray RGB Noise
handles.pGRGBN.Visible = 'Off';
handles.pExAss.Visible = 'Off';
handles.pWav.Visible = 'Off';


% --- Executes on button press in bCCos.
function bCCos_Callback(hObject, eventdata, handles)
% hObject    handle to bCCos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.msg.Visible='Off';
% Hint: get(hObject,'Value') returns toggle state of bCCos
handles.pCGeo.Visible = 'Off';
handles.pExAss.Visible = 'Off';
handles.pGRGBN.Visible = 'Off';
handles.pWav.Visible = 'On';

% --- Executes on button press in bCSin.
function bCSin_Callback(hObject, eventdata, handles)
% hObject    handle to bCSin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.msg.Visible='Off';
% Hint: get(hObject,'Value') returns toggle state of bCSin
handles.pCGeo.Visible = 'Off';
handles.pExAss.Visible = 'Off';
handles.pGRGBN.Visible = 'Off';
handles.pWav.Visible = 'On';

% --- Executes on button press in bCSqu.
function bCSqu_Callback(hObject, eventdata, handles)
% hObject    handle to bCSqu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.msg.Visible='Off';
% Hint: get(hObject,'Value') returns toggle state of bCSqu
handles.pCGeo.Visible = 'Off';
handles.pExAss.Visible = 'Off';
handles.pGRGBN.Visible = 'Off';
handles.pWav.Visible = 'On';

% --- Executes on button press in cNBlac.
function cNBlac_Callback(hObject, eventdata, handles)
% hObject    handle to cNBlac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.msg.Visible='Off';
% Hint: get(hObject,'Value') returns toggle state of cNBlac
if hObject.Value
    handles.popIWid.Visible = 'On';
    handles.popIHei.Visible = 'On';
    handles.lblSize.String = 'Image Width:                       Image Height:  '; 
    handles.lblSize.Visible = 'On';
    handles.txtNIma.Enable = 'Off';
    handles.bSNIma.Enable = 'Off';
else
    handles.popIWid.Visible = 'Off';
    handles.popIHei.Visible = 'Off';
    handles.lblSize.String = 'Image Width:                       Image Height:  '; 
    handles.lblSize.Visible = 'Off';
    handles.txtNIma.Enable = 'On';
    handles.bSNIma.Enable = 'On';
end


function txtNIma_Callback(hObject, eventdata, handles)
% hObject    handle to txtNIma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtNIma as text
%        str2double(get(hObject,'String')) returns contents of txtNIma as a double


% --- Executes during object creation, after setting all properties.
function txtNIma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtNIma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in bAddN.
function bAddN_Callback(hObject, eventdata, handles)
% hObject    handle to bAddN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bAddN
%show and hide controls
handles.pCGeo.Visible = 'Off';
handles.pExAss.Visible = 'Off';
handles.pRGB.Visible = 'Off';

%show Gray RGB Noise panel
handles.pGRGBN.Visible = 'On';
handles.popIWid.Visible = 'Off';
handles.popIHei.Visible = 'Off';
handles.popGray.Visible = 'Off';
handles.lblSize.String = 'Image Width:                       Image Height:  ';
handles.lblSize.Visible = 'Off';

handles.lblCrgb.String = 'Noise Type:                                             Variance:                          Mean:';
handles.lblCrgb.Visible = 'On';
handles.popCRed.Visible = 'Off';
handles.popCGre.Visible = 'Off';
handles.popCBlu.Visible = 'Off';
handles.cCrgb.Visible = 'Off';
handles.msg.Visible='Off';
handles.cNBlac.Value = 0;
handles.cNBlac.Visible = 'On';
handles.txtNIma.String = '';
handles.txtNIma.Enable = 'On';
handles.txtNIma.Visible = 'On';
handles.bSNIma.Visible = 'On';
handles.bSNIma.Enable = 'On';
handles.popNVar.Value = 1;
handles.popNVar.Visible = 'On';
handles.popNAlp.String = [{'-20'}, {'-10'}, {'0'}, {'10'},{'20'}];
handles.popNAlp.Value = 3;
handles.popNAlp.Visible = 'On';
handles.popNTyp.Value = 2;
handles.popNTyp.Visible = 'On';
handles.pWav.Visible = 'Off';


% --- Executes on selection change in popNVar.
function popNVar_Callback(hObject, eventdata, handles)
% hObject    handle to popNVar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popNVar contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popNVar


% --- Executes during object creation, after setting all properties.
function popNVar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popNVar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popNAlp.
function popNAlp_Callback(hObject, eventdata, handles)
% hObject    handle to popNAlp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popNAlp contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popNAlp


% --- Executes during object creation, after setting all properties.
function popNAlp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popNAlp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popNTyp.
function popNTyp_Callback(hObject, eventdata, handles)
% hObject    handle to popNTyp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popNTyp contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popNTyp
if (hObject.Value == 2) || (hObject.Value == 6)     %gaussian or uniform Noise
    handles.lblCrgb.String = 'Noise Type:                                             Variance:                         Mean:';
    handles.popNVar.Visible = 'On';
    handles.popNAlp.String = [{'-20'}, {'-10'}, {'0'}, {'10'},{'20'}];
    handles.popNAlp.Value = 3;
    handles.popNAlp.Visible = 'On';
    handles.popNPep.Visible = 'Off';
    handles.lblCrgb.Visible = 'On';

elseif (hObject.Value == 3) || (hObject.Value == 4) %neg exponential or  Rayleigh Noise
    handles.lblCrgb.String = 'Noise Type:                                             Variance:       ';
    handles.popNVar.Visible = 'On';
    handles.popNAlp.Visible = 'Off';
    handles.popNPep.Visible = 'Off';
    handles.lblCrgb.Visible = 'On';
    
elseif (hObject.Value == 1)                         %gamma Noise
    handles.lblCrgb.String = 'Noise Type:                                             Variance:                         Alpha:';
    handles.popNVar.Visible = 'On';
    handles.popNAlp.String = [{'1'}, {'2'}, {'3'}, {'4'},{'5'}];
    handles.popNAlp.Value = 1;
    handles.popNAlp.Visible = 'On';
    handles.popNPep.Visible = 'Off';
    handles.lblCrgb.Visible = 'On';
    
else                                                %salt and pepper Noise
    handles.lblCrgb.String = 'Noise Type:                                         Prob. Pepper:                     of Salt:';
    handles.popNVar.Visible = 'Off';
    handles.popNAlp.String = [{'0.02'}, {'0.03'}, {'0.05'}, {'0.08'},{'0.10'},{'0.15'},{'0.20'}];
    handles.popNAlp.Value = 2;
    handles.popNAlp.Visible = 'On';
    handles.popNPep.Visible = 'On';
    handles.lblCrgb.Visible = 'On';
    
end
handles.msg.Visible='Off';

% --- Executes during object creation, after setting all properties.
function popNTyp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popNTyp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popNPep.
function popNPep_Callback(hObject, eventdata, handles)
% hObject    handle to popNPep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popNPep contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popNPep


% --- Executes during object creation, after setting all properties.
function popNPep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popNPep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popWWid.
function popWWid_Callback(hObject, eventdata, handles)
% hObject    handle to popWWid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popWWid contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popWWid


% --- Executes during object creation, after setting all properties.
function popWWid_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popWWid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popWHei.
function popWHei_Callback(hObject, eventdata, handles)
% hObject    handle to popWHei (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popWHei contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popWHei


% --- Executes during object creation, after setting all properties.
function popWHei_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popWHei (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popWFreq.
function popWFreq_Callback(hObject, eventdata, handles)
% hObject    handle to popWFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popWFreq contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popWFreq


% --- Executes during object creation, after setting all properties.
function popWFreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popWFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popWDir.
function popWDir_Callback(hObject, eventdata, handles)
% hObject    handle to popWDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popWDir contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popWDir


% --- Executes during object creation, after setting all properties.
function popWDir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popWDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cEAllB.
function cEAllB_Callback(hObject, eventdata, handles)
% hObject    handle to cEAllB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cEAllB
if hObject.Value            %set all bands selectors
    handles.cExtR.Value = 1;
    handles.cExtG.Value = 1;
    handles.cExtB.Value = 1;
else                        %restore default bands selection
    handles.cExtR.Value = 1;
    handles.cExtG.Value = 0;
    handles.cExtB.Value = 0;
end

% --- Executes on button press in cExtR.
function cExtR_Callback(hObject, eventdata, handles)
% hObject    handle to cExtR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cExtR


% --- Executes on button press in cExtG.
function cExtG_Callback(hObject, eventdata, handles)
% hObject    handle to cExtG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cExtG


% --- Executes on button press in cExtB.
function cExtB_Callback(hObject, eventdata, handles)
% hObject    handle to cExtB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cExtB


% --- Executes on button press in bExtrac.
function bExtrac_Callback(hObject, eventdata, handles)
% hObject    handle to bExtrac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bExtrac
%show and hide controls
handles.pCGeo.Visible = 'Off';
handles.pExAss.Visible = 'On';
handles.pGRGBN.Visible = 'Off';
handles.msg.Visible='Off';
handles.cEAllB.Value = 0;
handles.cExtR.Value = 1;
handles.cExtG.Value = 0;
handles.cExtB.Value = 0;
handles.cEAllB.Visible = 'On';
handles.cExtR.Visible = 'On';
handles.cExtG.Visible = 'On';
handles.cExtB.Visible = 'On';

handles.txtRIma.Visible = 'Off';
handles.txtGIma.Visible = 'Off';
handles.txtBIma.Visible = 'Off';
handles.bRIma.Visible = 'Off';
handles.bGIma.Visible = 'Off';
handles.bBIma.Visible = 'Off';
handles.pWav.Visible = 'Off';


% --- Executes on button press in bAssB.
function bAssB_Callback(hObject, eventdata, handles)
% hObject    handle to bAssB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bAssB
%show and hide controls
handles.pCGeo.Visible = 'Off';
handles.pExAss.Visible = 'On';
handles.pGRGBN.Visible = 'Off';
handles.msg.Visible='Off';
handles.cEAllB.Visible = 'Off';
handles.cExtR.Visible = 'Off';
handles.cExtG.Visible = 'Off';
handles.cExtB.Visible = 'Off';

handles.txtRIma.String = 'Select Red Band Image...';
handles.txtGIma.String = 'Select Green Band Image...';
handles.txtBIma.String = 'Select Blue Band Image...';
handles.txtRIma.Visible = 'On';
handles.txtGIma.Visible = 'On';
handles.txtBIma.Visible = 'On';
handles.bRIma.Visible = 'On';
handles.bGIma.Visible = 'On';
handles.bBIma.Visible = 'On';
handles.pWav.Visible = 'Off';


function txtRIma_Callback(hObject, eventdata, handles)
% hObject    handle to txtRIma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtRIma as text
%        str2double(get(hObject,'String')) returns contents of txtRIma as a double


% --- Executes during object creation, after setting all properties.
function txtRIma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtRIma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bRIma.
function bRIma_Callback(hObject, eventdata, handles)
% hObject    handle to bRIma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%capture ideal image information and save it

%capturing red band image
clc                             %clear screen
hMain = findobj('Tag','Main');  %get the handle of Main form
hNfig = hMain.UserData;         %get image handle
if hNfig ~= 0 && isfield(hNfig.UserData,'cvipIma')%check for Image to save
    file=get(hNfig,'Name');    	%get image name
    hObject.UserData = hNfig.UserData;%read image info
    handles.txtRIma.String = file;  %show image name
end

function txtGIma_Callback(hObject, eventdata, handles)
% hObject    handle to txtGIma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtGIma as text
%        str2double(get(hObject,'String')) returns contents of txtGIma as a double


% --- Executes during object creation, after setting all properties.
function txtGIma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtGIma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bGIma.
function bGIma_Callback(hObject, eventdata, handles)
% hObject    handle to bGIma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%capturing Green band image
clc                             %clear screen
hMain = findobj('Tag','Main');  %get the handle of Main form
hNfig = hMain.UserData;         %get image handle
if hNfig ~= 0 && isfield(hNfig.UserData,'cvipIma')%check for Image to save
    file=get(hNfig,'Name');    	%get image name
    hObject.UserData = hNfig.UserData;%read image info
    handles.txtGIma.String = file;  %show image name
end


function txtBIma_Callback(hObject, eventdata, handles)
% hObject    handle to txtBIma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtBIma as text
%        str2double(get(hObject,'String')) returns contents of txtBIma as a double


% --- Executes during object creation, after setting all properties.
function txtBIma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtBIma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function bor_mask_Callback(hObject, eventdata, handles)
% hObject    handle to bor_mask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.pCGeo.Visible = 'Off';
handles.pExAss.Visible = 'Off';
handles.msg.Visible='On';
%show Gray RGB Noise panel
handles.pGRGBN.Visible = 'Off';
handles.popGray.Visible = 'Off';
handles.lblSize.String = 'Off ';
handles.popIWid.Visible = 'Off';
handles.popIHei.Visible = 'Off';
handles.lblSize.Visible = 'Off';


handles.lblCrgb.Visible = 'Off';
handles.popCRed.Visible = 'Off';
handles.popCGre.Visible = 'Off';
handles.popCBlu.Visible = 'Off';
handles.cCrgb.Visible = 'Off';
handles.pRGB.Visible = 'Off';

handles.cNBlac.Value = 0;
handles.cNBlac.Visible = 'Off';
handles.txtNIma.Visible = 'Off';
handles.bSNIma.Visible = 'Off';
handles.popNVar.Visible = 'Off';
handles.popNAlp.Visible = 'Off';
handles.popNTyp.Visible = 'Off';
handles.popNPep.Visible = 'Off';
handles.pWav.Visible = 'Off';
function border_image_Callback(hObject, eventdata, handles)
% hObject    handle to border_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.pCGeo.Visible = 'Off';
handles.pExAss.Visible = 'Off';
handles.msg.Visible='On';
%show Gray RGB Noise panel
handles.pGRGBN.Visible = 'On';
handles.popGray.Visible = 'Off';
handles.lblSize.String = 'Off ';
handles.popIWid.Visible = 'Off';
handles.popIHei.Visible = 'Off';
handles.lblSize.Visible = 'Off';


handles.lblCrgb.Visible = 'On';
handles.popCRed.Visible = 'On';
handles.popCGre.Visible = 'On';
handles.popCBlu.Visible = 'On';
handles.cCrgb.Visible = 'On';
handles.pRGB.Visible = 'On';
handles.lblCrgb.String = 'R Band:                            G Band:                                 B Band:';
handles.cNBlac.Value = 0;
handles.cNBlac.Visible = 'Off';
handles.txtNIma.Visible = 'Off';
handles.bSNIma.Visible = 'Off';
handles.popNVar.Visible = 'Off';
handles.popNAlp.Visible = 'Off';
handles.popNTyp.Visible = 'Off';
handles.popNPep.Visible = 'Off';
handles.pWav.Visible = 'Off';
% --- Executes on button press in bBIma.
function bBIma_Callback(hObject, eventdata, handles)
% hObject    handle to bBIma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%capturing Green band image
clc                             %clear screen
hMain = findobj('Tag','Main');  %get the handle of Main form
hNfig = hMain.UserData;         %get image handle
if hNfig ~= 0 && isfield(hNfig.UserData,'cvipIma')%check for Image to save
    file=get(hNfig,'Name');    	%get image name
    hObject.UserData = hNfig.UserData;%read image info
    handles.txtBIma.String = file;  %show image name
end

% --- Executes when Crea is resized.
function Crea_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to Crea (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(hObject.UserData, 'Check')
    handles.bCCheck.Value = 1;
elseif strcmp(hObject.UserData, 'Circ')
    bCCir_Callback(handles.bCCir, eventdata, handles);
    handles.bCCir.Value = 1;
elseif strcmp(hObject.UserData, 'Elli')
    bCElli_Callback(handles.bCElli, eventdata, handles);
    handles.bCElli.Value = 1;
elseif strcmp(hObject.UserData, 'Diam')
    bCDia_Callback(handles.bCDia, eventdata, handles);
    handles.bCDia.Value = 1;
elseif strcmp(hObject.UserData, 'Line')
    bCLin_Callback(handles.bCLin, eventdata, handles);
    handles.bCLin.Value = 1;
elseif strcmp(hObject.UserData, 'Rect')
    bCRec_Callback(handles.bCRec, eventdata, handles);
    handles.bCRec.Value = 1;
elseif strcmp(hObject.UserData, 'Poly')
    bPoly_Callback(handles.bPoly, eventdata, handles);
    handles.bPoly.Value = 1;
elseif strcmp(hObject.UserData, 'Cos')
    bCCos_Callback(handles.bCCos, eventdata, handles);
    handles.bCCos.Value = 1;
elseif strcmp(hObject.UserData, 'Sin')
    bCSin_Callback(handles.bCSin, eventdata, handles);
    handles.bCSin.Value = 1;
elseif strcmp(hObject.UserData, 'Squa')
    bCSqu_Callback(handles.bCSqu, eventdata, handles);
    handles.bCSqu.Value = 1;
elseif strcmp(hObject.UserData, 'Extra')
    bExtrac_Callback(handles.bExtrac, eventdata, handles);
    handles.bExtrac.Value = 1;
elseif strcmp(hObject.UserData, 'Asse')
    bAssB_Callback(handles.bAssB, eventdata, handles);
    handles.bAssB.Value = 1;
elseif strcmp(hObject.UserData, 'Gray')
    bCblak_Callback(handles.bCblak, eventdata, handles);
    handles.bCblak.Value = 1;
elseif strcmp(hObject.UserData, 'RGB')
    bCrgb_Callback(handles.bCrgb, eventdata, handles);
    handles.bCrgb.Value = 1;
elseif strcmp(hObject.UserData, 'Noise')
    bAddN_Callback(handles.bAddN, eventdata, handles);
    handles.bAddN.Value = 1;
end
hObject.UserData = 'NO';


% --- Executes on key press with focus on popGR and none of its controls.
function popGR_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popGR (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

pop_add_cvip(hObject, eventdata);   %call function to add user data

% --- Executes on key press with focus on popGG and none of its controls.
function popGG_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popGG (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

pop_add_cvip(hObject, eventdata);   %call function to add user data

% --- Executes on key press with focus on popGB and none of its controls.
function popGB_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popGB (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

pop_add_cvip(hObject, eventdata);   %call function to add user data

% --- Executes on key press with focus on popGWidth and none of its controls.
function popGWidth_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popGWidth (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

pop_add_cvip(hObject, eventdata);   %call function to add user data

% --- Executes on key press with focus on popGHeight and none of its controls.
function popGHeight_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popGHeight (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

pop_add_cvip(hObject, eventdata);   %call function to add user data

% --- Executes on key press with focus on popX and none of its controls.
function popX_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popX (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

pop_add_cvip(hObject, eventdata);   %call function to add user data

% --- Executes on key press with focus on popY and none of its controls.
function popY_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popY (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

pop_add_cvip(hObject, eventdata);   %call function to add user data

% --- Executes on key press with focus on popOWid and none of its controls.
function popOWid_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popOWid (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

pop_add_cvip(hObject, eventdata);   %call function to add user data

% --- Executes on key press with focus on popOHei and none of its controls.
function popOHei_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popOHei (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

pop_add_cvip(hObject, eventdata);   %call function to add user data

% --- Executes on key press with focus on popGray and none of its controls.
function popGray_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popGray (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

pop_add_cvip(hObject, eventdata);   %call function to add user data

% --- Executes on key press with focus on popNVar and none of its controls.
function popNVar_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popNVar (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

pop_add_cvip(hObject, eventdata);   %call function to add user data

% --- Executes on key press with focus on popNAlp and none of its controls.
function popNAlp_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popNAlp (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

pop_add_cvip(hObject, eventdata);   %call function to add user data

% --- Executes on key press with focus on popNPep and none of its controls.
function popNPep_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popNPep (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

pop_add_cvip(hObject, eventdata);   %call function to add user data

% --- Executes on key press with focus on popWWid and none of its controls.
function popWWid_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popWWid (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

pop_add_cvip(hObject, eventdata);   %call function to add user data

% --- Executes on key press with focus on popWHei and none of its controls.
function popWHei_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popWHei (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

pop_add_cvip(hObject, eventdata);   %call function to add user data

% --- Executes on key press with focus on popWFreq and none of its controls.
function popWFreq_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popWFreq (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

pop_add_cvip(hObject, eventdata);   %call function to add user data

% --- Executes on key press with focus on popWDir and none of its controls.
function popWDir_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popWDir (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

pop_add_cvip(hObject, eventdata);   %call function to add user data


% --- Executes on selection change in popWred.
function popWred_Callback(hObject, eventdata, handles)
% hObject    handle to popWred (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popWred contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popWred
if handles.cWrgb.Value
    R = str2double(handles.popWred.String(handles.popWred.Value));
    G = str2double(handles.popWgre.String(handles.popWgre.Value));
    B = str2double(handles.popWblu.String(handles.popWblu.Value));
    handles.pWrgb.BackgroundColor = [R G B]/255;
end
handles.msg.Visible='Off';

% --- Executes during object creation, after setting all properties.
function popWred_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popWred (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popWgre.
function popWgre_Callback(hObject, eventdata, handles)
% hObject    handle to popWgre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popWgre contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popWgre
if handles.cWrgb.Value
    R = str2double(handles.popWred.String(handles.popWred.Value));
    G = str2double(handles.popWgre.String(handles.popWgre.Value));
    B = str2double(handles.popWblu.String(handles.popWblu.Value));
    handles.pWrgb.BackgroundColor = [R G B]/255;
end
handles.msg.Visible='Off';

% --- Executes during object creation, after setting all properties.
function popWgre_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popWgre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popWblu.
function popWblu_Callback(hObject, eventdata, handles)
% hObject    handle to popWblu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popWblu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popWblu
if handles.cWrgb.Value
    R = str2double(handles.popWred.String(handles.popWred.Value));
    G = str2double(handles.popWgre.String(handles.popWgre.Value));
    B = str2double(handles.popWblu.String(handles.popWblu.Value));
    handles.pWrgb.BackgroundColor = [R G B]/255;
end

% --- Executes during object creation, after setting all properties.
function popWblu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popWblu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cWIrgb.
function cWIrgb_Callback(hObject, eventdata, handles)
% hObject    handle to cWIrgb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cWIrgb
if hObject.Value
    handles.pWrgb.Visible = 'On';
    R = str2double(handles.popWred.String(handles.popWred.Value));
    G = str2double(handles.popWgre.String(handles.popWgre.Value));
    B = str2double(handles.popWblu.String(handles.popWblu.Value));
    handles.pWrgb.BackgroundColor = [R G B]/255;
else
    handles.pWrgb.Visible = 'Off';
    handles.msg.Visible='Off';
end

% --- Executes on button press in cWrgb.
function cWrgb_Callback(hObject, eventdata, handles)
% hObject    handle to cWrgb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cWrgb
if hObject.Value
    handles.text26.Visible = 'On';
    handles.popWred.Visible = 'On';
    handles.popWgre.Visible = 'On';
    handles.popWblu.Visible = 'On';
    handles.cWIrgb.Visible = 'On';
else
   handles.text26.Visible = 'Off';
    handles.popWred.Visible = 'Off';
    handles.popWgre.Visible = 'Off';
    handles.popWblu.Visible = 'Off';
    handles.cWIrgb.Visible = 'Off'; 
end
handles.pWrgb.Visible = 'Off';
handles.msg.Visible='Off';
handles.cWIrgb.Value = 0;


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


% --- Executes on key press with focus on popWred and none of its controls.
function popWred_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popWred (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

pop_add_cvip(hObject, eventdata);   %call function to add user data


% --- Executes on key press with focus on popWgre and none of its controls.
function popWgre_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popWgre (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

pop_add_cvip(hObject, eventdata);   %call function to add user data


% --- Executes on key press with focus on popWblu and none of its controls.
function popWblu_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popWblu (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

pop_add_cvip(hObject, eventdata);   %call function to add user data


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

% --------------------------------------------------------------------
function fOpen_Callback(hObject, eventdata, handles)
% hObject    handle to fOpen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hMain = findobj('Tag','Main');              %get the handle of Main form
% get handles and other user-defined data associated to Gui1
g1data = guidata(hMain);
if ~isempty(hMain)
    CVIPToolbox('fOpen_Callback',g1data.fOpen,eventdata,guidata(g1data.fOpen))
end

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


% --- Executes on button press in bPoly.
function bPoly_Callback(hObject, eventdata, handles)
% hObject    handle to bPoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bPoly
handles.msg.Visible='Off';
handles.lblPos.String = 'Starting Column:                    Starting Row:';
handles.lblPos.Visible = 'On';
handles.popX.Visible = 'On';
handles.popY.Visible = 'On';
handles.lblOSize.String = 'Radius:               .                   # of Vertices:';
handles.lblOSize.Visible = 'On';
handles.popOWid.Visible = 'On';
handles.popOHei.Enable = 'Off';
handles.popOHei.Visible = 'Off';
handles.cCGrgb.Value = 0;
handles.cBlur.Value = 0;
handles.cBlur.Visible = 'Off';
handles.cCGrgb.Visible = 'On';
handles.cOutl.Value = 0;
handles.cOutl.Visible = 'On';
handles.lblGRGB.Visible = 'Off';
handles.popGR.Visible = 'Off';
handles.popGG.Visible = 'Off';
handles.popGB.Visible = 'Off';
handles.cCGInter.Visible = 'Off';
handles.pGRGB.Visible = 'Off';
handles.popPoly.Visible = 'On';
handles.cPHole.Visible = 'On';
handles.popHole.Visible = 'Off';
handles.lblGRGB.Visible = 'On';
handles.popGR.Visible = 'On';
handles.popGG.Visible = 'On';
handles.popGB.Visible = 'On';
handles.cCGInter.Visible = 'On';
handles.cCGrgb.Value = 1;


% --- Executes on button press in cPHole.
function cPHole_Callback(hObject, eventdata, handles)
% hObject    handle to cPHole (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.popHole.Visible = 'On';


% Hint: get(hObject,'Value') returns toggle state of cPHole


% --- Executes on selection change in popPoly.
function popPoly_Callback(hObject, eventdata, handles)
% hObject    handle to popPoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popPoly contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popPoly


% --- Executes during object creation, after setting all properties.
function popPoly_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popPoly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popHole.
function popHole_Callback(hObject, eventdata, handles)
% hObject    handle to popHole (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popHole contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popHole


% --- Executes during object creation, after setting all properties.
function popHole_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popHole (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on popHole and none of its controls.
function popHole_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popHole (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
pop_add_cvip(hObject, eventdata);   %call function to add user data
