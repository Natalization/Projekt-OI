function varargout = NewMeasurement(varargin)

% Last Modified by GUIDE v2.5 23-Oct-2019 22:42:43

% Begin initialization code - DO NOT EDIT
global MEASURE
if (~isstruct(MEASURE))
    MEASURE = struct('BMI', 0, ... 
        'BMR', 0, ...
        'DCI', 0, ...
        'level', 0, ...
        'fat', 0, ...
        'carbs', 0, ...
        'protein', 0);    
end

global PATIENT
if (~isstruct(PATIENT))
    PATIENT = struct( 'ID', '',...
    'name'," ", ...
        'surname', " ", ...        
        'dateOfBirth', "", ... 
        'age', 0, ...
        'gender', '', ...
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
                   'gui_OpeningFcn', @NewMeasurement_OpeningFcn, ...
                   'gui_OutputFcn',  @NewMeasurement_OutputFcn, ...
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


% --- Executes just before NewMeasurement is made visible.
function NewMeasurement_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
movegui('center')

%setting background picture
ah = axes('unit', 'normalized', 'position', [0 0 1 1]);
bg = imread('bcimage3.jpg');
imagesc(bg)
set(ah, 'handlevisibility', 'off', 'visible', 'off')

%importing database and setting data to structure
global PATIENT 
 
db = importdata('PatientData.txt');
getPatientData = db(strcmp(db.ID, PATIENT.ID), {'Name','Surname', 'DateOfBirth', 'Gender'});

PATIENT.name = getPatientData.Name;
PATIENT.surname = getPatientData.Surname;
PATIENT.dateOfBirth = getPatientData.DateOfBirth;
PATIENT.gender = getPatientData.Gender;

todaysdate = split(date, '-');
todaysyear = str2num(cell2mat(todaysdate(3)));
patientyear = split(PATIENT.dateOfBirth, '-');
% try
patientyear = str2num(cell2mat(patientyear(3)));
PATIENT.age = todaysyear - patientyear;
% catch
%     warndlg("Patient hasn't been chosen")   
% end


    
set(findobj('Tag', 'edit_name'), 'String', PATIENT.name);
set(findobj('Tag', 'edit_surname'), 'String', PATIENT.surname);
set(findobj('Tag', 'edit_age'), 'String', num2str(PATIENT.age));

% try
%     a = notaFunction(5,6);
% catch
%     warning('Problem using function.  Assigning a value of 0.');
%     a = 0;
% end


% --- Outputs from this function are returned to the command line.
function varargout = NewMeasurement_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;



function edit_name_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit_name_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    
end



function edit_surname_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit_surname_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_age_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit_age_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit4_mass_Callback(hObject, eventdata, handles)
mass = get(hObject, 'string')
expression = '^([1-9][0-9])$';
startIndex = regexp(mass,expression);
global PATIENT
global CHECK

if isempty(startIndex)    
    warndlg("Enter correct mass value")
    CHECK.mass = false;
else
    PATIENT.mass = mass;
    CHECK.mass = true;

end
if CHECK.height == true && CHECK.mass == true && CHECK.lvl == true 
    set(findobj('Tag', 'pushbutton1_count'), 'enable', 'on')
else
    set(findobj('Tag', 'pushbutton1_count'), 'enable', 'off')
end


% --- Executes during object creation, after setting all properties.
function edit4_mass_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit5_height_Callback(hObject, eventdata, handles)
height = get(hObject, 'string')
expression = '^((1)[0-9]{2}|(2)[0-2][0-9])$';
startIndex = regexp(height,expression);
global PATIENT
global CHECK

if isempty(startIndex)    
    warndlg("Enter correct height value")
    CHECK.height = false;
else
    PATIENT.height = height;
    CHECK.height = true;

end
if CHECK.height == true && CHECK.mass == true && CHECK.lvl == true 
    set(findobj('Tag', 'pushbutton1_count'), 'enable', 'on')
else
    set(findobj('Tag', 'pushbutton1_count'), 'enable', 'off')
end


% --- Executes during object creation, after setting all properties.
function edit5_height_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
global MEASURE
global CHECK
contents = cellstr(get(hObject, 'string'));
choice = contents(get(hObject, 'value'));
if strcmp(choice, 'Sedentary')
    MEASURE.level = 1.4;
    CHECK.lvl = true; 
elseif strcmp(choice, 'Moderately active')
    MEASURE.level = 1.7;
    CHECK.lvl = true;
    elseif strcmp(choice, 'Vigorously active')
        MEASURE.level = 2;
        CHECK.lvl = true;
else
    warndlg('You must choose activity level')
    CHECK.lvl == false;
end 
if CHECK.height == true && CHECK.mass == true && CHECK.lvl == true 
    set(findobj('Tag', 'pushbutton1_count'), 'enable', 'on')
else
    set(findobj('Tag', 'pushbutton1_count'), 'enable', 'off')
end

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_BMI_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit_BMI_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1_count.
function pushbutton1_count_Callback(hObject, eventdata, handles)
Count


function edit_BMR_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit_BMR_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_DCI_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit_DCI_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fat_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit_fat_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_protein_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit_protein_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_carbs_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit_carbs_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2_save.
function pushbutton2_save_Callback(hObject, eventdata, handles)
Save;
Patients;
close(NewMeasurement)

% --- Executes on button press in pushbutton3_back.
function pushbutton3_back_Callback(hObject, eventdata, handles)
% global PATIENT
% PATIENT.ID = '';
% PATIENT.name = '';
% PATIENT.surname = '';
% PATIENT.dateOfBirth = '';
% PATIENT.gender = '';
% 
% global MEASURE
% MEASURE.BMI = '';
% MEASURE.BMR = '';
% MEASURE.DCI = '';
% MEASURE.level = '';
% MEASURE.fat = '';
% MEASURE.carbs = '';
% MEASURE.protein = '';
 
    
global CHECK
CHECK.mass = false;
CHECK.height = false;
CHECK.lvl = false;
Patients;
close(NewMeasurement);


function Count                                                                                                     
global PATIENT
global MEASURE

mass = str2double(PATIENT.mass);
height = str2double(PATIENT.height);

% % % % % % % % % % % % BMI BMR DCI % % % % % % % % % % % % % % 
MEASURE.BMI = round(mass/(height/100)^2, 2);
if PATIENT.gender == "Male"
MEASURE.BMR = round(66.473 + 13.751* mass + 5.0033 * height + 6.755 * PATIENT.age);
elseif PATIENT.gender == "Female"
    MEASURE.BMR = round(655.0955 + 9.5634* mass + 1.8496 * height + 4.6756 * PATIENT.age);
end

MEASURE.DCI = round(MEASURE.BMR * MEASURE.level);

% % % % % % % % % % % % F P C % % % % % % % % % % 
MEASURE.protein = round(1.8 * mass)
proteinkcal = MEASURE.protein * 4;
 
MEASURE.fat = round(1.1 * mass); 
fatkcal = MEASURE.fat * 9;
 
MEASURE.carbs = round((MEASURE.DCI - proteinkcal - fatkcal)/4);

% % % % % % % Displaying counted values % % % % % % % % % % % % % % %
set(findobj('Tag', 'edit_BMI'), 'String', num2str(MEASURE.BMI));
set(findobj('Tag', 'edit_BMR'), 'String', num2str(MEASURE.BMR));
set(findobj('Tag', 'edit_DCI'), 'String', num2str(MEASURE.DCI));
set(findobj('Tag', 'edit_protein'), 'String', num2str(MEASURE.protein));
set(findobj('Tag', 'edit_fat'), 'String', num2str(MEASURE.fat));
set(findobj('Tag', 'edit_carbs'), 'String', num2str(MEASURE.carbs));
set(findobj('Tag', 'pushbutton2_save'), 'enable', 'on')


function Save
global PATIENT
global MEASURE

% % % % % % % % % % % saving data to txt % % % % % % % % % % % % % % % % %
dataLoad = importdata('Measure.txt')
T = table({PATIENT.ID},{PATIENT.mass},{MEASURE.BMI},{MEASURE.BMR},{MEASURE.DCI},{MEASURE.fat}, {MEASURE.carbs}, {MEASURE.protein},...
     'VariableNames',{'ID' 'Mass' 'BMI' 'BMR' 'DCI' 'Fat' 'Carbs' 'Protein'});
if isempty(dataLoad) ==1 %saving the first patient
    save('Measure.txt', 'T');
else
newDatabase = [dataLoad; T];
save('Measure.txt','newDatabase');
end

PATIENT.ID = '';
PATIENT.name = '';
PATIENT.surname = '';
PATIENT.dateOfBirth = '';
PATIENT.gender = '';

MEASURE.BMI = '';
MEASURE.BMR = '';
MEASURE.DCI = '';
MEASURE.level = '';
MEASURE.fat = '';
MEASURE.carbs = '';
MEASURE.protein = '';
   
global CHECK
CHECK.mass = false;
CHECK.height = false;
CHECK.lvl = false;
