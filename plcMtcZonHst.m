%
% Matching zone-wise for histograms loaded as block.
%
% Run first the script plcDscxZon.m to extract the descriptors.
%
% PREVIOUS   plcDscxZonHst.m
% CURRENT    plcMtcZonHst.m
%
clear;

dirImg      = 'Imgs/';
dirFoc      = 'Focii/';

dirFoc      = u_PathToBackSlash( dirFoc ); 

%% -----  List of Images  -----
aImg        = dir([dirImg '*.jpg']);
nImg        = length(aImg);

%% ==========   Zone Matching   ==========
% the combinations:
Comb(1,:) = [1 2];          % most similar      
Comb(2,:) = [1 3];          
Comb(3,:) = [1 4];          
Comb(4,:) = [1 5];          % least similar
Comb(5,:) = [2 5];
nComb     = size(Comb,1);   % number of combinations
load('Prm');                % loads parameter nZon

DisHst = zeros(nComb,nZon);
for c = 1:nComb

    % the image pair
    per     = Comb(c,:);
    hsf1    = [dirFoc aImg(per(1)).name(1:end-4) '_FH.hsfL'];
    hsf2    = [dirFoc aImg(per(2)).name(1:end-4) '_FH.hsfL'];
    
    [Hst1 Sz1] = LoadFocHistArr(hsf1);
    [Hst2 Sz2] = LoadFocHistArr(hsf2);

    for f = 1:Sz1.nFoc
        DisHst(c,f) = sum( abs( Hst1(f,:) - Hst2(f,:) ) );
    end
    
end

%% -----   Combine Measures   -----
DisSumHst = sum(DisHst,2);

%% -----   Plot Results   -----
figure(4); [nr nc] = deal(1,2);
xLab = {'0-1' '0-2' '0-3' '0-6' '1-6'};

subplot(nr,nc,1);
bar(DisSumHst);
set(gca, 'xticklabel', xLab);
title('distance hist');



