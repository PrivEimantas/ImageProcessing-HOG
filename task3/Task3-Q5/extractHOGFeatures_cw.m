%img = im2gray(imread('cameraman.tif'));
%extractHOGFeatures_cw(img)

function hg= extractHOGFeatures_cw(inputImage)
    sobelX = [-1 0 1; -2 0 2; -1 0 1];
    sobelY = [-1 -2 -1; 0 0 0; 1 2 1];
    rows=size(inputImage,1);
    columns=size(inputImage,2);
    if(mod(rows,8)~=0)
        rows=8;
   
        rows=rows-mod(rows,8)-8;
    end
   

    if(mod(columns,8)~=0)
 
         columns=columns-mod(columns,8)-8; 
    end
    inputImage=imresize(inputImage,[rows columns]);

    %step 1- apply sobel filter for every pixel

    Xgrad=imfilter(double(inputImage),sobelX);
    Ygrad=imfilter(double(inputImage),sobelY);
    % Get magnitude values from gradients
    magnitudeArr=sqrt(Xgrad.^2+Ygrad.^2);
    % Get directions
    directions=abs(atan2(Ygrad,Xgrad));
    directionArr=rad2deg(directions);

    %Step 2- Consider each 8x8 block to get a vector of histograms
    HistogramBins=zeros((rows/8)*(columns/8),9); 
  
    count=1;
    HistogramBinValues=[0,20,40,60,80,100,120,140,160];
    for y=1:8:rows

        for x=1:8:columns
            %loop over blocks in directionArr
            inputImage(y,x);
            
            extractedValues=directionArr(y:y+7,x:x+7); %retrieves values
            %loop over values in the block
            for a=y:y+7 %for every row
                for b=x:x+7 %every column
                    value=directionArr(a,b); %value is iterating properly
                    if(value<160)
                        bin=(value/20)+1;
                        blb=floor(bin); % lower bound value
                        bub=ceil(bin); %upper bound value
                        Lb=(value-HistogramBinValues(blb))/20; %fractional parts
                        Ub=(HistogramBinValues(bub)-value)/20;
                        Midpoint = (HistogramBinValues(bub)+HistogramBinValues(blb))/2;
                        if(Lb==0) %exact match
                            HistogramBins(count,blb)=HistogramBins(count,blb)+magnitudeArr(a,b);
                       
                        elseif(Ub==0)
                            HistogramBins(count,bub)=HistogramBins(count,bub)+magnitudeArr(a,b);
                           
                        else% (value<=Midpoint) %Lb<Ub
                            HistogramBins(count,blb)=HistogramBins(count,blb)+Ub*magnitudeArr(a,b);
                            HistogramBins(count,bub)=HistogramBins(count,bub)+Lb*magnitudeArr(a,b);
                            
                        end
                       
                    else %greater than 160
                        %one value goes into 160 the other into 0
                        Lb=(value-160)/20; %value goes to zero
                        if(Lb==0)
                          HistogramBins(count,9)=HistogramBins(count,9)+Ub*magnitudeArr(a,b); %insert directly..
                          
                        else
                            HistogramBins(count,1)=HistogramBins(count,1)+Lb*magnitudeArr(a,b);
                          
                            Ub=1-Lb;
                            HistogramBins(count,9)=HistogramBins(count,9)+Ub*magnitudeArr(a,b);
                          
                        end
                        
                    end

                end

            end
           
            
            count=count+1; %Go to the next histogram
            end

    end
    %Step 4- Concatenate and normalise
   
    % Once have all histograms just store it into each 8x8 block which
    % represents one histogram, easier to concatenate visually
    cellsMatrix=zeros(rows/8,columns/8,9); %each cell will store a histogram

    indx=1;
    for i=1:rows/8 % e.g 32 for a 256x256 image
        %for each column
        for y=1:columns/8 % e.g. 32 for a 256x256 image 

            cellsMatrix(i,y,:)=HistogramBins(indx,:); %Extract histogram bin values and store for that 8x8
            indx=indx+1; %next histogram
        end
        
    end


    
    finalVector=[]; %Final value that stores the HOG Descriptor
    concatenatedGrads=zeros(1,36); %take 36 values then concatenate them
    
    for i=1:(rows/8)-1% e.g. 32-1 %for each row except last one..
        for j=1:(columns/8)-1 % e.g32-1 %for each column except last one because would be out of bounds otherwise
            extractedBinValues1 = cellsMatrix(i,j,:);
            extractedBinValues1= reshape(extractedBinValues1,[1,9]); %get values to be a histogram of 9 bin values
            
            extractedBinValues2 = cellsMatrix(i+1,j,:);
            extractedBinValues2= reshape(extractedBinValues2,[1,9]);

            extractedBinValues3 = cellsMatrix(i,j+1,:);
            extractedBinValues3= reshape(extractedBinValues3,[1,9]);

            extractedBinValues4 = cellsMatrix(i+1,j+1,:);
            extractedBinValues4= reshape(extractedBinValues4,[1,9]);

            concatenatedGrads=[extractedBinValues1 extractedBinValues2 extractedBinValues3 extractedBinValues4];
            normalized = sqrt(sum((concatenatedGrads).^2)); % square root of sum of squares for normalization
            concatenatedGrads=concatenatedGrads/normalized;
            finalVector= [finalVector concatenatedGrads];
        end
    end

    %step 5- Return value
    hg=finalVector;
    features = extractHOGFeatures(inputImage);
    
    
end