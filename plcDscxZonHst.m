%
% Histogram generation for zones (focii) with program focxh taking a list
% of bounding boxes as input. See script runFocxh.m for the example.
%
% PREVIOUS  plcDscx.m
% CURRENT   plcDscxZonHst.m
% NEXT      plcMtcZonHst.m
%
clear;

progFocxh   = '..\FocExtr\focxhL';  % without '1'
dirImg      = 'Imgs/';
dirDsc      = 'Desc\';              % windows backslash
dirFoc      = 'Focii\';

addpath('../UtilMb/');
%addpath('../MtchVec/UtilMb/');
u_AddPathAll('..');

%% -----  List of Images  -----
aImg        = dir([dirImg '*.jpg']);
nImg        = length(aImg);
% obtain image size
Irgb        = imread([dirImg aImg(1).name]);
szI         = size(Irgb);

%% -----  Generate Zones Bboxes  -----
Zones       = u_ZonesBboxes(szI);
%Bboxes     = Zones.HorzOla;
Bboxes      = Zones.HorzSep3;

bbxf        = 'BboxZones.txt';
SaveBboxL(bbxf, Bboxes);

%% ----------   Focus Extraction Per Image  -----------
nZon    = size(Bboxes,1);
optS    = '';
for i = 1:nImg
    imgNam  = aImg(i).name(1:end-4);
    vecfV 	= [dirDsc imgNam '.vec']; % vector file name 
    outfH   = [dirFoc imgNam '_FH'];
     
    cmd   	= [progFocxh ' ' vecfV ' ' bbxf ' ' outfH];
    [Sts Out] = dos(cmd);      % excecute program

    fprintf('.');
    
end

% we need to inform plcMtcZon.m how many zones were run:
save('PrmHst','nZon'); 
fprintf('fertig.');





