%% Goal :Determine the  noise characteristics of the whole system 
function p = estimate_var(nd,vard,Nd,sample_path)
%% Get all the variance results
% sample_path need to be defined in main program
for number =1:n
    number
    sample_path1 = sample_path(number);
    I_static1 = read_raw(sample_path1);%%Read Data
    I_static2 = I_static1([y1:y2 x1:x2]);% Determination area
%% invoke function of ‘estimate_var2’
    [varc,varc2_c] = estimate_var2(I_static2(:,:,:), nd, vard, Nd);%Obtain variance 
    Ist(number,:) = mean(I_static2(:));
    var(number,:) = varc2_c;
end
%% Fitting the curve parameters of variance under different steps(Δ)
for number = 1:n
    p1(:,number) = polyfit(1:1:20,var(number,1:1:20),3);
end
tt1 = [];
%%  x is the reasonable value of the actual step(Δ)
for number=1:n
    tt1 = [ tt1 polyval(p(:,number),x)];
end
tt2 = [Ist(1:end)];
tt2 = sortrows([tt1;tt2']',2);
%% Observe raw data
plot(tt2(:,2), tt2(:,1),'*')
%% Fitting the system noise characteristics
p = polyfit(tt2(1:n,2),tt2(1:n,1),2);
end
