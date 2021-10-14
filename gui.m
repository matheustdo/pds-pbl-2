function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 07-Oct-2021 22:47:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbuttonExecutar.
function pushbuttonExecutar_Callback(hObject, eventdata, handles)
    fs = str2double(handles.editFreqAmostragem.String);
    fc = str2double(handles.editFreqPassagem.String)/fs;
    banda_transicao = str2double(handles.editLarguraTransicao.String);
    BW = banda_transicao/fs;
    M = 4/BW;
    centro = floor(M/2);
    n = 1:M;
    h_n = zeros(1); % Inicializa o h[n]
    
    if handles.passaBaixa.Value == 1
        h_n = sin(2*pi*fc.*(n-(M/2)))./(pi*(n-(M/2)));    
        h_n(centro) = 2*fc;
    elseif handles.passaAlta.Value == 1
        h_n = - sin(2*pi*fc.*(n-(M/2)))./(pi*(n-(M/2)));
        h_n(centro) = (1 - 2*fc);
    elseif handles.passaFaixa.Value == 1
        fc2 = (str2double(handles.editFreqCorteSup.String))/fs;
        h_n = (sin(2*pi*fc2.*(n-(M/2))) - sin(2*pi*fc.*(n-(M/2))))./(pi*(n-(M/2)));
        h_n(centro) = (2*fc2 - 2*fc);
    elseif handles.rejeitaFaixa.Value == 1
        fc2 = (str2double(handles.editFreqCorteSup.String))/fs;
        h_n = (sin(2*pi*fc.*(n-(M/2))) - sin(2*pi*fc2.*(n-(M/2))))./(pi*(n-(M/2)));
        h_n(centro) = 1-(2*fc2 - 2*fc);
    end
    
    janela = zeros(1); % Inicializa a janela
    
    if handles.retangular.Value == 1
        for i=1:M
            janela(i) = 1;
        end
    elseif handles.bartlett.Value == 1
        M = str2double(handles.editLarguraTransicao.String);
        n = 1:M;
        
        if handles.passaBaixa.Value == 1
            h_n = sin(2*pi*fc.*(n-(M/2)))./(pi*(n-(M/2)));    
            h_n(M/2) = 2*fc;
        elseif handles.passaAlta.Value == 1
            h_n = - sin(2*pi*fc.*(n-(M/2)))./(pi*(n-(M/2)));
            h_n(M/2) = (1 - 2*fc);
        elseif handles.passaFaixa.Value == 1
            fc2 = (str2double(handles.editFreqCorteSup.String))/fs;
            h_n = (sin(2*pi*fc2.*(n-(M/2))) - sin(2*pi*fc.*(n-(M/2))))./(pi*(n-(M/2)));
            h_n(M/2) = (2*fc2 - 2*fc);
        elseif handles.rejeitaFaixa.Value == 1
            fc2 = (str2double(handles.editFreqCorteSup.String))/fs;
            h_n = (sin(2*pi*fc.*(n-(M/2))) - sin(2*pi*fc2.*(n-(M/2))))./(pi*(n-(M/2)));
            h_n(M/2) = 1-(2*fc2 - 2*fc);
        end
    
        if rem(M, 2) == 0
            for i=1:(M/2)
                janela(floor(i)) = 2*i/M;
            end
            
            for i=((M+1)/2):M
                janela(round(i)) = 2 - 2*i/M;
            end
        end
    elseif handles.hamming.Value == 1
        janela = 0.54 - 0.46.*cos(2*pi.*n/M);
    elseif handles.hann.Value == 1
        janela = 0.5 - 0.5.*cos(2*pi.*n/M);
    elseif handles.blackman.Value == 1
        janela = 0.42 - 0.5.*cos(2*pi.*n/M) + 0.08.*cos(4*pi.*n/M);
    end
    
    janelado = h_n.*janela;
    
    stem(handles.axes1, n, janelado);
    
    NFFT = length(janelado);
    Y = fft(janelado, NFFT);
    Ydb = 20*log10(abs(Y));
    F = ((0:1/NFFT:1-1/NFFT)*fs).'; 
    
    magnitude = Ydb;
    xlabel('$f$(Hz)','interpreter','latex');
    ylabel('Magnitude(dB)');
    plot(handles.axes2,F,magnitude);
    
    fase = unwrap(angle(Y));
    xlabel('$f$(Hz)','interpreter','latex');
    ylabel('Fase(radianos)');
    plot(handles.axes3,F,fase);
    
    
    persistent wvfigh; % Inicializa uma vari�vel persistente
    delete(wvfigh); % Deleta o wvtool anterior se ele for existente
    oldAxes = findall(handles.uipanel3, 'type', 'axes') % Deleta o wv anterior caso o persistent tenha se perdido
    delete(oldAxes); % Deleta o wv anterior caso o persistent tenha se perdido
    
    wvfigh = wvtool(janela); % Cria a janela com o wvtool
    set(wvfigh, 'Visible', 'off'); % Tira a visibilidade da janela do wvtool
    wvfigax = findall(wvfigh, 'type', 'axes'); % Pega os axes do wvtool
    set(wvfigax, 'Parent', handles.uipanel3); % Coloca os axes do wvtool no nosso painel
    disp('a')
