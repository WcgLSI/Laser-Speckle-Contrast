%% Goal :  Read raw data and render it as an image
function II = read_raw(sample_path)
    Readfiles = dir(fullfile(sample_path, '*.raw'));%% Data Path
   
    for number = 1:length(Readfiles)
        filename = strcat(sample_path,Readfiles(number).name);
        fid1 = fopen(filename);     
        data1 = fread(fid1,964*646,'uint16');  %% Data attributes
        image1 = reshape(data1,646,964)';
        fclose(fid1);
        I1 = image1;
         if number == 1
             II = I1; 
         else
             II(:,:,number) = I1; 
         end
         if number>100 
             break
         end
    end
