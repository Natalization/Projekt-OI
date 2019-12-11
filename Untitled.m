%% wyr reg do imienia i nazwiska
str = 'wyleøo≥'
expression = '^[A•BC∆DE FGHIJKL£MN—O”PRSåTUWYZèØ]{1}[aπbcÊdeÍfghijkl≥mnÒoÛprsútuwyzüø]{1,30}$'
%%expression = '^[A-Z]{1}[a-z]{1,30}$';
startIndex = regexp(str,expression)
if isempty(startIndex)
   errordlg("Hello motherfucker") 
end

%% wyr reg do daty

str = '01-14-2010 '
expression = '^(((0)[1-9])|[1-2][0-9]|(3)[0-1])-(((0)[0-9])|((1)[0-2]))-(((1)(9)[0-9]{2})|((2)(0)[0-9]{2}))$';
startIndex = regexp(str,expression)

%% wyr reg dla masy
str = '10'
expression = '^([1-9][0-9])$';
startIndex = regexp(str,expression)

%% wyr reg dla wzrostu
str = '2'
expression = '^((1)[0-9]{2}|(2)[0-2][0-9])$';
startIndex = regexp(str,expression)