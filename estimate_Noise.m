%% Goal :Compute measurement noise contrast£¬¦Ê_{noise}^{2}
function [vnoise1, vnoise2]=estimate_Noise(I_sample,nd,pvarc,Nd,p)
%% vnoise1 represents two-dimensional results of ¦Ê_{noise}^{2} in temporal
%% vnoise2 represents two-dimensional results of ¦Ê_{noise}^{2} in spatial
    mean_filter = fspecial('average', Nd); % averaging filter with dimensions (n x n) defined by user
    NT = size(I_sample, 3);
    offset = Nd;
    for i=1:NT
        I_sample(:,:,i) = I_sample(:,:,i) - nd;
    end
    I_sample(I_sample < 0) = 0;
    %% Computation of temporal results£¬noise1
    noise1 = (polyval(pvarc,mean(I_sample,3)))./(mean(I_sample,3)).^2;
    % Remove the edge ones
    vnoise1 = noise1(offset+1:end-offset,offset+1:end-offset);  
    %% Computation of spatial results£¬noise2
    for number =1:NT
        if (number == 1) 
            noise = (polyval(p,mean(I_sample,3)))./imfilter(I_sample(:,:,number),mean_filter,'symmetric').^2;
        else
            noise(:,:,number) = ((polyval(p,imfilter(I_sample(:,:,number),mean_filter,'symmetric'))))./imfilter(I_sample(:,:,number),mean_filter,'symmetric').^2;
        end
    end
    %  Remove the edge ones
    noise2 = noise(offset+1:end-offset,offset+1:end-offset,:);
    vnoise2 = mean(noise2,3);
    end