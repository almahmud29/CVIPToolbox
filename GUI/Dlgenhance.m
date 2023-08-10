function varargout = Dlgenhance(varargin)
% DLGENHANCE MATLAB code for Dlgenhance.fig
%      DLGENHANCE, by itself, creates a new DLGENHANCE or raises the existing
%      singleton*.
%
%      H = DLGENHANCE returns the handle to a new DLGENHANCE or the handle to
%      the existing singleton*.
%
%      DLGENHANCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DLGENHANCE.M with the given input arguments.
%
%      DLGENHANCE('Property','Value',...) creates a new DLGENHANCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Dlgenhance_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Dlgenhance_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Dlgenhance

% Last Modified by GUIDE v2.5 12-Apr-2023 11:53:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Dlgenhance_OpeningFcn, ...
                   'gui_OutputFcn',  @Dlgenhance_OutputFcn, ...
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
%           Author:                 Naveena Gorre (GUIDE)
%           Initial coding date:    06/01/2019
%           Updated by:             Hridoy Biswas
%           Latest update date:     10/28/2020
%           Credit:                 Scott Umbaugh 
%                                   CVIP Lab, SIUE
%           Copyright (C) 2018 Scott Umbaugh and SIUE
%
%==========================================================================

% Revision History
%Revision 1.5 10/28/20 Hridoy
 %Added Clahe and its related functions 
  
%
 % Revision 1.4  05/24/2019  14:48:15  jucuell
 % including the icons to extract the histogram, R, G and B band from the
 % selected image.
%
 % Revision 1.3  02/27/2018  10:38:30  jucuell
 % Include operations and calculations to create the Classification results
 % file and show the results into the classification viewer. The output
 % file will include the success rates for each class at the begining of
 % the file by using the variable Names.
%
 % Revision 1.2  12/17/2018  10:29:53  jucuell
 % updating menu creation programmatically, callbacks to Main figure and
 % the use of the utilities menus in the Main figure.
%
 % Revision 1.1  11/21/2017  15:23:31  jucuell
 % Initial coding and testing.
 % 
%

% --- Executes just before DlgPatt is made visible.


% --- Executes just before Dlgenhance is made visible.
function Dlgenhance_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Dlgenhance (see VARARGIN)

% Choose default command line output for Dlgenhance

handles.output = hObject;

% % Slider Edit Start
% Shrink the GUI
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pos =  get(handles.HistConN,'position');
% pos(4) = 33;
set(handles.HistConN,'position',pos)
pos =  get(handles.slider1,'position');
% pos(4) = 31;
set(handles.slider1,'position',pos)

% Create the list of the objects to move
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
handles.hListe =  [handles.bhisteq;...
    handles.bhslide; ...
    handles.bStre;...
    handles.bhshrink; ...
    handles.bLE; ...
    handles.clahe; ...
    handles.bACE; ...
    handles.bACE2; ...
    handles.blogACE; ...
    handles.bexpACE; ...
    handles.bCCA; ...
    handles.bHS; ...
    handles.bLM; ...
    handles.bGLM; ...
    handles.edit8; ...
    handles.edit9; ...
    handles.text49; ...
    handles.text55; ...
    handles.byte; ...
    handles.no_overlap; ...
    handles.pshrink; ...
%     handles.tFR; ...
%     handles.tFG; ...
%     handles.tFB; ...
%     handles.popRed; ...
%     handles.popGreen; ...
%     handles.popBlue; ...
    handles.pslide; ...
    handles.pHQ; ...
    handles.pHistspec; ...
    handles.pLM; ...
    handles.pGLM; ...
%     handles.popMaxGain; ...
    handles.pACE; ...
%     handles.low_t; ...
%     handles.text53; ...
%     handles.popHclip; ...
    handles.pStre; ...
%     handles.high_t; ...
    handles.text_limit; ...
    handles.clip_limit; ...
    handles.edit10];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Save the original positions of save Objects to move
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
handles.pos = get(handles.hListe,'position');
% % Slider Edit End

handles.byte.Visible='off'  ; 
handles.pslide.Visible='off';
handles.pStre.Visible='off';
% Update handles structure
guidata(hObject, handles);
handles.text55.Visible='off';
handles.no_overlap.Visible='off';
handles.text_limit.Visible='off';
handles.clip_limit.Visible='off';
handles.phequal.Visible='on';
handles.pHQ.Visible='on';
set(handles.edit8,'String',1);
menu_add_cvip(hObject);




function mVsaveHis_Callback(hObject, eventdata, handles)
% hObject    handle to mVsaveHis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('Hola Magola, This is working!!!  :)');
hObject.Checked = 'On';



% --- Outputs from this function are returned to the command line.
function varargout = Dlgenhance_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUTs
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    
% Get default command line output from handles structure
varargout{1} = handles.output;


% CODE CALLBACKS ORDER:
% - Buttons (bApply, bCancel, bReset, ...)
% - Radio Buttons (Options, choices)
% - Pop-up Menús
% - Figure Callbacks (Resize, Click, ...)
% - Main Menus (fOpen, fSave)
% - Ui Main Menus (uiOpen, uiSave)
% - Menus (Others: View, Analysis, Compression...)


