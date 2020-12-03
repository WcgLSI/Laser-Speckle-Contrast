clear;clc
%% Goal :main program,System calibration
%% Target: camera  ,Determine camera dark current and its variance
I = read_raw('E:\DARK\');%%   The folder path containing a set of dark count pictures
Nd = 5;% pixel window 
[nd, vard] = estimate_darkcurrent(I,Nd);%% camera dark current and its variance£»
%% Target:relection standard ,Determine the system noise characteristics and the coherence factor
%sample_path is a collection of data paths of reflection standard,which can be observed from 'estimate_var'.
x1 = 250;x2 = 290;y1 = 450;y2 = 490; % The range selection is determined by the location of the fat emulsion
T = 20;t = 100; % T is the camera exposure time£¬t is the time between taking photos

%Read a set of folders and the pictures in them
filename = dir('E:\LBT');
for number = 3:length(filename)
    sample_path{number-2} = strcat('E:\LBT\',filename(number).name,'\');
end

[pvar_s,pvar_t] = estimate_var(nd,vard,Nd,sample_path,x1,x2,y1,y2);%%Determine the noise parameters of the whole system
[beta] = estimate_Beta(sample_path, nd,Nd,x1,x2,y1,y2);%%Determine the coherence factor, ¦Â

