%% Goal :Determine the coherence factor, β

function [beta]=estimate_Beta(sample_path, nd, vard,Nd)
    I_static = read_raw(sample_path(1));%%Read Data
    NT = size(I_static, 3);   
    for i=1:NT
        I_static(:,:,i) = I_static(:,:,i) - nd;
    end
    I_static(I_static<0) = 0;  
    mean_filter = fspecial('average', Nd); % Create averaging filter with dimensions (n x n) defined by user
        for step = 1:10
            for number =1:(NT - step)
        if (number == 1) b = imfilter(I_static(:,:,number).*I_static(:,:,number+step),mean_filter,'symmetric')./imfilter(I_static(:,:,number),mean_filter,'symmetric')./imfilter(I_static(:,:,number+step),mean_filter,'symmetric')-1;
        else b(:,:,number) = imfilter(I_static(:,:,number).*I_static(:,:,number+step),mean_filter,'symmetric')./imfilter(I_static(:,:,number),mean_filter,'symmetric')./imfilter(I_static(:,:,number+step),mean_filter,'symmetric')-1;
        end
        beta(step) = mean(b(:));
    end
%% Fitting the curve parameters of variance under different steps(Δ)
    b1=polyfit(1:1:step,beta(1:1:step),3);
%%  x is the reasonable value of the actual step(Δ)
beta= polyval(b1(:,number),x);
end
