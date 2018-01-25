function varargout = lucyGUI(varargin)
% LUCYGUI MATLAB code for lucyGUI.fig
%      LUCYGUI, by itself, creates a new LUCYGUI or raises the existing
%      singleton*.
%
%      H = LUCYGUI returns the handle to a new LUCYGUI or the handle to
%      the existing singleton*.
%
%      LUCYGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LUCYGUI.M with the given input arguments.
%
%      LUCYGUI('Property','Value',...) creates a new LUCYGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before lucyGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to lucyGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help lucyGUI

% Last Modified by GUIDE v2.5 15-Nov-2016 01:36:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lucyGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @lucyGUI_OutputFcn, ...
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


% --- Executes just before lucyGUI is made visible.
function lucyGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to lucyGUI (see VARARGIN)

% Choose default command line output for lucyGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes lucyGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

imageLucy=imread('model.jpg');
axes(handles.picLucy);
imshow(imageLucy);

set(handles.d_tfj,'String','0')
set(handles.d_tsj,'String','0')
set(handles.d_lhfj,'String','0')
set(handles.d_lhsj,'String','0')
set(handles.d_lhvj,'String','0')
set(handles.d_lkj,'String','0')
set(handles.d_lafj,'String','0')
set(handles.d_lasj,'String','0')
set(handles.d_rhfj,'String','0')
set(handles.d_rhsj,'String','0')
set(handles.d_rhvj,'String','0')
set(handles.d_rkj,'String','0')
set(handles.d_rafj,'String','0')
set(handles.d_rasj,'String','0')

[lucyID, vrep] = setupConnection;
if (lucyID > -1)
    vrep.simxAddStatusbarMessage(lucyID,'Hello V-REP!',vrep.simx_opmode_oneshot);
    disp('Connected to remote API server');
    lucyJoints = getJointHandles(lucyID, vrep);
    initializeJointAngles(lucyID, vrep,lucyJoints);
%    initializeJointForces(lucyID, vrep,lucyJoints);
else
    disp('Failed connecting to remote API server');
end
assignin('base','lucyID',lucyID);
assignin('base','vrep',vrep);
assignin('base','lucyJoints',lucyJoints);

% --- Outputs from this function are returned to the command line.
function varargout = lucyGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
global running;
running=1;
lucyID=evalin('base','lucyID');
vrep=evalin('base','vrep');
lucyJoints=evalin('base','lucyJoints');
currentAngles=zeros(1,14);
while running
    for index=1:1:14
        currentAngles(index)=round(getJointAngle(lucyID,vrep,lucyJoints(index)));
    end
    set(handles.a_tfj,'String',num2str(currentAngles(1)))
    set(handles.a_tsj,'String',num2str(currentAngles(2)))
    set(handles.a_lhfj,'String',num2str(currentAngles(3)))
    set(handles.a_lhsj,'String',num2str(currentAngles(4)))
    set(handles.a_lhvj,'String',num2str(currentAngles(5)))
    set(handles.a_lkj,'String',num2str(currentAngles(6)))
    set(handles.a_lafj,'String',num2str(currentAngles(7)))
    set(handles.a_lasj,'String',num2str(currentAngles(8)))
    set(handles.a_rhfj,'String',num2str(currentAngles(9)))
    set(handles.a_rhsj,'String',num2str(currentAngles(10)))
    set(handles.a_rhvj,'String',num2str(currentAngles(11)))
    set(handles.a_rkj,'String',num2str(currentAngles(12)))
    set(handles.a_rafj,'String',num2str(currentAngles(13)))
    set(handles.a_rasj,'String',num2str(currentAngles(14)))    
    pause(1);
end

function a_tfj_Callback(hObject, eventdata, handles)
% hObject    handle to a_tfj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a_tfj as text
%        str2double(get(hObject,'String')) returns contents of a_tfj as a double


% --- Executes during object creation, after setting all properties.
function a_tfj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a_tfj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a_tsj_Callback(hObject, eventdata, handles)
% hObject    handle to a_tsj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a_tsj as text
%        str2double(get(hObject,'String')) returns contents of a_tsj as a double


% --- Executes during object creation, after setting all properties.
function a_tsj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a_tsj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a_rasj_Callback(hObject, eventdata, handles)
% hObject    handle to a_rasj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a_rasj as text
%        str2double(get(hObject,'String')) returns contents of a_rasj as a double


% --- Executes during object creation, after setting all properties.
function a_rasj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a_rasj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a_rafj_Callback(hObject, eventdata, handles)
% hObject    handle to a_rafj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a_rafj as text
%        str2double(get(hObject,'String')) returns contents of a_rafj as a double


