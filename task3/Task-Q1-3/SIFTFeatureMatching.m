Tau = 0.1;

DataDir = './Data/';

ImageFileName1 = sprintf('%sQuery.png',DataDir);
ImageFileName2 = sprintf('%sTarget.png',DataDir);
FeatureFileName1 = sprintf('%sQuerySIFTFeatures.mat',DataDir);
FeatureFileName2 = sprintf('%sTargetSIFTFeatures.mat',DataDir);

Img1 = imread(ImageFileName1);
Img2 = imread(ImageFileName2);

load(FeatureFileName1,'FeatureLocations');
Img1FeatureLocations = FeatureLocations;

load(FeatureFileName2,'FeatureLocations');
Img2FeatureLocations = FeatureLocations;

[~,NumFeatures1] = size(Img1FeatureLocations);
[~,NumFeatures2] = size(Img2FeatureLocations);

load SIFTSSDMatrix.mat SSDMatrix;

%%% Feature matching
    FeatureMatchCandidates = zeros(NumFeatures1,1);

    for i=1:NumFeatures1
        indx = FindSingleCorr(SSDMatrix(i,:), Tau);
        FeatureMatchCandidates(i,1)=indx;

    end
    %%% missing lines from here
    %%% .....
    %%% missing lines till here
%%% Feature matching


%%% Display feature matching
    MatchIdx = find(FeatureMatchCandidates>0);
    NumFMatches = length(MatchIdx);
    MatchPairs = zeros(2,NumFMatches);
    for i=1:NumFMatches
        MatchPairs(:,i) = [MatchIdx(i);FeatureMatchCandidates(MatchIdx(i))];
    end
    DisplayFeatureMatching(Img1, Img2, Img1FeatureLocations, Img2FeatureLocations, MatchPairs);
%%% Display feature matching
