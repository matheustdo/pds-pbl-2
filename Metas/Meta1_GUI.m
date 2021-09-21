function varargout = Meta1_GUI(varargin)
% META1_GUI MATLAB code for Meta1_GUI.fig
%      META1_GUI, by itself, creates a new META1_GUI or raises the existing
%      singleton*.
%
%      H = META1_GUI returns the handle to a new META1_GUI or the handle to
%      the existing singleton*.
%
%      META1_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in META1_GUI.M with the given input arguments.
%
%      META1_GUI('Property','Value',...) creates a new META1_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Meta1_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Meta1_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Meta1_GUI

% Last Modified by GUIDE v2.5 17-Sep-2021 17:47:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Meta1_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Meta1_GUI_OutputFcn, ...
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


% --- Executes just before Meta1_GUI is made visible.
function Meta1_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Meta1_GUI (see VARARGIN)

% Choose default command line output for Meta1_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Meta1_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Meta1_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function input_panel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_panel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function duracao_text_Callback(hObject, eventdata, handles)
% hObject    handle to duracao_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of duracao_text as text
%        str2double(get(hObject,'String')) returns contents of duracao_text as a double


% --- Executes during object creation, after setting all properties.
function duracao_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to duracao_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fcmin_text_Callback(hObject, eventdata, handles)
% hObject    handle to fcmin_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fcmin_text as text
%        str2double(get(hObject,'String')) returns contents of fcmin_text as a double


% --- Executes during object creation, after setting all properties.
function fcmin_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fcmin_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fcmax_text_Callback(hObject, eventdata, handles)
% hObject    handle to fcmax_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fcmax_text as text
%        str2double(get(hObject,'String')) returns contents of fcmax_text as a double


% --- Executes during object creation, after setting all properties.
function fcmax_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fcmax_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function amostragem_text_Callback(hObject, eventdata, handles)
% hObject    handle to amostragem_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of amostragem_text as text
%        str2double(get(hObject,'String')) returns contents of amostragem_text as a double


% --- Executes during object creation, after setting all properties.
function amostragem_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amostragem_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in gerarsinal_button.
function gerarsinal_button_Callback(hObject, eventdata, handles)
    tempo = str2double(handles.duracao_text.String);
    fcmin = str2double(handles.fcmin_text.String);
    fcmax = str2double(handles.fcmax_text.String);
    amostras = str2double(handles.amostragem_text.String);
    [xt,fc,phi,t]=sinal(tempo,fcmin,fcmax,amostras);
    
     plot(handles.axes1, t, xt);
%     plot(handles.axes1, t, xt);
% hObject    handle to gerarsinal_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
