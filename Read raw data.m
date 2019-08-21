%% Goal :  Read raw data and render it as an image
function II = read_raw(sample_path)
    Readfiles = dir(fullfile(char(sample_path), '*.raw'));%% Data Path
    for number = 1:length(Readfiles)
        filename = char(strcat(sample_path,Readfiles(number).name));
        fid1 = fopen(filename);     
        data1 = fread(fid1,964*1292,'uint16');  %% Data attributes
        image1 = reshape(data1,1292,964);
        image1 = image1';       
        fclose(fid1);
        I1 = image1;
         if (number == 1) II = I1; 
        else II(:,:,number) = I1; end
    end
  %  fprintf('Read %d files in total.\n', size(II,3));%Observe image
