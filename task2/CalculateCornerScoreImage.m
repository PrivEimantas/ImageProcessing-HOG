
load('SQf.mat', 'SQxxf', 'SQxyf', 'SQyyf');

%%% missing lines from here
%use formula from slides on week 7
rows=size(SQxxf,1);
columns=size(SQxxf,2);
paddedImageXX = zeros(rows+2*3,columns+2*3); %2 for extra start and end, *3 for 3 extra padding
paddedImageYY = paddedImageXX;
paddedImageXY=paddedImageXX;

paddedImageYY(4:rows+3,4:columns+3)=SQyyf(:,:);
paddedImageXX(4:rows+3,4:columns+3)=SQxxf(:,:);
paddedImageXY(4:rows+3,4:columns+3)=SQxyf(:,:);
Rf=zeros(rows,columns);
k=0.04; %try between 0.04-0.06
for y=4:rows+3
   
        for x=4:columns+3
      
            a=paddedImageXX(y-3:y+3,x-3:x+3); %extracted from XX grad
            a=a(:);
            A=sum(a);

            b=paddedImageXY(y-3:y+3,x-3:x+3);
            b=b(:);
            B=sum(b);

            c=paddedImageYY(y-3:y+3,x-3:x+3); 
            c=c(:);
            C=sum(c);
            
            R=A*C-(B*B)-k*((A+C).^2);
            Rf(y-3,x-3)=R;
        end
        
    end



%%% .....
%%% missing lines till here

save Rf.mat Rf;

imagesc(Rf);
colormap gray;
axis image off;
title('R[f]')
