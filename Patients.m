function varargout = Patients(varargin)
% Last Modified by GUIDE v2.5 05-Dec-2019 20:12:52

% Begin initialization code - DO NOT EDIT
global DATA;

if (~isstruct(DATA))
    DATA = struct('name',' ', ...
        'surname', ' ', ...
        'dateOfBirth', ' ', ...
        'gender', 0,...
        'mass', 0, ...
        'height', 0);
    
end

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Patients_OpeningFcn, ...
                   'gui_OutputFcn',  @Patients_OutputFcn, ...
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

% --- Executes just before Patients is made visible.
function Patients_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
guidata(hObject, handles);
movegui('center')

ah = axes('unit', 'normalized', 'position', [0 0 1 1]);
bg = imread('bcimage3.jpg');
imagesc(bg)
set(ah, 'handlevisibility', 'off', 'visible', 'off')

% % % % % % Importing data % % % % % % % %
data1 = importdata('PatientData.txt');
data2 = table2array(data1(:, 1:4));
set(handles.uitable1, 'Data', data2(: , 1:4));

% --- Outputs from this function are returned to the command line.
function varargout = Patients_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1_add.
function pushbutton1_add_Callback(hObject, eventdata, handles)
NewMeasurement;
close(Patients)

% --- Executes on button press in pushbutton2_stats.
function pushbutton2_stats_Callback(hObject, eventdata, handles)
Statistics;
close(Patients)

% --- Executes on button press in pushbutton3_back.
function pushbutton3_back_Callback(hObject, eventdata, handles)
MainMenu;
close(Patients)


% --- Executes when selected cell(s) is changed in uitable1.
function uitable1_CellSelectionCallback(hObject, eventdata, handles)

 if ~isempty(eventdata.Indices)   
handles.currentCell = eventdata.Indices;
guidata(gcf, handles);
handles = guidata(gcf);
Indices = handles.currentCell
data = get(handles.uitable1,'Data');
dataID = data(Indices(1),1); %%TRY CATCH? 
name = data(Indices(1),2);
surname = data(Indices(1), 3);

global PATIENT
PATIENT.ID = dataID{1,1}
PATIENT.name = name{1,1}
PATIENT.surname = surname{1,1}

set(findobj('Tag', 'pushbutton1_add'), 'enable', 'on')
set(findobj('Tag', 'pushbutton2_stats'), 'enable', 'on')
 end
