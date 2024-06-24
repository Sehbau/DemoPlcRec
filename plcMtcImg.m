%
% Matches images as a whole (vectors and histograms).
% Run first the script plcDscx.m to extract the descriptors.
%
% PREVIOUS  plcDscx.m
% CURRENT   plcMtcImg.m
% NEXT      plcDscxZon.m, plcMtcZon.m
%
% Images 1 and 2 are the most similar (0 and 1, resp)
% Images 1 and 5 are the most dissimilar (0 and 6, resp)
%
clear;
run('../globalsSB');

dirImg      = 'Imgs/';
dirDsc      = 'Desc/';              

% change to window backslash
%dirDsc      = u_PathToBackSlash( dirDsc );

%% -----  List of Images  -----
aImg    = dir( [dirImg '*.jpg'] );
nImg    = length(aImg);

%% ==========   Vec Matching (whole image)   ==========
% the combinations:
Comb(1,:) = [1 2];          % most similar (0,1)
Comb(2,:) = [1 3];          
Comb(3,:) = [1 4];          
Comb(4,:) = [1 5];          % least similar (0,6)
Comb(5,:) = [2 5];          
nComb     = size(Comb,1);   % number of combinations

[Dis Sim] = deal(zeros(1, nComb));   % distances/similarities
DisHst = zeros(1, nComb);
for c = 1:nComb
    
    % ==========   Vectors   ==========
    % the image pair
    per     = Comb(c,:);
    pthDsc1 = [dirDsc aImg(per(1)).name(1:end-4) '.vec'];
    pthDsc2 = [dirDsc aImg(per(2)).name(1:end-4) '.vec'];
    
    cmnd    = [ FipaExe.mvec1 ' ' pthDsc1 ' ' pthDsc2];
    [Std OutMtc] = dos(cmnd);    % excecute program
    % OutMtc
    fprintf('.');
    
    % -----  Analyze Output  -----
    [StoI HedI]      = u_MtrMesSecs( OutMtc );
    [AMesDty mesTot] = u_MtrMesScnf( StoI );

    Dis(c)      = mesTot.dis;
    Sim(c)      = mesTot.sim;
    
    % ==========   Histograms   ==========
    hsf1    = [dirDsc aImg(per(1)).name(1:end-4) '.hst'];
    hsf2    = [dirDsc aImg(per(2)).name(1:end-4) '.hst'];
    Hst1    = LoadDescHist(hsf1);
    Hst2    = LoadDescHist(hsf2);
    DisHst(c) = f_HistMtc(Hst1, Hst2); % for demo only
    
end

%% -----   Plot Results   -----
figure(1); clf; [nr nc]=deal(2,2);
xLab = {'0-1' '0-2' '0-3' '0-6' '1-6'};

subplot(nr,nc,1);
bar(Dis);
set(gca, 'xticklabel', xLab);
title('distance vect');

subplot(nr,nc,2);
bar(Sim);
set(gca, 'xticklabel', xLab);
title('similarity vect');

subplot(nr,nc,3);
bar(DisHst);
set(gca, 'xticklabel', xLab);
title('distance hist');
