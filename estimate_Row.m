%% Goal :Determine the dynamic fraction, ρ

function [row,row2]=estimate_Row(I_sample,nd,beta,Nd)
%% row represent the dynamic fraction, ρ
%% row2 represent (1-ρ)^{2}
%% beta represent the coherence factor, β
    offset =  Nd;
    mean_filter = fspecial('average',Nd); % Create averaging filter with dimensions (n x n) defined by user
    NT = size(I_sample, 3);
    for i=1:NT
        I_sample(:,:,i) = I_sample(:,:,i) - nd;
    end
    I_sample(I_sample < 0) = 0;
       step=1
    for number =1:(NT-step)
        if (number == 1) row2 = ((imfilter(I_sample(:,:,number).*I_sample(:,:,number+step),mean_filter,'symmetric')./imfilter(I_sample(:,:,number),mean_filter,'symmetric')./imfilter(I_sample(:,:,number+step),mean_filter,'symmetric'))-1)./beta;
        else row2(:,:,number) = ((imfilter(I_sample(:,:,number).*I_sample(:,:,number+step),mean_filter,'symmetric')./imfilter(I_sample(:,:,number),mean_filter,'symmetric')./imfilter(I_sample(:,:,number+step),mean_filter,'symmetric'))-1)./beta;
        end
    end
    row2 = row2(offset+1:end-offset,offset+1:end-offset,:);
     row2(row2<0)=0;
    for number =1:(NT-step)
        row(:,:,number) = (1-sqrt(row2(:,:,number)));
    end
    row = mean(row,3)
end
