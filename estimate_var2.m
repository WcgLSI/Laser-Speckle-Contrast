%% Goal :Obtain variance 
  function [var_t,var_s]=estimate_var2(I_static, nd, vard, Nd,x1,x2,y1,y2)  
%% var_t  under temporal method 
    NT = size(I_static, 3);
    nd = nd(y1:y2,x1:x2);
    vard = vard(y1:y2,x1:x2);
    for i=1:NT
        I_static(:,:,i) = I_static(:,:,i) - nd;
    end
    I_static(I_static < 0) = 0; 
    var_t = mean(I_static.^2, 3) - mean(I_static,3).^2; 
    var_t = var_t/(NT-1)*NT;   
    tmp = var_t - vard;   
    fprintf('Temporal negative varc: %f\n', sum(tmp(:)<0)/numel(tmp));
    var_t = mean2(var_t);

%% var_s under spatial method for жд=1 to жд=30
mean_filter = fspecial('average', Nd);
for step = 1:30
    for i =1:(NT-step)
        if (i == 1) 
            varc_s_tem = sqrt(imfilter(I_static(:,:,i).^2,mean_filter,'symmetric').*imfilter(I_static(:,:,i+step).^2,mean_filter,'symmetric'))-imfilter(I_static(:,:,i).*I_static(:,:,i+step),mean_filter,'symmetric');
        else                                                    
            varc_s_tem(:,:,i) = sqrt(imfilter(I_static(:,:,i).^2,mean_filter,'symmetric').*imfilter(I_static(:,:,i+step).^2,mean_filter,'symmetric'))-imfilter(I_static(:,:,i).*I_static(:,:,i+step),mean_filter,'symmetric');
        end
    end
    varc_s_tem= varc_s_tem/(Nd^2-1)*Nd^2;   
    % Shrink to the valid region % There are still boundary hotspots  
    varc_s_tem = varc_s_tem(Nd:end-Nd,Nd:end-Nd,:); 
    tmp = varc_s_tem - vard(Nd:end-Nd,Nd:end-Nd,:);  
    fprintf('Spatial negative varc: %f\n', sum(tmp(:)<0)/numel(tmp));
    var_s(step) = mean(varc_s_tem(:));    
end