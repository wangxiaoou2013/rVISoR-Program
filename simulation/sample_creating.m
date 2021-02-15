%Create a sample in cylindrical coordinate
clear;close all;clc;

theta_num=2;
r_num=101;
z_num=101;
dtheta=pi/theta_num;
dr=1;
dz=1;

theta=((1:theta_num)-1)*dtheta;
r=((1:r_num)-(r_num+1)/2)*dr;
z=((1:z_num)-(z_num+1)/2)*dz;

sample_theta_interval=60/180*pi;
sample_r_interval=25;
sample_z_interval=25;

sample=zeros(theta_num,r_num,z_num);
[sample_r,sample_theta,sample_z]=meshgrid(r,theta,z);

% sample_theta_remain=sample_theta-round(sample_theta/sample_theta_interval)*sample_theta_interval;
% sample_r_remain=sample_r-round(sample_r/sample_r_interval)*sample_r_interval;
% sample_z_remain=sample_z-round(sample_z/sample_z_interval)*sample_z_interval;
% sample_combine_remain=abs(sample_theta_remain)+abs(sample_r_remain)+abs(sample_z_remain);
% sample(sample_combine_remain<0.0002)=1;
% sample(sample_theta~=0)=0;
% sample(1,51,51)=1;
% sample(1,51,101)=1;
% sample(1,51,1)=1;
% sample(1,101,51)=1;
% sample(1,1,51)=1;
% sample(1,1,1)=1;
% sample(1,1,101)=1;
% sample(1,101,1)=1;
% sample(1,101,101)=1;
sample(1,61,51)=1;

r_abs=abs(sample_r);
[value,position]=min(r_abs);
if value==0
    for z=1:z_num
        sample_center=max(sample(:,position,z));
        sample(:,position,z)=sample_center;
    end
end

save('sample.mat','sample');
save('sample.mat','sample_theta','-append');
save('sample.mat','sample_r','-append');
save('sample.mat','sample_z','-append');