% --- Executes on button press in bApply.
function bApply_Callback(hObject, eventdata, handles)
% hObject    handle to bApply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc                                 %clear screen

%changing pointer arrow to watch on cursor
figure_set = findall(groot,'Type','Figure');
set(figure_set,'pointer','watch');

hMain = findobj('Tag','Main');      %get the handle of Main figure
hSHisto = findobj('Tag','mVsaveHis');%get handle of Save history menu
hVfinfo = findobj('Tag','mVfi');    %get handle of menu view fun information
hNfig = hMain.UserData;             %get image handle
%check for Image to process

if hNfig ~= 0 && isfield(hNfig.UserData,'cvipIma') 
    Ima=hNfig.UserData;             %get image information
    InIma = Ima.cvipIma;            %read image data
    file=get(hNfig,'Name');         %get image name
    band = size(InIma,3);           %get number of bands
%     if band==1
%         handles.bred.Enable='off';
%          handles.bGreen.Enable='off';
%           handles.Bblue.Enable='off';
%     end
%         
%perform image operations
if handles.bStre.Value              %perform Hist Stretch
    %capture parameters from GUI
    lowlimit = str2double(handles.popLow.String(handles.popLow.Value));
    highlimit = str2double(handles.popHigh.String(handles.popHigh.Value));
    lowClip = str2double(handles.popLclip.String(handles.popLclip.Value));
    highClip = str2double(handles.popHclip.String(handles.popHclip.Value));
    %call histogram stretch function
    OutIma = hist_stretch_cvip(InIma,lowlimit,highlimit,lowClip,highClip);
    %create image name including input parameters
    Name = [file,' > H-Stretch (' num2str(lowlimit) ',' num2str(highlimit) ',' ...
        num2str(lowClip) ',' num2str(highClip) ')'];
    %update image history
    histo = [079 lowlimit highlimit lowClip highClip];     %update image history
elseif handles.bhisteq.Value                 %perform Hist equlization           
    if band==1
      OutIma = histeq_cvip(InIma); 
      Name = [file,' > H-equalization '];
    %update image history
    histo = [073 0];     %update image history
    else
        qband = handles.phequal.SelectedObject.UserData;     %get selected method
    if  qband == 3
         OutIma = rgb2hsl_cvip(InIma,1); %convert to hsl OutIma(1:10)
            Light = OutIma(:,:,3);          %extract lightness
            Light = histeq_cvip(floor(Light*255),0);%call function
            OutIma(:,:,3) = double(Light)/255;%assemble new light band
            OutIma = uint8(hsl2rgb_cvip(OutIma,1)*255);%call function
            Name = [file,' > H-equalization (' num2str(qband) ','];
            %update image history
            histo = [073 3];     %update image history
     elseif qband== 0
         %calls histeq function
            OutIma = double(histeq_cvip(InIma,qband)); 
            Name = [file,' > H-equalization (' num2str(qband) ','];
            %update image history
            histo = [073 0];     %update image history
     elseif qband == 1
          %calls histeq function
            OutIma = double(histeq_cvip(InIma,qband)); 
            Name = [file,' > H-equalization(' num2str(qband) ','];
            %update image history
            histo = [073 1];     %update image history
     elseif qband == 2
          %calls histeq function
            OutIma = double(histeq_cvip(InIma,qband)); 
            Name = [file,' > H-equalization (' num2str(qband) ','];
            %update image history
            histo = [073 2];     %update image history
     end
    end
elseif handles.bhslide.Value              %perform Hist Slide
    %capture parameters from GUI
    offset = str2double(handles.popamount.String(handles.popamount.Value));
    if handles.bdown.Value
        offset=-offset;
    end
    %calls histogram slide function
    OutIma = hist_slide_cvip(InIma,offset);
    %create image name including input parameters
    Name = [file,' > H-Slide (' num2str(offset) ',)'];
    %update image history
    histo = [077 offset];     %update image history
elseif handles.bhshrink.Value              %perform Hist Shrink
    %capture parameters from GUI
    lowlimit = str2double(handles.popLlimit.String(handles.popLlimit.Value));
    highlimit = str2double(handles.pophlimit.String(handles.pophlimit.Value));
    %calls histogram shrink function
    OutIma = hist_shrink_cvip(InIma,lowlimit,highlimit);
    %create image name including input parameters
    Name = [file,' > H-Shrink(' num2str(lowlimit) ',' num2str(highlimit) ', )'];
    %update image history
    histo = [076 lowlimit highlimit ];     %update image history
