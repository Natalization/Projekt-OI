function [ID] = getID(Name,Surname)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
nameLetters =convertStringsToChars(upper(Name));
SurnameLetters = convertStringsToChars(upper(Surname));

number = round(rand(1)*1000);
numberstr = num2str(number);

ID = ([nameLetters(1:3) SurnameLetters(1:3) numberstr]) %%convertCharsToStrings([nameLetters(1:3) SurnameLetters(1:3) numberstr]);
end

