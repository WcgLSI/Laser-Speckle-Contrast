%% Compute Speckle contrast K^{2}

function [ks ks2 kt kt2] = estimate_K(I_sample,nd,Nd)
%% ks and kt represents the average results of K^{2} in spatial and temporal
%% ks2 and kt2 represents two-dimensional results of K^{2} in spatial and temporal
       offset =  Nd;
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
         std1(:,:,number) = stdfilt(I_sample(:,:,number),std_filter);
        ave(:,:,number) = imfilter(I_sample(:,:,number),mean_filter,'symmetric');
        spatial_correlation_SC(:,:,number) = std1(:,:,number)./ave(:,:,number);
        tt(number) = mean2(spatial_correlation_SC(:,:,number));
    end
           td = mean(std1(offset+1:end-offset,offset+1:end-offset,:),3); 
    ave1 = mean(ave(offset+1:end-offset,offset+1:end-offset,:),3);
    ks3 = spatial_correlation_SC(offset+1:end-offset,offset+1:end-offset,:).^2;
    ks=mean2(mean(ks3,3));
    ks2 = mean(ks3,3);
    
        %%  Computation of temporal results
           standard_deviation_temporal = std(I_sample,0,3); % Computes standard deviation for each pixel across set of images
    average_temporal = mean(I_sample,3); % Computes average pixel value for each pixel across set of images
    temporal_correlation_SC = standard_deviation_temporal./average_temporal; % Computes speckle contrast map using temporal correlation 
    mean2(temporal_correlation_SC(temporal_correlation_SC<1));
    h=mean(mean(temporal_correlation_SC));
    v =mean2(standard_deviation_temporal);
    t = mean2(average_temporal);
     kt2=temporal_correlation_SC.^2;
        kt2 = kt2(offset+1:end-offset,offset+1:end-offset,:);
        kt=mean2(kt2);
end