elseif handles.bLE.Value                 %perform Hist equlization           
    if band==1
      OutIma = local_histeq_cvip(InIma); 
      Name = [file,' > Local H-equalization '];
    %update image history
    histo = [078 0];     %update image history
    else
        band = handles.phequal.SelectedObject.UserData;     %get selected method
        blocksize = str2double(handles.popblock.String(handles.popblock.Value));
    if  band == 3
         OutIma = rgb2hsl_cvip(InIma,1); %convert to hsl OutIma(1:10)
            Light = OutIma(:,:,3);          %extract lightness
            Light = local_histeq_cvip(floor(Light*255),blocksize,1);%call function
            OutIma(:,:,3) = double(Light)/255;%assemble new light band
            OutIma = uint8(hsl2rgb_cvip(OutIma,1)*255);%call function
            Name = [file,' >Local H-equalization (' num2str(band) ',' num2str(blocksize) ',)'];
            %update image history
            histo = [078 3];     %update image history
     elseif band== 0
         %calls histeq function
            OutIma = local_histeq_cvip(InIma,blocksize,1); 
            Name = [file,' > Local H-equalization (' num2str(band) ',' num2str(blocksize) ',)'];
            %update image history
            histo = [078 0];     %update image history
     elseif band == 1
          %calls histeq function
            OutIma = local_histeq_cvip(InIma,blocksize,2); 
            Name = [file,' > Local H-equalization(' num2str(band) ',' num2str(blocksize) ',)'];
            %update image history
            histo = [078 1];     %update image history
     elseif band == 2
          %calls histeq function
            OutIma = local_histeq_cvip(InIma,blocksize,3); 
            Name = [file,' > Local H-equalization (' num2str(band) ',' num2str(blocksize) ',)'];
            %update image history
            histo = [078 2];     %update image history
     end
    end
elseif handles.clahe.Value
           %update image history
        [~,~,b]=size(InIma);
        
        if handles.byte.Value
            byte='y';
        else
            byte='n';
        end
        band = handles.phequal.SelectedObject.UserData;    
        if b==1
            band=0;
        end%get selected method
        blocksize = str2double(handles.popblock.String(handles.popblock.Value));
        
        clip_limit = str2double(handles.clip_limit.String(handles.clip_limit.Value));
        
    
            
            
    if  band == 3
        if b==1
%             msgbox('Please choose an RGB image for Lightness band')
         errordlg(['Selected image is not gray scale image! Select a gray scale' ...
        ' image and try again.'], 'Clahe Error', 'modal');
         histo=O;
         OutIma=0;
        else
         OutIma = rgb2hsl_cvip(InIma,1); %convert to hsl OutIma(1:10)
            Light = OutIma(:,:,3);
            if handles.no_overlap.Value==0
                Light = clahe_cvip_block(floor(Light*255),blocksize,1,clip_limit,byte);
            else%extract lightness
            Light = clahe_cvip(floor(Light*255),blocksize,1,clip_limit,byte);
            end%call function
            OutIma(:,:,3) = double(Light)/255;%assemble new light band
            OutIma =uint8(hsl2rgb_cvip(OutIma,1)*255);%call function uint8
            Name = [file,' >CLAHE (' num2str(band) ',' num2str(blocksize) ',)'];
            %update image history
            histo = [079 3]; 
        end%update image history
     elseif band== 0
         %calls histeq function
         if handles.no_overlap.Value==0
               OutIma = clahe_cvip_block(InIma,blocksize,1,clip_limit,byte); 
         else
            OutIma = clahe_cvip(InIma,blocksize,1,clip_limit,byte); 
         end
            Name = [file,' > CLAHE (' num2str(band) ',' num2str(blocksize) ',' num2str(band) ',)'];
            %update image history
            histo = [079 0];     %update image history
     elseif band == 1
          %calls histeq function
          if handles.no_overlap.Value==0
               OutIma = clahe_cvip_block(InIma,blocksize,1,clip_limit,byte); 
          else
            OutIma = clahe_cvip(InIma,blocksize,2,clip_limit,byte); 
          end
            Name = [file,' > Local H-equalization(' num2str(band) ',' num2str(blocksize) ',' num2str(band) ',)'];
            %update image history
            histo = [079 1];     %update image history
     elseif band == 2
          %calls histeq function
          if handles.no_overlap.Value==0
               OutIma = clahe_cvip_block(InIma,blocksize,1,clip_limit,byte); 
          else
            OutIma = clahe_cvip(InIma,blocksize,3,clip_limit,byte); 
          end
            Name = [file,' > Local H-equalization (' num2str(band) ',' num2str(blocksize) ',' num2str(band) ',)'];
            %update image history
            histo = [079 2];     %update image history
    end
elseif handles.bACE.Value              %performs Adaptive contrast enhancement filter
    %capture parameters from GUI
    block = str2double(handles.popKer.String(handles.popKer.Value));
    gainfactor = str2double(handles.popGain.String(handles.popGain.Value));
    meanfactor = str2double(handles.popMean.String(handles.popMean.Value));
    min_gain = str2double(handles.popMinGain.String(handles.popMinGain.Value));
    max_gain = str2double(handles.popMaxGain.String(handles.popMaxGain.Value));
    %calls ace filter function
    OutIma = adaptive_contrast_cvip(InIma,block,gainfactor,meanfactor,min_gain, max_gain);
    %OutIma = hist_stretch_cvip(InIma,lowlimit,highlimit,lowClip,highClip);
    %create image name including input parameters
    Name = [file,' > ACE_filter (' num2str(block) ',' num2str(gainfactor) ',' ...
        num2str(meanfactor) ',' num2str(min_gain) ',' num2str(max_gain) ',)'];
    %update image history
    histo = [186 block gainfactor meanfactor];     %update image history
