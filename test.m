
function varargout = test(varargin)
% TEST MATLAB code for test.fig
%      TEST, by itself, creates a new TEST or raises the existing
%      singleton*.
%
%      H = TEST returns the handle to a new TEST or the handle to
%      the existing singleton*.
%
%      TEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST.M with the given input arguments.
%
%      TEST('Property','Value',...) creates a new TEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before test_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to test_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help test

% Last Modified by GUIDE v2.5 12-May-2025 02:11:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @test_OpeningFcn, ...
                   'gui_OutputFcn',  @test_OutputFcn, ...
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


% --- Executes just before test is made visible.
function test_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to test (see VARARGIN)

% Choose default command line output for test
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes test wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = test_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global y t fs fvec Ts n
[Filename,Pathname] = uigetfile('*.mp3','File Selector');
audioFileName = strcat(Pathname,Filename);
[y,fs] = audioread(audioFileName);
y = y(:,1);
Ts = 1/fs; 
n = length( y );
t = linspace(0 ,(n-1)*Ts , n );
axes(handles.axes3);
plot(t,y);
title( "Signal in time domain : " );
xlabel("Time (t) ");
ylabel("y");
grid on;

Y = fftshift( fft(y) );
fvec = linspace(-0.5*fs,0.5*fs,n);
sound(y,fs);
axes(handles.axes1);
plot(fvec,abs(Y));
title( "Magnitude spectrum : " );
xlabel("Frequency (f) ");
ylabel("|Y(f)|");
grid on;

axes(handles.axes2);
plot(fvec,angle(Y));
title( "Phase spectrum : " );
xlabel("Frequency (f) ");
ylabel("|Phase|");
xlim( [1,4] );
grid on;
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear sound;


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
global y fs y_new fvec
h = 1;
y_new = conv(y,h,'same');
n_new = length(y_new);
t_new = linspace(0 , (n_new - 1)/fs , n_new );
Y_new = fftshift( fft(y_new) );
axes(handles.axes4);
plot(t_new,y_new);
title( "Signal in time domain ( Before Noise ) : " );
xlabel("Time (t) ");
ylabel("y");
grid on;
axes(handles.axes7);
plot(fvec,abs(Y_new) );
title( "Magnitude spectrum ( Before Noise ) : " );
xlabel("Frequency (f) ");
ylabel("|Y(f)|");
grid on;
axes(handles.axes8);
plot(fvec,angle(Y_new) );
title( "Phase spectrum ( Before Noise ) : " );
xlabel("Frequency (f) ");
ylabel("|Phase|");
xlim( [1,4] );
grid on;
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
global y t fs y_new fvec
h = exp(-2*pi*5000*t);
y_new = conv(y,h,'same');
n_new = length(y_new);
t_new = linspace(0 , ( n_new -1 )/fs , n_new );
Y_new = fftshift( fft(y_new) );
axes(handles.axes4);
plot(t_new,y_new);
title( "Signal in time domain ( Before Noise ) : " );
xlabel("Time (t) ");
ylabel("y");
grid on;
axes(handles.axes7);
plot(fvec,abs(Y_new) );
title( "Magnitude spectrum ( Before Noise ) : " );
xlabel("Frequency (f) ");
ylabel("|Y(f)|");
grid on;
axes(handles.axes8);
plot(fvec,angle(Y_new) );
title( "Phase spectrum ( Before Noise ) : " );
xlabel("Frequency (f) ");
ylabel("|Phase|");
xlim( [1,4] );
grid on;
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
global y t fs y_new fvec
h = exp(-2*pi*1000*t);
y_new = conv(y,h,'same');
t_new = linspace(0 , ( length(y_new)-1 )/fs , length(y_new) );
Y_new = fftshift( fft(y_new) );
axes(handles.axes4);
plot(t_new,y_new);
title( "Signal in time domain ( Before Noise ) : " );
xlabel("Time (t) ");
ylabel("y");
grid on;
axes(handles.axes7);
plot(fvec,abs(Y_new) );
title( "Magnitude spectrum ( Before Noise ) : " );
xlabel("Frequency (f) ");
ylabel("|Y(f)|");
grid on;
axes(handles.axes8);
plot(fvec,angle(Y_new) );
title( "Phase spectrum ( Before Noise ) : " );
xlabel("Frequency (f) ");
ylabel("|Phase|");
xlim( [1,4] );
grid on;
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5


% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
global y t fs y_new fvec
h = sinc(2*3000*t); 
y_new = conv(y,h,'same');
t_new = linspace(0 , ( length(y_new)-1 )/fs , length(y_new) );
Y_new = fftshift( fft(y_new) );
axes(handles.axes4);
plot(t_new,y_new);
title( "Signal in time domain ( Before Noise ) : " );
xlabel("Time (t) ");
ylabel("y");
grid on;
axes(handles.axes7);
plot(fvec,abs(Y_new) );
title( "Magnitude spectrum ( Before Noise ) : " );
xlabel("Frequency (f) ");
ylabel("|Y(f)|");
grid on;
axes(handles.axes8);
plot(fvec,angle(Y_new) );
title( "Phase spectrum ( Before Noise ) : " );
xlabel("Frequency (f) ");
ylabel("|Phase|");
xlim( [1,4] );
grid on;
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6

% --- Executes on button press in radiobutton7.

% hObject    handle to radiobutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton7


% --- Executes on button press in radiobutton9.
function radiobutton9_Callback(hObject, eventdata, handles)
global y t fs y_new fvec
Ts = 1/fs;
n = length(y);
h = [2 zeros(1,1/Ts) 1 ];
y_new = conv(y,h,'same');
t_new = linspace(0 , ( length(y_new)-1 )/fs , length(y_new) );
Y_new = fftshift( fft(y_new) );
axes(handles.axes4);
plot(t_new,y_new);
title( "Signal in time domain ( Before Noise ) : " );
xlabel("Time (t) ");
ylabel("y");
grid on;
axes(handles.axes7);
plot(fvec,abs(Y_new) );
title( "Magnitude spectrum ( Before Noise ) : " );
xlabel("Frequency (f) ");
ylabel("|Y(f)|");
grid on;
axes(handles.axes8);
plot(fvec,angle(Y_new) );
title( "Phase spectrum ( Before Noise ) : " );
xlabel("Frequency (f) ");
ylabel("|Phase|");
xlim( [1,4] );
grid on;

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
global y_new fs y fvec Distorted_Signal
clear sound;
n_new = size(y_new);
segma = str2double( inputdlg("Enter the value of standard deviation : ")) ;
Z_noise = segma * randn(n_new);
Distorted_Signal = y_new + Z_noise;
sound(Distorted_Signal , fs);
n_Distorted = length(Distorted_Signal);
t_new= linspace(0 , (n_Distorted-1)/fs , n_Distorted );
Y_new = fftshift( fft(Distorted_Signal) );
axes(handles.axes4);
plot(t_new,Distorted_Signal);
title( "Signal in time domain ( After Noise ) : " );
xlabel("Time (t) ");
ylabel("y");
grid on;
axes(handles.axes7);
plot(fvec,abs(Y_new) );
title( "Magnitude spectrum ( After Noise ) : " );
xlabel("Frequency (f) ");
ylabel("|Y(f)|");
grid on;
axes(handles.axes8);
plot(fvec,angle(Y_new) );
title( "Phase spectrum ( After Noise ) : " );
xlabel("Frequency (f) ");
ylabel("|Phase|");
xlim( [1,4] );
grid on;

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
arrayfun(@(ax) cla(ax, 'reset'), findall(gcf, 'type', 'axes')); % Clears the axes
clear all;
clc;
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% hObject    handle to radiobutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton9



% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
global fs Distorted_Signal fvec
F_cutoff = 3400;
N = length(Distorted_Signal);
filterd_samples = round(1 + (N/fs)*(0.5*fs - F_cutoff));
unfiltered_samples = round(1 + (N/fs)*(2*F_cutoff));
start_idx = filterd_samples + 1 + unfiltered_samples;
start_idx = max(1, min(start_idx, N));  % clamp within array
YT = fftshift( fft( Distorted_Signal ) );
Distorted_Signal = real( ifft( ifftshift( YT ) ) );
YT(1:filterd_samples) = 0;
YT(start_idx:end) = 0;

axes(handles.axes15);
t_new = linspace(0,( length(Distorted_Signal)-1 )/fs , length( Distorted_Signal ) );
plot(t_new,Distorted_Signal);
title( "Signal in time domain : " );
xlabel("Time (t) ");
ylabel("y");
grid on;
axes(handles.axes10);
plot(fvec,abs(YT) );
title( "Magnitude spectrum : " );
xlabel("Frequency (f) ");
ylabel("|Y(f)|");
grid on;
axes(handles.axes11);
plot(fvec,angle(YT) );
title( "Phase spectrum : " );
xlabel("Frequency (f) ");
ylabel("|Phase|");
xlim( [1,4] );
grid on;
sound(Distorted_Signal,fs);
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
close all;
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
