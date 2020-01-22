function varargout = NewPatient(varargin)
% Last Modified by GUIDE v2.5 28-Nov-2019 13:30:57

% Begin initialization code - DO NOT EDIT

global PATIENT;

if (~isstruct(PATIENT))
    PATIENT = struct( 'ID', '',...
    'name'," ", ...
        'surname', " ", ...        
        'dateOfBirth', "", ... 
        'age', 0, ...
        'gender', 'Male', ...
        'mass', 0, ... 
        'height', 0);
    
end

global CHECK

if (~isstruct(CHECK))
    CHECK = struct('name', false, ...
        'surname', false, ...        
        'dateOfBirth', false, ...
        'mass', false, ... 
        'height', false, ...
        'lvl', false);
    
end

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NewPatient_OpeningFcn, ...
                   'gui_OutputFcn',  @NewPatient_OutputFcn, ...
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


% --- Executes just before NewPatient is made visible.
function NewPatient_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
movegui('center')

ah = axes('unit', 'normalized', 'position', [0 0 1 1]);
bg = imread('bcimage3.jpg');
imagesc(bg)
set(ah, 'handlevisibility', 'off', 'visible', 'off')

% --- Outputs from this function are returned to the command line.
function varargout = NewPatient_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;



function edit1_name_Callback(hObject, eventdata, handles)
name = get(hObject, 'string')
expression = '^[A•BC∆DE FGHIJKL£MN—O”PRSåTUWYZèØ]{1}[aπbcÊdeÍfghijkl≥mnÒoÛprsútuwyzüø]{1,30}$';
startIndex = regexp(name,expression)
global PATIENT
global CHECK

if isempty(startIndex)
    warndlg("Enter correct name")
else
    PATIENT.name = name;
    CHECK.name = true;
end
if CHECK.name == true && CHECK.surname == true && CHECK.dateOfBirth == true 
    set(findobj('Tag', 'pushbutton1_save'), 'enable', 'on')
else
    set(findobj('Tag', 'pushbutton1_save'), 'enable', 'off')
end


% --- Executes during object creation, after setting all properties.
function edit1_name_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit2_surname_Callback(hObject, eventdata, handles)
surname = get(hObject, 'string')
expression = '^[A•BC∆DE FGHIJKL£MN—O”PRSåTUWYZèØ]{1}[aπbcÊdeÍfghijkl≥mnÒoÛprsútuwyzüø]{1,30}$';
startIndex = regexp(surname,expression)
global PATIENT
global CHECK

if isempty(startIndex)    
    warndlg("Enter correct surname")
    CHECK.surname = false;
else
    PATIENT.surname = surname;
    CHECK.surname = true;

end
if CHECK.name == true && CHECK.surname == true && CHECK.dateOfBirth == true 
    set(findobj('Tag', 'pushbutton1_save'), 'enable', 'on')
else
    set(findobj('Tag', 'pushbutton1_save'), 'enable', 'off')
end

% --- Executes during object creation, after setting all properties.
function edit2_surname_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit3_date_Callback(hObject, eventdata, handles)
date = get(hObject, 'string')
expression = '^(((0)[1-9])|[1-2][0-9]|(3)[0-1])-(((0)[0-9])|((1)[0-2]))-(((1)(9)[0-9]{2})|((2)(0)[0-9]{2}))$';
startIndex = regexp(date,expression)
global PATIENT
global CHECK

if isempty(startIndex)
    
    warndlg("Enter correct date in format dd-mm-yyyy")
else
    PATIENT.dateOfBirth = date;
    CHECK.dateOfBirth = true;

end
if CHECK.name == true && CHECK.surname == true && CHECK.dateOfBirth == true 
    set(findobj('Tag', 'pushbutton1_save'), 'enable', 'on')
else
    set(findobj('Tag', 'pushbutton1_save'), 'enable', 'off')
end

% --- Executes during object creation, after setting all properties.
function edit3_date_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton1_save.
function pushbutton1_save_Callback(hObject, eventdata, handles)
Save

% --- Executes on button press in pushbutton2_back.
function pushbutton2_back_Callback(hObject, eventdata, handles)
global PATIENT
PATIENT.ID = '';
PATIENT.name = '';
PATIENT.surname = '';
PATIENT.dateOfBirth = '';
PATIENT.gender = '';

global CHECK
CHECK.name = false;
CHECK.surname = false;
CHECK.dateOfBirth = false;
MainMenu;
close(NewPatient)

function radiobutton_male_Callback(hObject, eventdata, handles)

function radiobutton_female_Callback(hObject, eventdata, handles)

% % --- Executes when selected object is changed in uibuttongroup_gender.
function uibuttongroup_gender_SelectionChangedFcn(hObject, eventdata, handles)
global PATIENT
switch(get(eventdata.NewValue, 'Tag')) 
    case 'radiobutton_male'
        PATIENT.gender = 'Male'
    case 'radiobutton_female'
        PATIENT.gender = 'Female'
    
end

function Save
global PATIENT

% % % % % % % % Checking correctness % % % % % % % % % % %

PATIENT.ID = getID(PATIENT.name, PATIENT.surname);

 % % %  % % % % % % % % % % Saving data to txt % % % % % % % % % % % % %
T = table({PATIENT.ID},{PATIENT.name},{PATIENT.surname},{PATIENT.dateOfBirth}, {PATIENT.gender},...
    'VariableNames',{'ID' 'Name' 'Surname' 'DateOfBirth' 'Gender'});

dataLoad = importdata('PatientData.txt')
if isempty(dataLoad) == 1
  save('PatientData.txt','T')  
else
newDatabase = [dataLoad; T]
save('PatientData.txt','newDatabase')
end

% % % % % % data reset % % % % % % % %

PATIENT.ID = '';
PATIENT.name = '';
PATIENT.surname = '';
PATIENT.dateOfBirth = '';
PATIENT.gender = '';


Patients;
close(NewPatient)