%     Omega = -pi:pi/100:6*pi;
%     for nn = 1:1:length(n)
%         for O= 1:1:length(Omega)
%             XOmega(nn,O)=janelado(nn)*exp(-j*Omega(O)*n(nn));
%         end
%     end
%     for W=1:1:length(Omega)
%         XOMEGA(W)=sum(XOmega(:,W));
%     end
%     plot(handles.axes3,W,XOMEGA);
    
    
  
    
    
    
% hObject    handle to pushbuttonExecutar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function editFreqPassagem_Callback(hObject, eventdata, handles)
% hObject    handle to editFreqPassagem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFreqPassagem as text
%        str2double(get(hObject,'String')) returns contents of editFreqPassagem as a double


% --- Executes during object creation, after setting all properties.
function editFreqPassagem_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFreqPassagem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editLarguraTransicao_Callback(hObject, eventdata, handles)
% hObject    handle to editLarguraTransicao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editLarguraTransicao as text
%        str2double(get(hObject,'String')) returns contents of editLarguraTransicao as a double


% --- Executes during object creation, after setting all properties.
function editLarguraTransicao_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editLarguraTransicao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editFreqAmostragem_Callback(hObject, eventdata, handles)
% hObject    handle to editFreqAmostragem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFreqAmostragem as text
%        str2double(get(hObject,'String')) returns contents of editFreqAmostragem as a double


% --- Executes during object creation, after setting all properties.
function editFreqAmostragem_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFreqAmostragem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bartlett.
function bartlett_Callback(hObject, eventdata, handles)
    handles.text3.String = 'Ordem do filtro (N�mero inteiro par)';
% hObject    handle to bartlett (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bartlett


% --- Executes on button press in retangular.
function retangular_Callback(hObject, eventdata, handles)
     handles.text3.String = 'Largura da banda de transi��o (Hz)';
% hObject    handle to retangular (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of retangular


% --- Executes on button press in hamming.
function hamming_Callback(hObject, eventdata, handles)
    handles.text3.String = 'Largura da banda de transi��o (Hz)';
% hObject    handle to hamming (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hamming


% --- Executes on button press in hann.
function hann_Callback(hObject, eventdata, handles)
    handles.text3.String = 'Largura da banda de transi��o (Hz)';
% hObject    handle to hann (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hann


% --- Executes on button press in blackman.
function blackman_Callback(hObject, eventdata, handles)
    handles.text3.String = 'Largura da banda de transi��o (Hz)';
% hObject    handle to blackman (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of blackman


% --- Executes on key press with focus on blackman and none of its controls.
function blackman_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to blackman (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



function editFreqCorteSup_Callback(hObject, eventdata, handles)
% hObject    handle to editFreqCorteSup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFreqCorteSup as text
%        str2double(get(hObject,'String')) returns contents of editFreqCorteSup as a double


% --- Executes during object creation, after setting all properties.
function editFreqCorteSup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFreqCorteSup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in passaBaixa.
function passaBaixa_Callback(hObject, eventdata, handles)
% hObject    handle to passaBaixa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.text2.String = 'Frequ�ncia de passagem (Hz)';
handles.editFreqCorteSup.Enable = 'off';
handles.editFreqCorteSup.Visible = 'Off';
handles.text11.Enable = 'off';
handles.text11.Visible = 'Off';


% Hint: get(hObject,'Value') returns toggle state of passaBaixa


% --- Executes on button press in passaAlta.
function passaAlta_Callback(hObject, eventdata, handles)
% hObject    handle to passaAlta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.text2.String = 'Frequ�ncia de passagem (Hz)';
handles.editFreqCorteSup.Enable = 'off';
handles.editFreqCorteSup.Visible = 'Off';
handles.text11.Enable = 'off';
handles.text11.Visible = 'Off';

% Hint: get(hObject,'Value') returns toggle state of passaAlta


% --- Executes on button press in passaFaixa.
function passaFaixa_Callback(hObject, eventdata, handles)
% hObject    handle to passaFaixa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.text2.String = 'Frequ�ncia de corte inferior (Hz)';
handles.editFreqCorteSup.Enable = 'on';
handles.editFreqCorteSup.Visible = 'On';
handles.text11.Enable = 'on';
handles.text11.Visible = 'On';
% Hint: get(hObject,'Value') returns toggle state of passaFaixa


% --- Executes on button press in rejeitaFaixa.
function rejeitaFaixa_Callback(hObject, eventdata, handles)
% hObject    handle to rejeitaFaixa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.text2.String = 'Frequ�ncia de corte inferior (Hz)';
handles.editFreqCorteSup.Enable = 'on';
handles.editFreqCorteSup.Visible = 'On';
handles.text11.Enable = 'on';
handles.text11.Visible = 'On';
% Hint: get(hObject,'Value') returns toggle state of rejeitaFaixa
