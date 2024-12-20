%
queryImg = imread("./Data/Query.png");
rows=size(queryImg,1);
columns=size(queryImg,2);
HogDescriptor=zeros(36,100);
count=1;
for i=1:16:floor(rows/16)*16 %for each row
    for j=1:16:floor(columns/16)*16 %for each column
        extractedValues= queryImg(i:i+15,j:j+15);
        getHog = extractHOGFeatures_cw(extractedValues);
        HogDescriptor(:,count)=getHog(:);
        count=count+1;
    end

end

SSDVals;
