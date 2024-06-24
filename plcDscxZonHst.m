%
% Histogram generation for zones (focii) with program focxh taking a list
% of bounding boxes as input. See script runFocxh.m for the example.
%
% PREVIOUS  plcDscx.m
% CURRENT   plcDscxZonHst.m
% NEXT      plcMtcZonHst.m
%
clear;
run('../globalsSB');

dirImg      = 'Imgs/';
dirDsc      = 'Desc/';             
dirFoc      = 'Focii/';

% change to window backslash
%dirDsc      = u_PathToBackSlash( dirDsc ); 
%dirFoc      = u_PathToBackSlash( dirFoc ); 

%% -----  List of Images  -----
aImg        = dir([dirImg '*.jpg']);
nImg        = length(aImg);
% obtain image size
Irgb        = imread([dirImg aImg(1).name]);
szI         = size(Irgb);

%% -----  Generate Zones Bboxes  -----
ZonesAll    = u_ZonesBboxes(szI, 0);
%Bboxes     = Zones.HorzOla;
ZonesSel    = ZonesAll.Sep3.Vert;

bbxf        = 'BboxZones.txt';
SaveBboxL(bbxf, ZonesSel.Bbox );

%% ----------   Focus Extraction Per Image  -----------
nZon    = ZonesSel.nZon;
optS    = '';
for i = 1:nImg
    imgNam  = aImg(i).name(1:end-4);
    pthVec 	= [dirDsc imgNam '.vec']; % vector file name 
    pthHst  = [dirFoc imgNam '_FH'];
     
    cmd   	= [ FipaExe.focxhL ' ' pthVec ' ' bbxf ' ' pthHst];
    [sts Out] = dos(cmd);      % excecute program

    fprintf('.');
    
end

% we need to inform plcMtcZon.m how many zones were run:
save('PrmHst','nZon'); 
fprintf('fertig.');





