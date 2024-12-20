
im = imread("tree.jpg"); %rgb image
%im = im2gray(im); % used for testing, can apply to grey scale images
histogramEqualization(im)

function histogramEqualizedImage = histogramEqualization(inputImage)
    % Your code here
    f1 =figure(1);
    set(0,"CurrentFigure",f1)
    subplot(1,2,1,'Parent',f1);
    imshow(inputImage);
    title("Original Image");

    f2 =figure(2);
    set(0,"CurrentFigure",f2)
    subplot(1,2,1);
    imhist(inputImage);
    title("Original Histogram");

    if size(inputImage,3)==3 %is rgb .. not working properly
        R = inputImage(:,:,1);
        G = inputImage(:,:,2);
        B = inputImage(:,:,3);

        
        offsetCbcr=128;
       
        Y = double(0.299*R + 0.587*G+ 0.144*B);
        Cb = double(-0.168*R-0.331*G+0.5*B+offsetCbcr);
        Cr = double(0.5*R-0.419*G-0.081*B+offsetCbcr);
   
        Y = equalised(Y);
       
                
        R = Y +1.402*(Cr-offsetCbcr);
        G = Y-0.344*(Cb-offsetCbcr)-0.714*(Cr-offsetCbcr);
        B = Y+1.772*(Cb-offsetCbcr);
        
        inputImage(:,:,1) =  R;
        inputImage(:,:,2) =  G;
        inputImage(:,:,3) =  B;

        figure(4)
        
        imshow(inputImage)

        figure(5)
        imhist(inputImage);


    else %is grayscale
        output = equalised(inputImage);
        set(0,"CurrentFigure",f1)
        subplot(1,2,2);
        imshow(output);
        title("Transformed Image");

        set(0,"CurrentFigure",f2);
        subplot(1,2,2);
        imhist(output)
        title("Transformed Histogram");


    end

    function output = equalised(inputImage) %equalises an image
        myPoints = inputImage(:);
        freqvals=zeros(256,1); % frequency values
        y = zeros(size(myPoints));
        for i = 1:length(myPoints)
            y(i) = sum(myPoints==myPoints(i));
        end
        
        freqvals(myPoints+1) = freqvals(myPoints+1)+y; 
        totalSum = sum(freqvals);
        normalized= freqvals / totalSum; %formula from slides
        cumulative = cumu(normalized);%cumsum(normalized)
        maxValue = 255; %max intensity value
        transformation = floor(maxValue.*cumulative); %formula from slides
        inputImage(:) = transformation(inputImage+1)  ;
        output=inputImage;
        size(inputImage);
       

     end
    
           
        
    function c = cumu(x) %cumulative sum function
            c = zeros(256,1);
            for loop= 1:size(x,1)
                c(loop) = sum(x(1:loop));
            end
            c;

        end

 
    

end
