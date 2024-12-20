
InputImage = imread('Neuschwanstein.png'); % Try to replace 'Neuschwanstein.png' with other images as well
InputImage=imtranslate(InputImage,[40 40]);
%%% missing lines from here
sobelX = [-1 0 1; -2 0 2; -1 0 1];
sobelY = [-1 -2 -1; 0 0 0; 1 2 1];

Dxf=imfilter(double(InputImage),sobelX);
Dyf=imfilter(double(InputImage),sobelY);
%%% .....
%%% missing lines till here

imagesc(Dxf);
colormap gray;
axis image off;
figure,imagesc(Dyf);
colormap gray;
axis image off;

save Dxf.mat Dxf;
save Dyf.mat Dyf;
