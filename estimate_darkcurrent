%% Goal :Determining Dark Current and Its Variance
function [nd, vard] = estimate_darkcurrent(I, Nd)
    NT = size(I, 3);
    nd = median(I, 3);
    II = I;
  histogram(II(:)) %Observing the Intensity Distribution of Dark Current
  if mode(II(:)==0)
      II = 0;nd = 0; end
%If the mode of light intensity is 0, then according to the normal distribution, it is considered that the camera has removed noise beforehand.    for i=1:NT
            for i=1:NT
II(:,:,i) = II(:,:,i) - nd;
            end
    II(II<0) = 0;
    vard = 2*mean(II.^2, 3);
    vard = vard/(NT-1)*NT;
