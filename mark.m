function varargout = mark(varargin)
% MARK MATLAB code for mark.fig
%      MARK, by itself, creates a new MARK or raises the existing
%      singleton*.
%
%      H = MARK returns the handle to a new MARK or the handle to
%      the existing singleton*.
%
%      MARK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MARK.M with the given input arguments.
%
%      MARK('Property','Value',...) creates a new MARK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mark_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mark_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mark

% Last Modified by GUIDE v2.5 27-Sep-2017 15:33:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mark_OpeningFcn, ...
                   'gui_OutputFcn',  @mark_OutputFcn, ...
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


% --- Executes just before mark is made visible.
function mark_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mark (see VARARGIN)

% Choose default command line output for mark
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mark wait for user response (see UIRESUME)
% uiwait(handles.figure1);



% --- Outputs from this function are returned to the command line.
function varargout = mark_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in getFile.
function getFile_Callback(hObject, eventdata, handles)
% hObject    handle to getFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    [filename,pathname]=uigetfile(...
        {'*.bmp;*.jpg;*.png;*.jpeg','图象文件(*.bmp,*.jpg,*.png,*,jpeg)';...
        '*,*','所有文件(*.*)'}, ...
        '请选择一个图片文件');
    str=[pathname filename];
    %显示图像
    subimage(imread(str));
    if isequal(filename,0)||isequal(pathname,0)
        return;
    end
    handles.filename = filename;
    handles.pathname = pathname;
    guidata(hObject,handles);
    %获取当前帧和总体帧数并显示在文字中
    fileList = dir(pathname);
    long = length(fileList)-2;
    
    handles.long = long;
    guidata(hObject,handles);
    
    now = filename(10:length(filename)-4); %now str
    show = strcat(now,'/');
    show = strcat(show,num2str(long));
    set(handles.showtext,'String',show);
    %count
    global count;
    count = str2num(now);% now count is num;


% --- Executes on button press in getNextFrame.
function getNextFrame_Callback(hObject, eventdata, handles)
% hObject    handle to getNextFrame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    filename = handles.filename;
    pathname = handles.pathname;
    long = handles.long;
            
    global count;  %str 
    next_file_name = filename(1:9);
    i = count+1; %% +1 is the next frames
    count = count +1;
    next_file_name = strcat(next_file_name,num2str(i));
    next_file_name = strcat(next_file_name,'.jpg');
    next_str=[pathname next_file_name];
    subimage(imread(next_str));
    
     %写当前帧
    
    now = num2str(count); %now str    
    show = strcat(now,'/');
    show = strcat(show,num2str(long));
    set(handles.showtext,'String',show);

% --- Executes on button press in getLastFrame.
function getLastFrame_Callback(hObject, eventdata, handles)
% hObject    handle to getLastFrame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 和上面个一样，每次把全局变量count-1
    filename = handles.filename;
    pathname = handles.pathname;
    long = handles.long;
    
    global count;  %str 
    next_file_name = filename(1:9);
    i = count-1; %% +1 is the next frames
    count = count -1;
    next_file_name = strcat(next_file_name,num2str(i));
    next_file_name = strcat(next_file_name,'.jpg');
    next_str=[pathname next_file_name];
    subimage(imread(next_str));
    
     %写当前帧   
    now = num2str(count); %now str    
    show = strcat(now,'/');
    show = strcat(show,num2str(long));
    set(handles.showtext,'String',show);
    
    

% --- Executes on button press in saveImage.
function saveImage_Callback(hObject, eventdata, handles)
% hObject    handle to saveImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% % 保存画图后的图片，并把原来的文件改名。
        filename = handles.filename;
        pathname = handles.pathname;     
        x = handles.X;y = handles.Y; % 坐标;
        zblu = handles.zblu;
        zbrd = handles.zbrd;
        
        %当前帧
        %frame_now = filename(10:length(filename)-4);
        % 直接读全局变量。。
        
        t = filename(1:9);
        t = strcat(t,'zb');
        t = strcat(t,'.txt'); % 保存了的名字;
        allname = strcat(pathname,t);
        global count;
        fp = fopen(allname,'a');
        fprintf(fp,'%s ',num2str(count));
        fprintf(fp,'%s \t ',zblu);
        fprintf(fp,'%s \r\n ',zbrd);
        fclose(fp);
        
  


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over LD.
function LD_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to LD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in mark_button.
function mark_button_Callback(hObject, eventdata, handles)
% hObject    handle to mark_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    %取得两个点的坐标
    [x,y] = ginput(2);
    zb1x = x(1);zb1x = round(zb1x);
    zb2x = x(2);zb2x = round(zb2x);
    zb1y = y(1);zb1y = round(zb1y);
    zb2y = y(2);zb2y = round(zb2y);
    zblu = strcat(num2str(zb1x),'/');zblu = strcat(zblu,num2str(zb1y));
    zbrd = strcat(num2str(zb2x),'/');zbrd = strcat(zbrd,num2str(zb2y));
    handles.X = x;
    handles.Y = y;
    handles.zblu = zblu;
    handles.zbrd = zbrd;
    guidata(hObject,handles);
    set(handles.LU,'String',zblu);
    set(handles.LD,'String',zbrd);
    %计算出4个点的坐标然后plot好画
%     zblr = [zb1x zb1y];zbru = [zb2x zb1y];zbld = [zb1x zb2y];zbld = [zb2x zb2y];
    


% --- Executes on button press in plot_button.
function plot_button_Callback(hObject, eventdata, handles)
% hObject    handle to plot_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
   %取标记的坐标
    x = handles.X;
    y = handles.Y;
   %画框
    hold on;
    rectangle('position',[x(1),y(1),x(2)-x(1),y(2)-y(1)],'edgecolor','r');
    hold off;
    
    
    
 % --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

  
% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%      set(gcf, 'WindowButtonDownFcn') %  取句柄;
     pt = get(gca,'CurrentPoint');%text(pt(1,1),pt(1,2),num2str(pt(1,1:2)));
     set(handles.text12,'String',(num2str(round(pt(1,1:2)))));
%      handles.pt = pt;
%      guidata(hObject,handles);



function Center_Callback(hObject, eventdata, handles)
% hObject    handle to Center (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Center as text
%        str2double(get(hObject,'String')) returns contents of Center as a double


% --- Executes during object creation, after setting all properties.
function Center_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Center (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on figure1 or any of its controls.
function figure1_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
    key = get(handles.figure1,'CurrentKey');
    switch key
        case 'w'
            plot_button_Callback(hObject, eventdata, handles);
        case 'd'
            mark_button_Callback(hObject, eventdata, handles);
        case 's'
            saveImage_Callback(hObject, eventdata, handles);
        case 'a'
            getNextFrame_Callback(hObject, eventdata, handles);
    end
    

