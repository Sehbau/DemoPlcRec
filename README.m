%
% Demo for place recognition or any image matching. 
%
% The demo images are sample images from the Living Room dataset
% (downsampled in resolution):
% - images 1 and 2 are the most similar (0 and 1, resp)
% - images 1 and 5 are the most dissimilar (0 and 6, resp)
%
% Descriptors are matched once for the entire image (plcMtcImg.m) and once
% for different regions (image partitions) called zones here (akin to the
% technique of spatial histogramming). But first we need to extract the
% descriptors for each image.
%

% ----------   Descriptor Extraction   ----------
% plcDscx.m         descriptor extraction for all images


% ----------   Matching with Entire Set   ----------
% plcMtcImg.m       matching vectors/histograms for ENTIRE image


% ----------   Matching Zone-Wise   ----------
% Requires that plcDscx.m (above) was run already 

% plcDscxZon.m      descriptor extraction for zones (focii) with focxv1/h1
% plcMtcZon.m       matching vectors/histograms zone-wise

% Histograms generated en block (faster saving):
%
% plcDscxZonHst.m   histogram extraction for zones with focxhL (en bloc)
% plcMtcZonHst.m    histogram matching for zones 