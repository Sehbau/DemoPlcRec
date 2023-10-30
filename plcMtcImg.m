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

progMvec1   = '..\MtchVec\mvec1';
dirImg      = 'Imgs/';
dirDsc      = 'Desc\';              % windows backslash

addpath('../UtilMb/');
addpath('../MtchVec/UtilMb/');
addpath('../DescExtr/UtilMb/Hist/');

%% -----  List of Images  -----
aImg    = dir([dirImg '*.jpg']);
nImg    = length(aImg);

%% ==========   Vec Matching (whole image)   ==========
% the combinations:
Comb(1,:) = [1 2];          % most similar (0,1)
Comb(2,:) = [1 3];          
Comb(3,:) = [1 4];          
Comb(4,:) = [1 5];          % least similar (0,6)
Comb(5,:) = [2 5];          
nComb     = size(Comb,1);   % number of combinations

[Dis Sml] = deal(zeros(1, nComb));   % distances/similarities
DisHst = zeros(1, nComb);
for c = 1:nComb
    
    % ==========   Vectors   ==========
    % the image pair
    per     = Comb(c,:);
    dsc1    = [dirDsc aImg(per(1)).name(1:end-4) '.vec'];
    dsc2    = [dirDsc aImg(per(2)).name(1:end-4) '.vec'];
    
    cmd     = [progMvec1 ' ' dsc1 ' ' dsc2];
    [Std OutMtc] = dos(cmd);    % excecute program
    % OutMtc
    fprintf('.');
    
    % -----  Analyze Output  -----
    [StoI HedI] = u_MtrMesHead(OutMtc);
    [MesImg disImg] = u_MtrMvec(StoI, HedI);
    Ndsc1I      = u_MtrMvecNdsc(StoI.Ndsc, HedI, '1');
    Ndsc2I      = u_MtrMvecNdsc(StoI.Ndsc, HedI, '2');
    MesI        = f_Mvv(MesImg, Ndsc1I, Ndsc2I, 'img');
    Dis(c)      = MesI.Dnc.men;
    Sml(c)      = MesI.Sml.men;
    
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
bar(Sml);
set(gca, 'xticklabel', xLab);
title('similarity vect');

subplot(nr,nc,3);
bar(DisHst);
set(gca, 'xticklabel', xLab);
title('distance hist');
