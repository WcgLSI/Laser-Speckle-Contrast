%% Goal :main program,Sample measurement 
%% Target:Dynamic samples ,Compute measurement noise contrast,the dynamic fraction,the flow speckle contrast,the decorrelation time
i=1; k=1;   
filename = dir('E:\ZFR'); 
for number = 3:length(filename)
    sample_path1{number-2} = strcat('E:\ZFR\',filename(number).name,'\');
end

nd1 = nd(y1:y2,x1:x2);
for number=1:length(sample_path1)
    I_sample1_tem = read_raw(char(sample_path1(number)));%%Dynamic Image Path
    I_sample1 =I_sample1_tem(y1:y2,x1:x2,:);%%Determine the image range
    [ks, ks2, kt, kt2] = estimate_K(I_sample1,nd1,Nd);%%Determine Speckle contrast K^{2}
    [row,row2] = estimate_Row(I_sample1,nd1,beta,Nd);%%Determine the dynamic fraction, row峈老.  row2峈(1-老)^2ㄛ
    [vnoise1, vnoise2]=estimate_Noise(I_sample1,nd1,pvar_t,Nd,pvar_s);%%Compute measurement noise contrastㄛ百_{noise}^{2}
    [Kfs, Kft]=	estimate_Kf(ks2,kt2,vnoise1,vnoise2,beta,row,row2);%%Compute the flow speckle contrast ㄛKf^{2}
    ts = tc(Kfs,beta,row,T);tt = tc(Kft,beta,row,T);%%Determine the decorrelation time,而_{c}(spatial ,temporal)
    Tt(number,:) = tt;   Ts(number,:) = ts; 
end
