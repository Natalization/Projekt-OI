function varargout = Statistics(varargin)
% Last Modified by GUIDE v2.5 05-Dec-2019 20:42:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Statistics_OpeningFcn, ...
                   'gui_OutputFcn',  @Statistics_OutputFcn, ...
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


% --- Executes just before Statistics is made visible.
function Statistics_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
movegui('center')

ah = axes('unit', 'normalized', 'position', [0 0 1 1]);
bg = imread('bcimage6.jpg');
imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom')

global PATIENT

set(findobj('Tag', 'edit_name'), 'String', PATIENT.name);
set(findobj('Tag', 'edit2_surname'), 'String', PATIENT.surname);

data1 = importdata('Measure.txt');
getPatientData = data1(strcmp(data1.ID, PATIENT.ID), {'Mass', 'BMI','BMR', 'DCI', 'Fat', 'Protein', 'Carbs'});
data2 = table2array(getPatientData);

if ~isempty(data2)
    set(findobj('Tag', 'pushbutton_plot'), 'Enable', 'on');
end


set(handles.uitable1, 'Data', data2);



% --- Outputs from this function are returned to the command line.
function varargout = Statistics_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1_back.
function pushbutton1_back_Callback(hObject, eventdata, handles)
Patients;
close(Statistics);


function edit_name_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit_name_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit2_surname_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit2_surname_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function uitable1_CreateFcn(hObject, eventdata, handles)

% --- Executes on button press in pushbutton_plot.
function pushbutton_plot_Callback(hObject, eventdata, handles)
DrawStatistics;

function edit_meanMass_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit_meanMass_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_meanBMI_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit_meanBMI_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_massinfo_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit_massinfo_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_bmiinfo_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit_bmiinfo_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_st_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit_st_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_stBMI_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit_stBMI_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function DrawStatistics
global PATIENT

dataBase = importdata('Measure.txt');
PatientData = dataBase(strcmp(dataBase.ID, PATIENT.ID), {'Mass','BMI', 'BMR'});
range = size(PatientData);
mass = str2num(cell2mat(PatientData.Mass(:,1)));
BMI = cell2mat(PatientData.BMI(:,1));

set(findobj('Tag', 'axes1'), 'Color', 'white')
massAxes = findobj('Tag', 'axes1');
BMIAxes = findobj('Tag', 'axes2');

% % % % % % % % % % %  Plotting % % % % % % % % % % % 
t = 1:range(1);

    axes(massAxes)
    line(t, mass(t), 'Color','red','LineStyle','-', 'LineWidth',2); % line instead of plot to keep axes white
    grid on;
    set(massAxes, 'Tag');
    legend('Mass')

    axes(BMIAxes)
    line(t, BMI(t), 'Color','green','LineStyle','-', 'LineWidth',2); 
    grid on;
    set(BMIAxes, 'Tag');
    legend('BMI')
    
% % % % % % statistics % % % % % % % %
  meanMass = round(mean(mass),2);
  meanBMI = round(mean(BMI),2);
  sdMass = round(std(mass),2);
  sdBMI = round(std(BMI),2);
  
  set(findobj('Tag', 'edit_meanMass'), 'String', meanMass);
  set(findobj('Tag', 'edit_meanBMI'), 'String', meanBMI);
  set(findobj('Tag', 'edit_st'), 'String', sdMass);
 set(findobj('Tag', 'edit_stBMI'), 'String', sdBMI);
if BMI(end, end) < 18.5
    txt = {'Patient is currently', 'in the underweight range'};
    set(findobj('Tag', 'text4'), 'String', txt);
    
elseif BMI(end, end) >= 18.5 && BMI(end, end) < 24.9
    txt = {'Patient is currently','in the healthy weight range'};
    set(findobj('Tag', 'text4'), 'String', txt);   
    
elseif BMI(end, end) >= 24.9 && BMI(end, end) < 29.9
     txt = {'Patient is currently',' in the overweight range'};
     set(findobj('Tag', 'text4'), 'String', txt);
     
elseif BMI(end, end) >= 29.9 && BMI(end, end) < 39.9  
    txt = {'Patient is currently', 'in the obese range'};
     set(findobj('Tag', 'text4'), 'String', txt);
     
else
    txt = {'Patient is currently', 'in the extreme obese range'};
    set(findobj('Tag', 'text4'), 'String', txt);
end

% % % % % % Progress info % % % % % % % % 
pMass = polyfit(t',mass(t),1);
a = pMass(1);
if a > 0
    set(findobj('Tag', 'edit_massinfo'), 'String', 'Weight has increased');
elseif a == 0
    set(findobj('Tag', 'edit_massinfo'), 'String', 'Weight has not changed');
else
    set(findobj('Tag', 'edit_massinfo'), 'String', 'Weight has decreased');
end


