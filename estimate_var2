%% Goal :Obtain variance 

  function [varc,varc2_c]=estimate_var2(I_static, nd, vard, Nd)
%% varc  under temporal method
    NT = size(I_static, 3);
    for i=1:NT
        I_static(:,:,i) = I_static(:,:,i) - nd;
    end
    I_static(I_static < 0) = 0;
    varc = mean(I_static.^2, 3) - mean(I_static,3).^2; 
    varc = varc/(NT-1)*NT;
    tmp = varc - vard;
    fprintf('Temporal negative varc: %f\n', sum(tmp(:)<0)/prod(size(tmp)));


%% varc2_c under spatial method for Δ=1 to Δ=30
mean_filter = fspecial('average', Nd);
for step = 1:30;
        step
        for i =1:(NT-step)
            if (i == 1) 
                varc2 = sqrt(imfilter(I_static(:,:,i).^2,mean_filter,'symmetric').*imfilter(I_static(:,:,i+step).^2,mean_filter,'symmetric'))-imfilter(I_static(:,:,i).*I_static(:,:,i+step),mean_filter,'symmetric');
            else 
                varc2(:,:,i) = sqrt(imfilter(I_static(:,:,i).^2,mean_filter,'symmetric').*imfilter(I_static(:,:,i+step).^2,mean_filter,'symmetric'))-imfilter(I_static(:,:,i).*I_static(:,:,i+step),mean_filter,'symmetric');
            end
        end
        varc2 = varc2/(Nd^2-1)*Nd^2;   
        %% Shrink to the valid region
        %% offset = (Nd+1)/2;   %% There are still boundary hotspots
        offset = Nd;
        varc2 = varc2(offset:end-offset,offset:end-offset,:);
        tmp = varc2 - vard;
        fprintf('Spatial negative varc: %f\n', sum(tmp(:)<0)/prod(size(tmp)));
        varc2_c(step) = mean(varc2(:));
    end