elseif handles.bACE2.Value              %performs Adaptive contrast enhancement filter
    %capture parameters from GUI
    block = str2double(handles.popKer.String(handles.popKer.Value));
    gainfactor = str2double(handles.popGain.String(handles.popGain.Value));
    meanfactor = str2double(handles.popMean.String(handles.popMean.Value));
    %calls ace2 filter function
    OutIma = ace2_filter_cvip(InIma,block,gainfactor,meanfactor);
    %OutIma = hist_stretch_cvip(InIma,lowlimit,highlimit,lowClip,highClip);
    %create image name including input parameters
    Name = [file,' > ACE2_filter (' num2str(block) ',' num2str(gainfactor) ',' ...
        num2str(meanfactor) ',)'];
    %update image history
    histo = [186 block gainfactor meanfactor];     %update image history
elseif handles.blogACE.Value              %performs logarithmic Adaptive contrast enhancement filter
    %capture parameters from GUI
    block = str2double(handles.popKer.String(handles.popKer.Value));
    gainfactor = str2double(handles.popGain.String(handles.popGain.Value));
    meanfactor = str2double(handles.popMean.String(handles.popMean.Value));
    %calls log_ace_filter_cvip filter function
    OutIma = (log_ace_filter_cvip(InIma,block,gainfactor,meanfactor));
    
 
    %create image name including input parameters
    Name = [file,' > log_ace filter (' num2str(block) ',' num2str(gainfactor) ',' ...
        num2str(meanfactor) ',)'];
    %update image history
    histo = [193 block gainfactor meanfactor];     %update image history
elseif handles.bexpACE.Value               %performs exponential Adaptive contrast enhancement filter
    %capture parameters from GUI
    block = str2double(handles.popKer.String(handles.popKer.Value));
    gainfactor = str2double(handles.popGain.String(handles.popGain.Value));
    meanfactor = str2double(handles.popMean.String(handles.popMean.Value));
    %calls ace2 filter function
    OutIma = exp_ace_filter_cvip(InIma,block,gainfactor,meanfactor);
    OutIma = remap_cvip(OutIma,[]);
    %OutIma = remap_cvip(OutIma,range);
    %create image name including input parameters
    Name = [file,' > exp_ace_filter (' num2str(block) ',' num2str(gainfactor) ',' ...
        num2str(meanfactor) ',)'];
    %update image history
    histo = [190 block gainfactor meanfactor];     %update image history
elseif handles.bCCA.Value              %perform Color contrast algorithm
    %capture parameters from GUI
    lowlimit = str2double(handles.popLow.String(handles.popLow.Value));
    highlimit = str2double(handles.popHigh.String(handles.popHigh.Value));
    lowClip = str2double(handles.popLclip.String(handles.popLclip.Value));
    highClip = str2double(handles.popHclip.String(handles.popHclip.Value));
    %call histogram stretch function
    OutIma = ccenhance_cvip(InIma,lowlimit,highlimit,lowClip,highClip);
    %create image name including input parameters
    Name = [file,' > color contrast enhance (' num2str(lowlimit) ',' num2str(highlimit) ',' ...
        num2str(lowClip) ',' num2str(highClip) ')'];
    %update image history
    histo = [011 lowlimit highlimit lowClip highClip];     %update image history
elseif handles.bLM.Value              %perform Linear Modification
    %capture parameters from GUI
    start = str2double(handles.popstart.String(handles.popstart.Value));
    ends = str2double(handles.popend.String(handles.popend.Value));
    initial_value = str2double(handles.popinval.String(handles.popinval.Value));
    slope = str2double(handles.popslope.String(handles.popslope.Value));
    change = handles.brange.SelectedObject.UserData;    %get selected method
   if change == 1
          %calls gray_linear_cvip function
          OutIma = gray_linear_cvip(InIma,start,ends,initial_value,slope,change,-1);
            Name = [file,' > linear modification (' num2str(start) ',' num2str(ends) ',' ...
            num2str(initial_value) ',' num2str(slope) ')'];
            %update image history
            histo = [072 start ends initial_value slope];     %update image history
    elseif change == 0
          OutIma = gray_linear_cvip(InIma,start,ends,initial_value,slope,change,-1);
            Name = [file,' > linear modification (' num2str(start) ',' num2str(ends) ',' ...
            num2str(initial_value) ',' num2str(slope) ',' num2str(change) ',' num2str(band) ')'];
            %update image history
            histo = [072 start ends initial_value slope];     %update image history
    end
