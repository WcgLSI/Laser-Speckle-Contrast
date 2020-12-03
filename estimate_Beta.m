%% Goal :Determine the coherence factor, ж┬
function [beta]=estimate_Beta(sample_path,nd,Nd,x1,x2,y1,y2)
    I_static = read_raw(char(sample_path(7)));%%Read Data
    nd = nd(y1:y2,x1:x2);
    I_static = I_static(y1:y2,x1:x2,:);% Determination area  435:475,300:350
    NT = size(I_static, 3);   
    for i=1:NT
        I_static(:,:,i) = I_static(:,:,i) - nd;
    end
    I_static(I_static<0) = 0;  
    mean_filter = fspecial('average', Nd); % Create averaging filter with dimensions (n x n) defined by user
for step = 1:10
    for number =1:(NT - step)
        if (number == 1) 
            b = imfilter(I_static(:,:,number).*I_static(:,:,number+step),mean_filter,'symmetric')./imfilter(I_static(:,:,number),mean_filter,'symmetric')./imfilter(I_static(:,:,number+step),mean_filter,'symmetric')-1;
        else
            b(:,:,number) = imfilter(I_static(:,:,number).*I_static(:,:,number+step),mean_filter,'symmetric')./imfilter(I_static(:,:,number),mean_filter,'symmetric')./imfilter(I_static(:,:,number+step),mean_filter,'symmetric')-1;
        end
            
    end
    beta(step) = mean(mean2(b(Nd+1:end-Nd,Nd+1:end-Nd,:)));   
end
%% Fitting the curve parameters of variance under different steps(жд)
%  and get beta value when the step size (жд) = 0
    b1=polyfit(1:1:step,beta(1:1:step),2);
    plot(1:1:step,beta)
    beta= polyval(b1,0);
end