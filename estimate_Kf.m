%% Goal :Compute the flow speckle contrast ㄛKf^{2}
function [Kfs, Kft]=estimate_Kf(ks2,kt2,vnoise1,vnoise2,beta,row,row2)
%% vnoise1(百_{noise}^{2} in temporal) ,vnoise2(百_{noise}^{2} in spatial) 
%% beta (the coherence factor, 汕),row (the dynamic fraction, 老),row2 ((1-老)^{2})
  %%  Kf(temporal) 
        Kft = (kt2 - vnoise1)./row.^2;
        Kft(Kft<0) = 0;
        Kft=mean(Kft(:));
    %%  Kf(spatial)
Kfs = (ks2 - vnoise2 - beta.*row2)./row.^2;
        Kfs(Kfs<0) = 0;
        Kfs=mean(Kfs(:));
end