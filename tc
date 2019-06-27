%% Goal :Determine the decorrelation time, τ_{c}

function x1 = tc(kfs,beta,row,T)
%% x represent τ_{c},T is exposure time
  err =(kfs-hx(T./x,beta,row)).^2;
x1=solve(err,x)
end
%% The Relation between Kf^{2} and the decorrelation time τ_{c}，x1=T/τ_{c}
function X = hx(x1,beta,row,noise)
X = beta*(exp(-2*x1)-1+2*x1)/2./x1.^2+4*beta*(1./row-1)*(exp(-x1)-1+x1)./x1.^2;
end
