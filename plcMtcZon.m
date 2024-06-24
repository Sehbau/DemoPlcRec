%
% Matching zone-wise for both vectors and histograms.
%
% Run first the script plcDscxZon.m to extract the descriptors.
%
% PREVIOUS   plcDscxZon.m
% CURRENT    plcMtcZon.m
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

%% ==========   Zone Matching   ==========
% the combinations:
Comb(1,:) = [1 2];          % most similar      
Comb(2,:) = [1 3];          
Comb(3,:) = [1 4];          
Comb(4,:) = [1 5];          % least similar
Comb(5,:) = [2 5];
nComb     = size(Comb,1);   % number of combinations
load('Prm');                % loads parameter nZon

[DisMes SmlMes] = deal(zeros(nComb, nZon));
DisHst      = zeros(nComb,nZon);

for c = 1:nComb

    % the image pair
    per     = Comb(c,:);
    imna1   = [aImg(per(1)).name(1:end-4) '_F'];
    imna2   = [aImg(per(2)).name(1:end-4) '_F'];
    
    for f = 1:nZon

        % ==========   Vectors   ==========
        dsc1    = [dirFoc imna1 num2str(f) '.vef'];
        dsc2    = [dirFoc imna2 num2str(f) '.vef'];
        cmd     = [ FipaExe.mvec1 ' ' dsc1 ' ' dsc2];
        [sts OutMtc] = dos(cmd);
        % OutMtc
        fprintf('.');
        
        % -----  Analyze Output  -----
        [StoI HedI]      = u_MtrMesSecs( OutMtc );
        [AMesDty mesTot] = u_MtrMesScnf( StoI );  
        
        DisMes(c,f) = mesTot.dis;
        SmlMes(c,f) = mesTot.sim;

        % ==========   Histograms   ==========
        hsf1        = [dirFoc imna1 num2str(f) '.hsf1'];
        hsf2        = [dirFoc imna2 num2str(f) '.hsf1'];
        Hst1        = LoadFocHist(hsf1);
        Hst2        = LoadFocHist(hsf2);
        DisHst(c,f) = f_HistMtc(Hst1, Hst2);
        
    end
    
end
%% -----   Combine Measures   -----
DisMul  = prod(DisMes,2);
SmlMul  = prod(SmlMes,2);
DisSum  = sum(DisMes,2);
SmlSum  = sum(SmlMes,2);

DisSumHst = sum(DisHst,2);

%% -----   Plot Results   -----
figure(3); [nr nc] = deal(3,2);
xLab = {'0-1' '0-2' '0-3' '0-6' '1-6'};

subplot(nr,nc,1);
bar(DisMul);
set(gca, 'xticklabel', xLab);
title('distance');

subplot(nr,nc,2);
bar(SmlMul);
set(gca, 'xticklabel', xLab);
title('similarity');

subplot(nr,nc,3);
bar(DisSum);
set(gca, 'xticklabel', xLab);
title('distance');

subplot(nr,nc,4);
bar(SmlSum);
set(gca, 'xticklabel', xLab);
title('similarity');

subplot(nr,nc,5);
bar(DisSumHst);
set(gca, 'xticklabel', xLab);
title('distance hist');



