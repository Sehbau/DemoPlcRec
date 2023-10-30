%
% Descriptor extraction for place recognition demo. 
% Assumes organization of repositories.
% Run from directory DemoPlcRec/
%
% PREVIOUS  -
% CURRENT   plcDscx.m
% NEXT      plcMtcImg.m
%
clear;
% cd('/DemoPlcRec');                % change to this directory 

progDscx    = '..\DescExtr\dscx';
dirImg      = 'Imgs/';
dirDsc      = 'Desc\';              % windows backslash

addpath('../UtilMb/');

%% -----  List of Images  -----
aImg    = dir([dirImg '*.jpg']);
nImg    = length(aImg);

%% ----------   Descriptor Extraction   ----------
optS    = '--noBbox --noBon';   % we dont need boundaries & their bboxes
for i = 1:nImg
    
    imgNam  = aImg(i).name;
    outNam  = aImg(i).name(1:end-4);
    
    imgf  	= [dirImg imgNam];      % image path
    outf 	= [dirDsc outNam];      % output file name 
    cmd   	= [progDscx ' ' imgf ' ' outf ' ' optS];
    [Sts OutDscx] = dos(cmd);       % excecute program
    %OutDscx
    fprintf('.');
    
end


