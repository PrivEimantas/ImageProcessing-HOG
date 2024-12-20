

myImg = imread("sample.jpg");
myImg = im2gray(myImg);

pointArray = [70 0, 140 255];
piecewiseLinearTransform(2,myImg,pointArray)


function [] = piecewiseLinearTransform(numPoints,inputImage,pointsArray)
    if(any([numPoints==0,isempty(inputImage),isempty(pointsArray)]))
        error("Invalid values");
    else
        figure(1);
        subplot(1,2,1)
        imshow(inputImage);
        title("Original Image");
        pointsArray = [ 0 0 pointsArray 255 255];
        gradientArray = 1:numPoints+1; %store m,c on each row#
        cArray = 1:numPoints+1;
        gradIndx=1;
    
    
        [gradientArray,cArray] = buildInfo(gradientArray,cArray,pointsArray,gradIndx);
        
     % KEEP values because starting from 0,0 and end at 255,255  gradientArray(1) =[]; %because we add on 0 0 and 255 255 at start and end.. it iterates numpoints+1 times, so need to remove first value
        gradientArray;
        pointsArray(1)=[];
        pointsArray(1)=[]; %get rid of first two
      
    
        for i=1:size(inputImage,1)*size(inputImage,2)
            inputImage(i) = getY(gradientArray,cArray,1,pointsArray,inputImage(i));
    
        end
    
        subplot(1,2,2);
        imshow(inputImage);
        title("Transformed Image");
        
    end
    
 

     function y = getY(gradientArray,cArray,indx,pointsArray,x)
            %x
           % indx
           % pointsArray(1)
            if x<=pointsArray(1)
              %  gradientArray(indx)
              %  cArray(indx)
                y= gradientArray(indx)*x+cArray(indx);

            else
                pointsArray(1)=[];
                pointsArray(1)=[];
                y=getY(gradientArray,cArray,indx+1,pointsArray,x);

            end

     end



    function [gradientArray,cArray] =  buildInfo(gradientArray,cArray,pointsArray,gradIndx)
           
        if size(pointsArray,2)==2 %if on last two then must be 255 and 255, not needed
            pointsArray;
            [gradientArray,cArray];

        else
            %m= y2-y1 / x2- x1
            gradientArray(gradIndx) =  (pointsArray(4)-pointsArray(2) ) / (pointsArray(3)-pointsArray(1));
            pointsArray(1)=[];
            pointsArray(1)=[];
            
            %y-m*x = c
            cArray(gradIndx) = pointsArray(2)-(gradientArray(gradIndx)*pointsArray(1));
            [gradientArray,cArray] = buildInfo(gradientArray,cArray,pointsArray,gradIndx+1);
        end
        
    end
    


end