elseif handles.bHS.Value   %perform Histogram specification
    mapfunR = handles.popRed.Value;
    mapfunG = handles.popGreen.Value;
    mapfunB = handles.popBlue.Value;
    
    cA = [0.025 1 2 0.025 0.5 0.025 0.025 0.025 0.025 1];
    cB = [0 25 5 0 2 0 0 0 0 25];
    
    OutIma = hist_spec_cvip( InIma, [mapfunR mapfunG mapfunB], [cA(mapfunR)...
        cA(mapfunG) cA(mapfunB)],[cB(mapfunR) cB(mapfunG) cB(mapfunB)]);
    
     Name = [file,' > H-specification ('];
     histo = [075 ];     %update image history


elseif handles.bGLM.Value   %perform Gray Level Multiplication
    popFactor = str2double(handles.popFactor.String(handles.popFactor.Value));
    OutIma = multiply_cvip( InIma,popFactor );
    
     Name = [file,' > Gray_level_multiplication (' num2str(popFactor) ')'];
     histo = [004 popFactor ];     %update image history
     
end


%check if need to save history
if strcmp(hSHisto(1).Checked,'on')	%save new image history
    Ima.fInfo.history_info = historyupdate_cvip(Ima.fInfo.history_info,histo);  
end
%check if need to show function information
if strcmp(hVfinfo(1).Checked,'on')
    hIlist = findobj('Tag','txtIlist');%get handle of text element
    hIlist.String(end+1,1)=' ';   	%print an empty line
    txtInfo = historydeco_cvip(histo);     
    hIlist.String(end+1,1:size(file,2)+1)=[file ':']; 
    for i=1:size(txtInfo)
        sInfo = txtInfo{i};     	%exract row to print
        sInfo = sprintf(sInfo);     %print information
        [~,rr] = size(sInfo);
        hIlist.String(end+1,1:rr) = sInfo;
    end
    hIlist.Value = size(hIlist.String,1);%goto last line
    figure(hMain);
end
[row,col,band]=size(OutIma);       	%get new image size
%update image information
Ima.fInfo.no_of_bands=band;             
Ima.fInfo.no_of_cols=col;              
Ima.fInfo.no_of_rows=row;
%update image structure
Ima.cvipIma = OutIma; 
%%for hadlining logACE and expace image
if handles.blogACE.Value  
    hFig=NewFig;                                %call new figure form
    hFig.WindowStyle = 'normal';                %set initial window style
    set(gcf,'Name',Name,'NumberTitle','off')    %name figure
     hFig.UserData = Ima;                       %storage image info

      OutIma = Ima.cvipIma;
      imshow((OutIma));
      axis('off');
   hMain = findobj('Tag','Main');              %get the handle of Main form
   if ~isempty(hMain)
    hNfig = get(hMain,'UserData');          %get last image handle
    if hNfig ~= 0                           %check if there is a prev Ima
        figure(hNfig);                      %focus to last image
    end
   end 
                
   CVIPToolbox('updatemenus');                 %call function to update
%Add figure to group
    group = setfigdocked('GroupName','CVIP Toolbox V.3.62','Figure',hFig); 
    figure(hFig);
     
else
    %read image data
showgui_cvip(Ima, Name);
end
else                                %display error message
    errordlg(['There is nothing to process. Please select an Image and'...
        ' try again.'],'Compression Error','modal');
end

%changing pointer watch back to arrow on cursor
set(figure_set,'pointer','arrow');


% --- Executes on button press in bCancel.
function bCancel_Callback(hObject, eventdata, handles)
% hObject    handle to bCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Prepare to close application window
 close(handles.HistConN)


% --- Executes on button press in bReset.
function bReset_Callback(hObject, eventdata, handles)
% hObject    handle to bReset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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
function HistConN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HistConN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



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


% --- Executes on selection change in popLow.
function popLow_Callback(hObject, eventdata, handles)
% hObject    handle to popLow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popLow contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popLow


% --- Executes during object creation, after setting all properties.
function popLow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popLow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popHigh.
function popHigh_Callback(hObject, eventdata, handles)
% hObject    handle to popHigh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popHigh contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popHigh


% --- Executes during object creation, after setting all properties.
function popHigh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popHigh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popLclip.
function popLclip_Callback(hObject, eventdata, handles)
% hObject    handle to popLclip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 clip = str2double(handles.popLclip.String(handles.popLclip.Value))*100
 clip=int2str(clip)
 clip=strcat(clip,'%')
 set(handles.low_t,'String',clip)


% Hints: contents = cellstr(get(hObject,'String')) returns popLclip contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popLclip


% --- Executes during object creation, after setting all properties.
function popLclip_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popLclip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popHclip.
function popHclip_Callback(hObject, eventdata, handles)
% hObject    handle to popHclip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clip = str2double(handles.popHclip.String(handles.popHclip.Value))*100
 clip=int2str(clip)
 clip=strcat(clip,'%')
 set(handles.high_t,'String',clip)

% Hints: contents = cellstr(get(hObject,'String')) returns popHclip contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popHclip


