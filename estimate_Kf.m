%% Goal :Compute the flow speckle contrast ��Kf^{2}
function [Kfs, Kft]=estimate_Kf(ks2,kt2,vnoise1,vnoise2,beta,row,row2)
%% vnoise1(��_{noise}^{2} in temporal) ,vnoise2(��_{noise}^{2} in spatial) 
%% beta (the coherence factor, ��),row (the dynamic fraction, ��),row2 ((1-��)^{2})
  %%  Kf(temporal) 
        Kft = (kt2 - vnoise1)./row.^2;
        Kft(Kft<0) = 0;
        Kft=mean(Kft(:));
    %%  Kf(spatial)
Kfs = (ks2 - vnoise2 - beta.*row2)./row.^2;
        Kfs(Kfs<0) = 0;
        Kfs=mean(Kfs(:));
end