%Measure the exact rotation speed of tube
clear;close all;
filename='Raw.ome.tif'; disp(filename);
savename='Raw.proj.tif';

[Y,X]=size(imread(filename,1));
length_slice=999;  %the number of slices need to count
exposure_time=10;   %unit:ms
peak_interval_min=100;  %we will not count the peak which distance is lower than that value

proj=zeros(X,length_slice);

progress_temp=0;

bar=waitbar(0,'Measuring now...','Name','Progress');
for i=1:1:length_slice
    img=imread(filename,i);
    im2double(img);
    waitbar(i/length_slice,bar,'Measuring now...');
    progress=i/length_slice*100;
    if progress>=progress_temp
        str_p=['Progress: ',num2str(round(progress)),'%'];
        disp(str_p);
        progress_temp=progress_temp+1;
    end
    VS=sum(img,1);
    for x=1:X
        proj(x,i)=VS(x)/Y;
    end
end

proj_uint=im2uint16(proj/65535);
imwrite(proj_uint,savename);

initial_count=100;
length_count=length_slice;
sim_vector=zeros(1,length_count);
for k=1:length_count
    sim_vector(1,k)=img_corrcoef(proj(:,k),proj(:,initial_count));
end
xx=1:length_count;
plot(xx,sim_vector);

peak_position=[initial_count initial_count+peak_interval_min];
peak_value_temp=sim_vector(peak_position(end));

j=initial_count+peak_interval_min;

while j<=length_count
    if sim_vector(j)>=peak_value_temp
        peak_position(end)=j;
        peak_value_temp=sim_vector(j);
    end
    if j-peak_position(end)>peak_interval_min
        peak_position(end+1)=j;
        peak_value_temp=sim_vector(j);
    end
    j=j+1;
end

peak_fit=peak_position(1:(end-1))-initial_count;
x_fit=(1:length(peak_fit(:)))-1;
fit_result=robustfit(x_fit,peak_fit);
slice_period=fit_result(2);

R_matrix=corrcoef(x_fit*slice_period+fit_result(1),peak_fit);
r2=min(R_matrix(:))^2;
period=exposure_time*slice_period*2/1000;
rotation_velocity=2*pi/period;

close(bar);

str1=['Rotation period = ',num2str(period),'s'];
str2=['Rotation velocity = ',num2str(rotation_velocity),'rad/s'];
str3=['r^2 = ',num2str(r2)];
disp(str1);
disp(str2);
disp(str3);
