DataDir = './Data/';

FeatureFileName1 = sprintf('%sQuerySIFTFeatures.mat',DataDir);
FeatureFileName2 = sprintf('%sTargetSIFTFeatures.mat',DataDir);

load(FeatureFileName1,'FeatureDescriptors');
Img1FeatureDescriptors = FeatureDescriptors;

load(FeatureFileName2,'FeatureDescriptors');
Img2FeatureDescriptors = FeatureDescriptors;

[FeatureDescriptorSize,NumFeatures1] = size(Img1FeatureDescriptors);
[FeatureDescriptorSize,NumFeatures2] = size(Img2FeatureDescriptors);

%%% calculate SSDs
    SSDMatrix = zeros(NumFeatures1,NumFeatures2);
    for i=1:NumFeatures1
        tempArr=zeros(1,NumFeatures2);
        tempArr(1,:)=SSD(Img1FeatureDescriptors(:,i),Img2FeatureDescriptors(:,:)); 
        SSDMatrix(i,:)=tempArr;
    end
    
    %%% missing lines from here
    %%% .....
    %%% missing lines till here
%%% calculate SSDs

save SIFTSSDMatrix.mat SSDMatrix;
