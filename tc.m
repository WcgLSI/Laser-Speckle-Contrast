%% Goal :Determine the decorrelation time, ¦Ó_{c}
function X = tc(Kfs,beta,row,T)
%% the final x1 represent ¦Ó_{c},T is exposure time

    err = @(x) (Kfs - beta*(exp(-2*x)-1+2*x)/2/x.^2+4*beta*(1/row-1)*(exp(-x)-1+x)/x.^2).^2 ;
    best = 999;
for p = 1   
    [x,v,flag] = fminsearch(err,p);
    if v < best
       best=v; xopt=x; flagopt = flag ;g = p;
    end
      flagopt
end
x= xopt./T;
X = [x,v,g]

end