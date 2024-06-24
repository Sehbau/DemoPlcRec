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
run('../globalsSB');
cd( PthProg.plcRec );

dirImg      = 'Imgs/';
dirDsc      = 'Desc/';              

dirDsc      = u_PathToBackSlash( dirDsc ); % change to window backslash

%% -----  List of Images  -----
aImg    = dir([dirImg '*.jpg']);
nImg    = length(aImg);

%% ----------   Descriptor Extraction   ----------
optS    = '--noBbox --noBon';   % we dont need boundaries & their bboxes
optS    = ['Params/PrmDesc_Gerust.txt ' optS]; % modify parameters for place rec.
for i = 1:nImg
    
    imgNam  = aImg(i).name;
    outNam  = aImg(i).name(1:end-4);
    
    pthImg 	= [dirImg imgNam];      % image path
    pthOut	= [dirDsc outNam];      % output file name 
    cmnd   	= [FipaExe.dscx ' ' pthImg ' ' pthOut ' ' optS];
    [sts OutDscx] = dos(cmnd);       % excecute program
    %OutDscx
    fprintf('.');
    
end


