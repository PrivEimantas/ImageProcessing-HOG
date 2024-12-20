
load('Dxf.mat', 'Dxf');
load('Dyf.mat', 'Dyf');



figure(1);
subplot(1,2,1);
imagesc(Dxf);
colormap gray;
title('Dx f')
axis image off;
subplot(1,2,2);
imagesc(Dyf);
colormap gray;
axis image off;
title('Dy f')

%%% missing lines from here
%apply xgrad and y grad onto itself again
sobelX = [-1 0 1; -2 0 2; -1 0 1];
sobelY = [-1 -2 -1; 0 0 0; 1 2 1];

Qxxf=imfilter(Dxf,sobelX);
Qxyf=imfilter(Dxf,sobelY);
Qyyf=imfilter(Dyf,sobelY);

%%% .....
%%% missing lines till here

figure(2);
subplot(1,3,1);
imagesc(Qxxf);
colormap gray;
axis image off;
title('Qxx f')

subplot(1,3,2);
imagesc(Qxyf);
colormap gray;
axis image off;
title('Qxy f')

subplot(1,3,3);
imagesc(Qyyf);
colormap gray;
axis image off;
title('Qyy f')

%%% missing lines from here
%generate gaussian filter
N=7;
sigma=1;
ystep = -1*(N-1)/2:(N-1)/2; %generate y values to be added later
ystep = ystep(:);

xstep = -1*(N-1)/2:(N-1)/2; % repeat as y
yKernel = zeros(N,N)+ystep;
xKernel = zeros(N,N)+xstep;
kernel = gaus(xKernel(:),yKernel(:),sigma);
sumOver = 1/ (sum(kernel(:)));
final = reshape(kernel*sumOver,N,N);
%ga=fspecial('gaussian',[7 7],1);
%then apply gaussian filter to each dervivate
SQxxf = imfilter(Qxxf,final);
SQxyf= imfilter(Qxyf,final);
SQyyf=imfilter(Qyyf,final);



%%% .....
%%% missing lines till here


save SQf.mat SQxxf SQxyf SQyyf;

figure(3);
subplot(1,3,1);
imagesc(SQxxf);
colormap gray;
axis image off;
title('S[Qxx f]')

subplot(1,3,2);
imagesc(SQxyf);
colormap gray;
axis image off;
title('S[Qxy f]')

subplot(1,3,3);
imagesc(SQyyf);
colormap gray;
axis image off;
title('S[Qyy f]')


function g = gaus(x,y,sigma) %function for calculating guas
        a1 = 1 / (2*pi*sigma.^2); 
        a2 = (x.^2+y.^2) / (2*sigma.^2);
        g = a1*exp(-a2);
        
end
