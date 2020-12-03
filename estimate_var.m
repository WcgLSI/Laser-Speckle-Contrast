%% Goal :Determine the  noise characteristics of the whole system 
function [pvar_s,pvar_t] = estimate_var(nd,vard,Nd,sample_path,x1,x2,y1,y2)  % Get all the variance results
for number = 1:length(sample_path)   
    I_static1 = read_raw(char(sample_path(number)));%% Read Data
    I_static2 = I_static1(y1:y2,x1:x2,:);% Determination area
    [var_t,var_s] = estimate_var2(I_static2, nd, vard, Nd,x1,x2,y1,y2);%Obtain variance 
    Ist(number) = mean(I_static2(:)); 
    var_S(number,:) = var_s;
    var_T(number) = var_t;  
end

% Fitting the curve parameters of variance and get the variance value when the step size (жд) = 0 under spatial method
for number = 1:length(sample_path)
    Poly_S (:,number) = polyfit(1:1:20,var_S(number,1:1:20),1);  
end
    tt1 = [];
for number=1:length(sample_path)
    tt1 = [ tt1 polyval(Poly_S(:,number),0)];
end
%% Fitting the system noise characteristics 

    tt = [Ist(Ist~=0)];
    var_T = [var_T(Ist~=0)];
    tt2 = sortrows([tt1;tt]',2); 
    tt3 = sortrows([var_T;tt]',2);
%   Observe raw data
    plot(tt2(:,2), tt2(:,1),'-*') 
    plot(tt3(:,2), tt3(:,1),'-*') 
    pvar_s = polyfit(tt2(:,2),tt2(:,1),1);  
    pvar_t = polyfit(tt3(:,2),tt3(:,1),1);
end