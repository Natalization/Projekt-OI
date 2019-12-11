function varargout = MainMenu(varargin)

% Last Modified by GUIDE v2.5 18-Oct-2019 10:21:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MainMenu_OpeningFcn, ...
                   'gui_OutputFcn',  @MainMenu_OutputFcn, ...
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


% --- Executes just before MainMenu is made visible.
function MainMenu_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for MainMenu
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
movegui('center')

%setting background picture
ah = axes('unit', 'normalized', 'position', [0 0 1 1]);
bg = imread('bcimage.jpg');
imagesc(bg)
set(ah, 'handlevisibility', 'off', 'visible', 'off')

% --- Outputs from this function are returned to the command line.
function varargout = MainMenu_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1_newpatient.
function pushbutton1_newpatient_Callback(hObject, eventdata, handles)
NewPatient;
close(MainMenu)

% --- Executes on button press in pushbutton2_patients.
function pushbutton2_patients_Callback(hObject, eventdata, handles)
Patients;
close(MainMenu)
