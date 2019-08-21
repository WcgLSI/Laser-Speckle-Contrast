%% Goal :Compute the flow speckle contrast ，Kf^{2}

function [Kfs Kft]=estimate_Kf(ks2,kt2,vnoise1,vnoise2,beta,row,row2)
%% vnoise1(κ_{noise}^{2} in temporal) ,vnoise2(κ_{noise}^{2} in spatial) 
%% beta (the coherence factor, β),row (the dynamic fraction, ρ),row2 ((1-ρ)^{2})
  %%  Kf(temporal) 
        Kft = (kt2- vnoise1)./row.^2;
    %%  Kf(spatial)
Kfs = (ks2- vnoise1-beta.*row2)./row.^2;
end