% --- Executes during object creation, after setting all properties.
function popHclip_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popHclip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes on selection change in popKer.
function popKer_Callback(hObject, eventdata, handles)
% hObject    handle to popKer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popKer contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popKer
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function popKer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popKer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popMean.
function popMean_Callback(hObject, eventdata, handles)
% hObject    handle to popMean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popMean contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popMean


% --- Executes during object creation, after setting all properties.
function popMean_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popMean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popGain.
function popGain_Callback(hObject, eventdata, handles)
% hObject    handle to popGain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popGain contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popGain


% --- Executes during object creation, after setting all properties.
function popGain_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popGain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bACE.
function bACE_Callback(hObject, eventdata, handles)
% hObject    handle to bACE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bACE
hide_all(handles);
handles.text58.Visible='on';
handles.popMinGain.Visible='on';
handles.text59.Visible='on';
handles.popMaxGain.Visible='on';
handles.pACE.Visible='on';

% --- Executes on button press in bACE2.
function bACE2_Callback(hObject, eventdata, handles)
% hObject    handle to bACE2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bACE2
hide_all(handles);
handles.text58.Visible='off';
handles.popMinGain.Visible='off';
handles.text59.Visible='off';
handles.popMaxGain.Visible='off';
handles.pACE.Visible='on';


% --- Executes on button press in bStre.
function bStre_Callback(hObject, eventdata, handles)
% hObject    handle to bStre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bStre
hide_all(handles);
handles.pStre.Visible='on';
handles.popMaxGain.Visible='off';
handles.pStre.Position(2) = 19.8;

% --- Executes on selection change in popamount.
function popamount_Callback(hObject, eventdata, handles)
% hObject    handle to popamount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popamount contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popamount


% --- Executes during object creation, after setting all properties.
function popamount_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popamount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu39.
function popupmenu39_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu39 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu39


% --- Executes during object creation, after setting all properties.
function popupmenu39_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu40.
function popupmenu40_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu40 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu40


