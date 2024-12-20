
load('Rf.mat', 'Rf');


%%% missing lines from here
%%% .....
rows=size(Rf,1);
columns=size(Rf,2);
maxValue=max(Rf(:));
CornerFlagImage=Rf>0.1*maxValue;

%%% missing lines till here

[PosC, PosR] = find(CornerFlagImage == 1);
imshow(InputImage);
Pos_q = [PosR, PosC];
save KeyPoints.mat Pos_q;
hold on;
plot(PosR,PosC,'r.','Markersize',15);
axis image;
hold off;