% --- Executes during object creation, after setting all properties.
function a_rafj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a_rafj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a_rkj_Callback(hObject, eventdata, handles)
% hObject    handle to a_rkj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a_rkj as text
%        str2double(get(hObject,'String')) returns contents of a_rkj as a double


% --- Executes during object creation, after setting all properties.
function a_rkj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a_rkj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a_rhvj_Callback(hObject, eventdata, handles)
% hObject    handle to a_rhvj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a_rhvj as text
%        str2double(get(hObject,'String')) returns contents of a_rhvj as a double


% --- Executes during object creation, after setting all properties.
function a_rhvj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a_rhvj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a_rhsj_Callback(hObject, eventdata, handles)
% hObject    handle to a_rhsj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a_rhsj as text
%        str2double(get(hObject,'String')) returns contents of a_rhsj as a double


% --- Executes during object creation, after setting all properties.
function a_rhsj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a_rhsj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a_rhfj_Callback(hObject, eventdata, handles)
% hObject    handle to a_rhfj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a_rhfj as text
%        str2double(get(hObject,'String')) returns contents of a_rhfj as a double


% --- Executes during object creation, after setting all properties.
function a_rhfj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a_rhfj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a_lasj_Callback(hObject, eventdata, handles)
% hObject    handle to a_lasj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a_lasj as text
%        str2double(get(hObject,'String')) returns contents of a_lasj as a double


% --- Executes during object creation, after setting all properties.
function a_lasj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a_lasj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a_lafj_Callback(hObject, eventdata, handles)
% hObject    handle to a_lafj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a_lafj as text
%        str2double(get(hObject,'String')) returns contents of a_lafj as a double


% --- Executes during object creation, after setting all properties.
function a_lafj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a_lafj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a_lkj_Callback(hObject, eventdata, handles)
% hObject    handle to a_lkj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a_lkj as text
%        str2double(get(hObject,'String')) returns contents of a_lkj as a double


% --- Executes during object creation, after setting all properties.
function a_lkj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a_lkj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a_lhvj_Callback(hObject, eventdata, handles)
% hObject    handle to a_lhvj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a_lhvj as text
%        str2double(get(hObject,'String')) returns contents of a_lhvj as a double


% --- Executes during object creation, after setting all properties.
function a_lhvj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a_lhvj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a_lhsj_Callback(hObject, eventdata, handles)
% hObject    handle to a_lhsj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a_lhsj as text
%        str2double(get(hObject,'String')) returns contents of a_lhsj as a double


% --- Executes during object creation, after setting all properties.
function a_lhsj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a_lhsj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a_lhfj_Callback(hObject, eventdata, handles)
% hObject    handle to a_lhfj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a_lhfj as text
%        str2double(get(hObject,'String')) returns contents of a_lhfj as a double


% --- Executes during object creation, after setting all properties.
function a_lhfj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a_lhfj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function d_tfj_Callback(hObject, eventdata, handles)
% hObject    handle to d_tfj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d_tfj as text
%        str2double(get(hObject,'String')) returns contents of d_tfj as a double


% --- Executes during object creation, after setting all properties.
function d_tfj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d_tfj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function d_tsj_Callback(hObject, eventdata, handles)
% hObject    handle to d_tsj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d_tsj as text
%        str2double(get(hObject,'String')) returns contents of d_tsj as a double


% --- Executes during object creation, after setting all properties.
function d_tsj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d_tsj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function d_rasj_Callback(hObject, eventdata, handles)
% hObject    handle to d_rasj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d_rasj as text
%        str2double(get(hObject,'String')) returns contents of d_rasj as a double


% --- Executes during object creation, after setting all properties.
function d_rasj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d_rasj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function d_rafj_Callback(hObject, eventdata, handles)
% hObject    handle to d_rafj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d_rafj as text
%        str2double(get(hObject,'String')) returns contents of d_rafj as a double


% --- Executes during object creation, after setting all properties.
function d_rafj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d_rafj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function d_rkj_Callback(hObject, eventdata, handles)
% hObject    handle to d_rkj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d_rkj as text
%        str2double(get(hObject,'String')) returns contents of d_rkj as a double


% --- Executes during object creation, after setting all properties.
function d_rkj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d_rkj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function d_rhvj_Callback(hObject, eventdata, handles)
% hObject    handle to d_rhvj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d_rhvj as text
%        str2double(get(hObject,'String')) returns contents of d_rhvj as a double


% --- Executes during object creation, after setting all properties.
function d_rhvj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d_rhvj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function d_rhsj_Callback(hObject, eventdata, handles)
% hObject    handle to d_rhsj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d_rhsj as text
%        str2double(get(hObject,'String')) returns contents of d_rhsj as a double


