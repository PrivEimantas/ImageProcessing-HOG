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
    Img1Feature1Index = 1;
    [MatchingFeatureIndex1] = FindSingleCorr(SSDMatrix(Img1Feature1Index,:), Tau);
%%% Feature matching

%%% Feature matching
    Img1Feature10Index = 10;
    [MatchingFeatureIndex10] = FindSingleCorr(SSDMatrix(Img1Feature10Index,:), Tau);
%%% Feature matching

display(sprintf('Query%d, Matching target: %d', Img1Feature1Index, MatchingFeatureIndex1));
display(sprintf('Query%d, Matching target: %d', Img1Feature10Index, MatchingFeatureIndex10));

%%% Display feature matching
    MatchPair = [Img1Feature10Index;MatchingFeatureIndex10];
    DisplayFeatureMatching(Img1, Img2, Img1FeatureLocations, Img2FeatureLocations, MatchPair);
%%% Display feature matching
