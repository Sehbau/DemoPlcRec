%
% Descriptor extraction for regionwise matching, called zones here.
% Zones are generic image partitions as in spatial histogramming.
%
% Run first the script plcDscx.m to extract the descriptors.
%
% PREVIOUS  plcDscx.m
% CURRENT   plcDscxZon.m
% NEXT      plcMtcZon.m
%
clear;

progFocxv1  = '..\FocExtr\focxv1';
progFocxh1  = '..\FocExtr\focxh1';
dirImg      = 'Imgs/';
dirDsc      = 'Desc\';          % windows backslash
dirFoc      = 'Focii\';

%% -----  Utility Scripts  -----
addpath('../UtilMb/');
addpath('../MtchVec/UtilMb/');
u_AddPathAll('..');

%% -----  List of Images  -----
aImg        = dir([dirImg '*.jpg']);
nImg        = length(aImg);
% obtain image size:
Irgb        = imread([dirImg aImg(1).name]);
szI         = size(Irgb);

%% -----  Generate Zones Bboxes  -----
Zones       = u_ZonesBboxes(szI);
%SaveBboxL('BboxFocii.txt', SBbox.Vert);
%Bboxes     = Zones.HorzOla;
Bboxes      = Zones.HorzSep3;

%% ----------   Focus Extraction Per Image  -----------
nZon    = size(Bboxes,1);
optS    = '';
for i = 1:nImg
    imgNam  = aImg(i).name(1:end-4);
    vecf 	= [dirDsc imgNam '.vec']; % vector file name 
    for f = 1:nZon
        Bbx     = Bboxes(f,:);
        strBbx  = sprintf('%d %d %d %d', Bbx(1), Bbx(2), Bbx(3), Bbx(4));
        outf    = [dirFoc imgNam '_F' num2str(f)];
        
        % -----  Vectors:
        cmd   	= [progFocxv1 ' ' vecf ' ' strBbx ' ' outf];
        [Sts OutFocv] = dos(cmd);      % excecute program
        %OutFocv

        % -----  Histograms:
        cmd   	= [progFocxh1 ' ' vecf ' ' strBbx ' ' outf];
        [Sts OutFoch] = dos(cmd);      % excecute program
        fprintf('.');
    end
end

% we need to inform plcMtcZon.m how many zones were run:
save('Prm','nZon'); 
fprintf('fertig.');




