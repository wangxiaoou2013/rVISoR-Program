%Extract the tube zone from the image

clear; close all;

filename='Raw.ext.tif';
savename='Raw.test.tif';

len=309;
[Y,X]=size(imread(filename,1));

threshold=128;

bar=waitbar(0,'Adjusting now...');
for slice=1:len
    tic
    str=['Adjusting now... (Progress:',num2str(slice),'/',num2str(len),' ',num2str(round(slice/len*100)),'%)'];
    disp(str);
    waitbar(slice/len,bar,str);

    img=imread(filename,slice);
    img_original=img;
    for y=1:Y
        for x=1:X
            if img(y,x)<=threshold
                img(y,x)=0;
            else
                img(y,x)=65535;
            end
        end
    end
    
    bw=imbinarize(img);
    
    bw=img_clean(bw);
    
    tube_x=1:(X-20);
    tube_center_y=tube_center_count(bw);
    [y0,theta]=tube_center_fit(tube_x,tube_center_y);
    
    img_rotated=imrotate(img_original,theta,'bicubic','crop');
    bw_rotated=imrotate(bw,theta,'bicubic','crop');
    
    tube_center_y=tube_center_count(bw_rotated);
    
    [y0_2,theta_2]=tube_center_fit(tube_x,tube_center_y);
    
    width=866;
    img_output=img_cut(img_rotated,y0_2,width);
    
    if slice==1
        imwrite(img_output,savename);
    else
        imwrite(img_output,savename,'WriteMode','append');
    end
    toc
end

close(bar);