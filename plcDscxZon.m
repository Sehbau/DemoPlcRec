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
run('../globalsSB');

dirImg      = 'Imgs/';
dirDsc      = 'Desc/';
dirFoc      = 'Focii/';

% change to window backslash
%dirDsc      = u_PathToBackSlash( dirDsc ); % not necessary I think
dirFoc      = u_PathToBackSlash( dirFoc ); 

%% -----  List of Images  -----
aImg        = dir( [dirImg '*.jpg'] );
nImg        = length(aImg);
% obtain image size:
Irgb        = imread([dirImg aImg(1).name]);
szI         = size(Irgb);

%% -----  Generate Zones Bboxes  -----
ZonesAll    = u_ZonesBboxes(szI, 0);
%SaveBboxL('BboxFocii.txt', SBbox.Vert);
ZonesSel    = ZonesAll.Sep3.Vert;

%% ----------   Focus Extraction Per Image  -----------
nZon    = ZonesSel.nZon;
optS    = '';
for i = 1:nImg
    imgNam  = aImg(i).name(1:end-4);
    vecf 	= [dirDsc imgNam '.vec']; % vector file name 
    for f = 1:nZon
        Bbx     = ZonesSel.Bbox(f,:);
        strBbx  = sprintf('%d %d %d %d', Bbx(1), Bbx(2), Bbx(3), Bbx(4));
        outf    = [dirFoc imgNam '_F' num2str(f)];
        
        % -----  Vectors:
        cmnd   	= [FipaExe.focxv1 ' ' vecf ' ' strBbx ' ' outf];
        [Sts OutFocv] = dos(cmnd);     % excecute program
        %OutFocv

        % -----  Histograms:
        cmnd   	= [FipaExe.focxh1 ' ' vecf ' ' strBbx ' ' outf];
        [Sts OutFoch] = dos(cmnd);     % excecute program
        fprintf('.');
    end
end

% we need to inform plcMtcZon.m how many zones were run:
save('Prm','nZon'); 
fprintf('fertig.');




