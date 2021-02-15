function I_sum = sample_imaging(k,theta_num,d_num,z_num,sample_intensity,lens1,lens2,sample_r,sample_x.sample_y,sample_z,lens_x,lens_y,WD_detection,BFP_detection)
%SAMPLE_IMAGING The result of a imaging result for a sample plane
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
end

