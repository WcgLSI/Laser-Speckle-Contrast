%% Goal :Determining Dark Current and Its Variance
function [nd, vard] = estimate_darkcurrent(I, Nd)
    NT = size(I, 3);
    I(I>200)=0;
    nd = median(I, 3);   
    II = I; %nd = 0; 
    histogram(II(:)) %Observing the Intensity Distribution of Dark Current

    for i=1:NT
        II(:,:,i) = II(:,:,i) - nd;
    end
    II(II<0) = 0;
    
    vard = 2*mean(II.^2, 3); 
    vard = vard/(NT-1)*NT; 