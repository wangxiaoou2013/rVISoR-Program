%load the input rotational model and get the imaging result

clear; close all; clc;

%filepath loading zone
addpath('illumination_system','detection_system','img_cylindrical_to_cartesian','tool');

%sample processing zone
load('sample.mat','sample');
load('sample.mat','sample_theta');
load('sample.mat','sample_r');
load('sample.mat','sample_z');
[theta_num,d_num,z_num]=size(sample);

%laser zone
lambda_illumination=0.488;
lambda_detection=0.520;
k=2*pi/lambda_detection;

%objective lens in illumination system

refractive_index=1.5136;
refractive_index_ref=1.33;
magnification_illumination=20;
FN_ref=1.325e3;
WD_illumination_ref=3.5e3;

%objective lens in detection system

WD_detection_ref=3.3e3;
WD_detection=WD_detection_ref*refractive_index_ref/refractive_index;
radius=2.5e3;
magnification_detection=40;
BFP_detection=WD_detection*magnification_detection;
lens_length=WD_detection+BFP_detection;
[lens1,lens_x,lens_y]=lens_matrix_creating(k,WD_detection,radius,1);
[lens2,~,~]=lens_matrix_creating(k,BFP_detection,radius,1);

norm_t=3.4519e-9;
FWHM=zeros(1,5);

for q=1:5
NA=q*0.01+0.04;
observation_range_ref=FN_ref/magnification_illumination;
theta_illumination=asin(NA/refractive_index);
WD_illumination=WD_illumination_ref*refractive_index_ref/refractive_index;
omega_0=lambda_illumination/pi/theta_illumination;

IB=zeros(1,31);

for t=1:31
    rotation_theta=(t-16)*pi/180;
    [~,sample_x,sample_y]=sample_rotation(sample_theta,sample_r,-rotation_theta);
    
    sample_intensity=sample_intensity_distribution(lambda_illumination,sample,sample_x,sample_y,omega_0);
    I_sum=zeros(d_num*50,z_num*50);
    for theta_order=1:theta_num
        for d_order=1:d_num
            for z_order=1:z_num
                if sample_intensity(theta_order,d_order,z_order)>1e-4
                    if sample_r(theta_order,d_order,z_order)~=0 || theta_order==1
                        delta_z=WD_detection-sample_y(theta_order,d_order,z_order);
                        U_before_lens1=point_spread_to_lens(k,sample_intensity(theta_order,d_order,z_order),sample_z(theta_order,d_order,z_order),sample_x(theta_order,d_order,z_order),lens_x,lens_y,delta_z);
                        U_after_lens1=U_before_lens1.*lens1;
                        U_before_lens2=RS_diffraction_integration(k,U_after_lens1,lens_x,lens_y,WD_detection+BFP_detection);
                        U_after_lens2=U_before_lens2.*lens2;
                        U_result=RS_diffraction_integration(k,U_after_lens2,lens_x,lens_y,BFP_detection);
                        I=abs(U_result).^2;
                        I_shift=zeros(size(I_sum));
                        
                        I_shift=matrix_shift_matrix(I,I_shift);
                        I_sum=I_sum+I_shift;
                    end
                    str=['Coordination:','(',num2str(theta_order),',',num2str(d_order),',',num2str(z_order),')/(',num2str(theta_num),',',num2str(d_num),',',num2str(z_num),')'];
                    disp(str);
                end
            end
        end
    end
    I_norm=I_sum/norm_t;
    IB(t)=max(max(I_norm));
    disp(t);
end
value=max(max(IB));

for p=1:31
    if IB(p)>=value/2
        FWHM(q)=FWHM(q)+1;
    end
end
end
%     savename_img=['analysis_program\r_data\',num2str(t),'.tif'];
%     savename_dat=['analysis_program\r_data\',num2str(t),'.mat'];
%     imwrite(I_norm,savename_img);
%     save(savename_dat,'I_norm');
%     disp(t);

% sample_imaging_slice=zeros(d_num,z_num);
% sample_imaging_slice(:,:)=sample_intensity(1,:,:);
% sample_imaging_slice_norm=abs(sample_imaging_slice)/max(max(abs(sample_imaging_slice)));