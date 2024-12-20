%gaussian
N=5;
sigma=2;
gaussianFiltering(N,sigma);
function gaussianFilter = gaussianFiltering (N, sigma)
    if(N<=0 || rem(N,2)==0 || sigma<=0)
        error("Error occured.. input size was either zero or negative for either")

    else
        
    % Your code here
     a=N;s=sigma;
     figure(1)
     g=fspecial('gaussian',[a a],s) %to validate my final answer
     subplot(1,2,1);
     surf(1:a,1:a,g) %plot the correct solution
     title("Correct Version");

     ystep = -1*(N-1)/2:(N-1)/2; %generate y values to be added later
     ystep = ystep(:);

     xstep = -1*(N-1)/2:(N-1)/2; % repeat as y
     yKernel = zeros(N,N)+ystep;
     xKernel = zeros(N,N)+xstep;
     kernel = gaus(xKernel(:),yKernel(:),sigma);
     sumOver = 1/ (sum(kernel(:)));
     final = reshape(kernel*sumOver,N,N)
     
     subplot(1,2,2)
     surf(1:N,1:N,final) %plotting my solution
     title("My solution");
    end
        
    function g = gaus(x,y,sigma) %function for calculating guas
        a1 = 1 / (2*pi*sigma.^2); 
        a2 = (x.^2+y.^2) / (2*sigma.^2);
        g = a1*exp(-a2);
        
    end
end