% --- Executes during object creation, after setting all properties.
function popupmenu40_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on bvalue and none of its controls.
function bvalue_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to bvalue (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popLlimit.
function popLlimit_Callback(hObject, eventdata, handles)
% hObject    handle to popLlimit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popLlimit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popLlimit


% --- Executes during object creation, after setting all properties.
function popLlimit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popLlimit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pophlimit.
function pophlimit_Callback(hObject, eventdata, handles)
% hObject    handle to pophlimit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pophlimit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pophlimit


% --- Executes during object creation, after setting all properties.
function pophlimit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pophlimit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on popamount and none of its controls.
function popamount_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popamount (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
pop_add_cvip(hObject, eventdata);


% --- Executes on key press with focus on popLlimit and none of its controls.
function popLlimit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popLlimit (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
pop_add_cvip(hObject, eventdata);   %call function to add user data 


% --- Executes on key press with focus on pophlimit and none of its controls.
function pophlimit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to pophlimit (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
pop_add_cvip(hObject, eventdata);   %call function to add user data 


% --- Executes on selection change in popupmenu46.
function popupmenu46_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu46 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu46 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu46


% --- Executes during object creation, after setting all properties.
function popupmenu46_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu46 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu47.
function popupmenu47_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu47 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu47 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu47


% --- Executes during object creation, after setting all properties.
function popupmenu47_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu47 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu48.
function popupmenu48_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu48 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu48 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu48


% --- Executes during object creation, after setting all properties.
function popupmenu48_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu48 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in blogACE.
function blogACE_Callback(hObject, eventdata, handles)
% hObject    handle to blogACE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of blogACE
hide_all(handles);
handles.text58.Visible='off';
handles.popMinGain.Visible='off';
handles.text59.Visible='off';
handles.popMaxGain.Visible='off';
handles.pACE.Visible='on';

function hide_all(handles)
handles.no_overlap.Visible='off';
handles.byte.Visible='off'  ;       
handles.pACE.Visible='off';
handles.pStre.Visible='off';
handles.pHQ.Visible='off';
handles.pslide.Visible='off';
handles.pshrink.Visible='off';
handles.pHistspec.Visible='Off';
handles.pLM.Visible='off';
handles.pGLM.Visible='off';
handles.phequal.Visible='off';
handles.text_limit.Visible='off';
handles.clip_limit.Visible='off';
handles.text55.Visible='off'




% --- Executes on button press in bhisteq.
function bhisteq_Callback(hObject, eventdata, handles)
% hObject    handle to bhisteq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bhisteq
hide_all(handles);
handles.pHQ.Visible='on';
handles.phequal.Visible='On';
handles.textBS.Visible='off';
handles.popMaxGain.Visible='off';
handles.popblock.Visible='off';

% --- Executes on selection change in popKerl.
function popKerl_Callback(hObject, eventdata, handles)
% hObject    handle to popKerl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popKerl contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popKerl


% --- Executes during object creation, after setting all properties.
function popKerl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popKerl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popGainl.
function popGainl_Callback(hObject, eventdata, handles)
% hObject    handle to popGainl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popGainl contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popGainl


% --- Executes during object creation, after setting all properties.
function popGainl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popGainl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popMeanl.
function popMeanl_Callback(hObject, eventdata, handles)
% hObject    handle to popMeanl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popMeanl contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popMeanl


% --- Executes during object creation, after setting all properties.
function popMeanl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popMeanl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popRed.
function popRed_Callback(hObject, eventdata, handles)
% hObject    handle to popRed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popRed contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popRed


% --- Executes during object creation, after setting all properties.
function popRed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popRed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popBlue.
function popBlue_Callback(hObject, eventdata, handles)
% hObject    handle to popBlue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popBlue contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popBlue


% --- Executes during object creation, after setting all properties.
function popBlue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popBlue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popGreen.
function popGreen_Callback(hObject, eventdata, handles)
% hObject    handle to popGreen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popGreen contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popGreen


% --- Executes during object creation, after setting all properties.
function popGreen_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popGreen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popstart.
function popstart_Callback(hObject, eventdata, handles)
% hObject    handle to popstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popstart contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popstart


% --- Executes during object creation, after setting all properties.
function popstart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popend.
function popend_Callback(hObject, eventdata, handles)
% hObject    handle to popend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popend contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popend


% --- Executes during object creation, after setting all properties.
function popend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popinval.
function popinval_Callback(hObject, eventdata, handles)
% hObject    handle to popinval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popinval contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popinval


% --- Executes during object creation, after setting all properties.
function popinval_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popinval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popslope.
function popslope_Callback(hObject, eventdata, handles)
% hObject    handle to popslope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popslope contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popslope


% --- Executes during object creation, after setting all properties.
function popslope_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popslope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popKer.
function popupmenu62_Callback(hObject, eventdata, handles)
% hObject    handle to popKer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popKer contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popKer


% --- Executes during object creation, after setting all properties.
function popupmenu62_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popKer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popGLM.
function popGLM_Callback(hObject, eventdata, handles)
% hObject    handle to popGLM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popGLM contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popGLM


% --- Executes during object creation, after setting all properties.
function popGLM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popGLM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkHS.
function checkHS_Callback(hObject, eventdata, handles)
% hObject    handle to checkHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkHS


% --- Executes on selection change in popFactor.
function popFactor_Callback(hObject, eventdata, handles)
% hObject    handle to popFactor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popFactor contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popFactor


% --- Executes during object creation, after setting all properties.
function popFactor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popFactor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox15.
function checkbox15_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox15


% --- Executes on selection change in popblock.
function popblock_Callback(hObject, eventdata, handles)
% hObject    handle to popblock (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popblock contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popblock


% --- Executes during object creation, after setting all properties.
function popblock_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popblock (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bhslide.
function bhslide_Callback(hObject, eventdata, handles)
% hObject    handle to bhslide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bhslide
hide_all(handles);
handles.popMaxGain.Visible='off';
handles.pslide.Visible='on';


% --- Executes on button press in bhshrink.
function bhshrink_Callback(hObject, eventdata, handles)
% hObject    handle to bhshrink (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bhshrink
hide_all(handles);
handles.popMaxGain.Visible='off';
handles.pshrink.Visible='On';


% --- Executes on button press in bLE.
function bLE_Callback(hObject, eventdata, handles)
% hObject    handle to bLE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bLE
hide_all(handles);
handles.phequal.Visible='on';
handles.pHQ.Visible='on';
handles.textBS.Visible='on';
handles.popMaxGain.Visible='off';
handles.popblock.Visible='on';

% --- Executes on button press in bGLM.
function bGLM_Callback(hObject, eventdata, handles)
% hObject    handle to bGLM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bGLM
hide_all(handles);
handles.pGLM.Visible='On';


% --- Executes on button press in bLM.
function bLM_Callback(hObject, eventdata, handles)
% hObject    handle to bLM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bLM
hide_all(handles);
handles.pLM.Visible='On';


% --- Executes on button press in bHS.
function bHS_Callback(hObject, eventdata, handles)
% hObject    handle to bHS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bHS
hide_all(handles);
handles.pHistspec.Visible='On';


% --- Executes on button press in bCCA.
function bCCA_Callback(hObject, eventdata, handles)
% hObject    handle to bCCA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bCCA
hide_all(handles);
handles.pStre.Visible='on';
handles.pStre.Position(2) = 7.5;

% --- Executes on button press in bexpACE.
function bexpACE_Callback(hObject, eventdata, handles)
% hObject    handle to bexpACE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bexpACE
hide_all(handles);
handles.text58.Visible='off';
handles.popMinGain.Visible='off';
handles.text59.Visible='off';
handles.popMaxGain.Visible='off';
handles.pACE.Visible='On';


% --- Executes on key press with focus on popblock and none of its controls.
function popblock_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popblock (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
pop_add_cvip(hObject, eventdata);   %call function to add user data 


% --- Executes on key press with focus on popKer and none of its controls.
function popKer_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popKer (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
pop_add_cvip(hObject, eventdata);   %call function to add user data 


% --- Executes on key press with focus on popMean and none of its controls.
function popMean_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popMean (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
pop_add_cvip(hObject, eventdata);   %call function to add user data 


% --- Executes on key press with focus on popGain and none of its controls.
function popGain_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popGain (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
pop_add_cvip(hObject, eventdata);   %call function to add user data 


% --- Executes on key press with focus on popstart and none of its controls.
function popstart_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popstart (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
pop_add_cvip(hObject, eventdata);   %call function to add user data 


% --- Executes on key press with focus on popend and none of its controls.
function popend_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popend (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
pop_add_cvip(hObject, eventdata);   %call function to add user data 


% --- Executes on key press with focus on popinval and none of its controls.
function popinval_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popinval (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
pop_add_cvip(hObject, eventdata);   %call function to add user data 


% --- Executes on key press with focus on popslope and none of its controls.
function popslope_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popslope (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
pop_add_cvip(hObject, eventdata);   %call function to add user data 


% --- Executes on key press with focus on popFactor and none of its controls.
function popFactor_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popFactor (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
pop_add_cvip(hObject, eventdata);   %call function to add user data 


% --- Executes on key press with focus on popRed and none of its controls.
function popRed_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popRed (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
pop_add_cvip(hObject, eventdata);   %call function to add user data 


% --- Executes on key press with focus on popGreen and none of its controls.
function popGreen_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popGreen (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
pop_add_cvip(hObject, eventdata);   %call function to add user data 


% --- Executes on key press with focus on popBlue and none of its controls.
function popBlue_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popBlue (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
pop_add_cvip(hObject, eventdata);   %call function to add user data 


% --- Executes on key press with focus on bdataran and none of its controls.
function bdataran_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to bdataran (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on popHigh and none of its controls.
function popHigh_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popHigh (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
pop_add_cvip(hObject, eventdata);   %call function to add user data 


% --- Executes on selection change in popKer.
function popupmenu66_Callback(hObject, eventdata, handles)
% hObject    handle to popKer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popKer contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popKer


% --- Executes during object creation, after setting all properties.
function popupmenu66_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popKer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on popLow and none of its controls.
function popLow_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popLow (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
pop_add_cvip(hObject, eventdata);   %call function to add user data


% --- Executes on button press in clahe.
function clahe_Callback(hObject, eventdata, handles)
% hObject    handle to clahe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

hide_all(handles);
set(handles.no_overlap,'value',1)
handles.byte.Visible='on';
handles.no_overlap.Visible='on';
handles.pHQ.Visible='on';
handles.phequal.Visible='On';
handles.textBS.Visible='on';
handles.popblock.Visible='on';
handles.text_limit.Visible='on';
handles.clip_limit.Visible='on';
handles.clip_limit.Visible='on';
handles.popMaxGain.Visible='off';
handles.text55.Visible='on';

% Hint: get(hObject,'Value') returns toggle state of clahe


% --- Executes on selection change in clip_limit.
function clip_limit_Callback(hObject, eventdata, handles)
% hObject    handle to clip_limit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 clip = str2double(handles.clip_limit.String(handles.clip_limit.Value))*100;
 clip=int2str(clip);
 clip=strcat(clip,'%');
 set(handles.text55,'String',clip);



% Hints: contents = cellstr(get(hObject,'String')) returns clip_limit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from clip_limit


% --- Executes during object creation, after setting all properties.
function clip_limit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to clip_limit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on clip_limit and none of its controls.
function clip_limit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to clip_limit (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
pop_add_cvip(hObject, eventdata);


% --- Executes on button press in no_overlap.
function no_overlap_Callback(hObject, eventdata, handles)
% hObject    handle to no_overlap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of no_overlap


% --- Executes on button press in byte.
function byte_Callback(hObject, eventdata, handles)
% hObject    handle to byte (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of byte


% --- Executes on button press in bred.
function bred_Callback(hObject, eventdata, handles)
% hObject    handle to bred (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bred


% --- Executes during object creation, after setting all properties.
function text55_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text55 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function low_t_CreateFcn(hObject, eventdata, handles)
% hObject    handle to low_t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function high_t_CreateFcn(hObject, eventdata, handles)
% hObject    handle to high_t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in popMaxGain.
function popMaxGain_Callback(hObject, eventdata, handles)
% hObject    handle to popMaxGain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popMaxGain contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popMaxGain


% --- Executes during object creation, after setting all properties.
function popMaxGain_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popMaxGain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popMinGain.
function popMinGain_Callback(hObject, eventdata, handles)
% hObject    handle to popMinGain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popMinGain contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popMinGain


% --- Executes during object creation, after setting all properties.
function popMinGain_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popMinGain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object deletion, before destroying properties.
function blank_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blank (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object deletion, before destroying properties.
function blank_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to blank (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function bACE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bACE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


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
