%
%load SIFTSSDMatrix.mat SSDMatrix
%mFindSingleCorr(SSDMatrix(1,:),0.1)
%mFindSingleCorr(SSDMatrix(10,:),0.1)
function indx = mFindSingleCorr(SSDMatrix,threshold)
    indices = find(SSDMatrix<=threshold);
    if(isempty(indices)) %if did not find any indices less than threshold
        indx=0;
    else
        values = sort(SSDMatrix(indices));
        if(size(values,2)==1 ||values(1)<=values(2)*0.8 ) % may only be one value less than threshold or there is more than one
          
            indx = find(SSDMatrix==values(1));
        else
            indx=0; % if value1 is not 0.8 times smaller than value2
        end
    end
    
   

end