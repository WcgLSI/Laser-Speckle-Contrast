%% Compute Speckle contrast K^{2}
function [ks, ks2, kt, kt2] = estimate_K(I_sample,nd,Nd)
%% ks and kt represents the average results of K^{2} in spatial and temporal
%% ks2 and kt2 represents two-dimensional results of K^{2} in spatial and temporal
        ks = [];kt=[];
        std_filter = ones(Nd); %  standard deviation filter with dimensions (n x n) defined by user
        mean_filter = fspecial('average',Nd); % Create averaging filter with dimensions (n x n) defined by user
        NT = size(I_sample, 3);
    for i=1:NT
       I_sample(:,:,i) = I_sample(:,:,i) - nd;        
    end
       I_sample(I_sample < 0) = 0;
       %%  Computation of spatial results
    for number = 1:NT
        spatial_correlation_SC(:,:,number) = imfilter(I_sample(:,:,number).^2,mean_filter,'symmetric')./imfilter(I_sample(:,:,number),mean_filter,'symmetric').^2-1; %每张number图片都求出一个K分布图
    end
        ks3 = spatial_correlation_SC(Nd+1:end-Nd,Nd+1:end-Nd,:);
        ks=mean2(mean(ks3,3)); 
        ks2 = mean(ks3,3);
    
       %%  Computation of temporal results
        temporal_correlation_SC = mean(I_sample.^2,3)./mean(I_sample,3).^2-1; % Computes speckle contrast map using temporal correlation 
        kt2=temporal_correlation_SC;
        kt2 = kt2(Nd+1:end-Nd,Nd+1:end-Nd,:);
        kt=mean2(kt2);
end