% --- Executes during object creation, after setting all properties.
function d_rhsj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d_rhsj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function d_rhfj_Callback(hObject, eventdata, handles)
% hObject    handle to d_rhfj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d_rhfj as text
%        str2double(get(hObject,'String')) returns contents of d_rhfj as a double


% --- Executes during object creation, after setting all properties.
function d_rhfj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d_rhfj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function d_lasj_Callback(hObject, eventdata, handles)
% hObject    handle to d_lasj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d_lasj as text
%        str2double(get(hObject,'String')) returns contents of d_lasj as a double


% --- Executes during object creation, after setting all properties.
function d_lasj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d_lasj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function d_lafj_Callback(hObject, eventdata, handles)
% hObject    handle to d_lafj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d_lafj as text
%        str2double(get(hObject,'String')) returns contents of d_lafj as a double


% --- Executes during object creation, after setting all properties.
function d_lafj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d_lafj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function d_lkj_Callback(hObject, eventdata, handles)
% hObject    handle to d_lkj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d_lkj as text
%        str2double(get(hObject,'String')) returns contents of d_lkj as a double


% --- Executes during object creation, after setting all properties.
function d_lkj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d_lkj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function d_lhvj_Callback(hObject, eventdata, handles)
% hObject    handle to d_lhvj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d_lhvj as text
%        str2double(get(hObject,'String')) returns contents of d_lhvj as a double


% --- Executes during object creation, after setting all properties.
function d_lhvj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d_lhvj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function d_lhsj_Callback(hObject, eventdata, handles)
% hObject    handle to d_lhsj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d_lhsj as text
%        str2double(get(hObject,'String')) returns contents of d_lhsj as a double


% --- Executes during object creation, after setting all properties.
function d_lhsj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d_lhsj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function d_lhfj_Callback(hObject, eventdata, handles)
% hObject    handle to d_lhfj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d_lhfj as text
%        str2double(get(hObject,'String')) returns contents of d_lhfj as a double


% --- Executes during object creation, after setting all properties.
function d_lhfj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d_lhfj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in moveJoints.
function moveJoints_Callback(hObject, eventdata, handles)
% hObject    handle to moveJoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
lucyID=evalin('base','lucyID');
vrep=evalin('base','vrep');
lucyJoints=evalin('base','lucyJoints');
str=get(handles.d_tfj, 'string');
moveJoint(lucyID, vrep, lucyJoints(1), str2double(str));
str=get(handles.d_tsj, 'string');
moveJoint(lucyID, vrep, lucyJoints(2), str2double(str));
str=get(handles.d_lhfj, 'string');
moveJoint(lucyID, vrep, lucyJoints(3), str2double(str));
str=get(handles.d_lhsj, 'string');
moveJoint(lucyID, vrep, lucyJoints(4), str2double(str));
str=get(handles.d_lhvj, 'string');
moveJoint(lucyID, vrep, lucyJoints(5), str2double(str));
str=get(handles.d_lkj, 'string');
moveJoint(lucyID, vrep, lucyJoints(6), str2double(str));
str=get(handles.d_lafj, 'string');
moveJoint(lucyID, vrep, lucyJoints(7), str2double(str));
str=get(handles.d_lasj, 'string');
moveJoint(lucyID, vrep, lucyJoints(8), str2double(str));
str=get(handles.d_rhfj, 'string');
moveJoint(lucyID, vrep, lucyJoints(9), str2double(str));
str=get(handles.d_rhsj, 'string');
moveJoint(lucyID, vrep, lucyJoints(10), str2double(str));
str=get(handles.d_rhvj, 'string');
moveJoint(lucyID, vrep, lucyJoints(11), str2double(str));
str=get(handles.d_rkj, 'string');
moveJoint(lucyID, vrep, lucyJoints(12), str2double(str));
str=get(handles.d_rafj, 'string');
moveJoint(lucyID, vrep, lucyJoints(13), str2double(str));
str=get(handles.d_rasj, 'string');
moveJoint(lucyID, vrep, lucyJoints(14), str2double(str));
vrep.simxAddStatusbarMessage(lucyID,'Moving Joints',vrep.simx_opmode_oneshot);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
global running;
running=0;
lucyID=evalin('base','lucyID');
vrep=evalin('base','vrep');
vrep.simxGetPingTime(lucyID);     % Before closing the connection to V-REP, make sure that the last command sent out had time to arrive. You can guarantee this with (for example):
vrep.simxFinish(lucyID);    % Now close the connection to V-REP:    
vrep.delete(); % call the destructor!
disp('Program ended');
delete(hObject);
