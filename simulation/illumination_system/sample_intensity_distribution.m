function sample_out = sample_intensity_distribution(lambda,sample,sample_x,sample_y,omega_0)
%SAMPLE_INTENSITY_DISTRIBUTION Get the intensity distribution of sample
%under illumination
omega_x=omega_0*sqrt(1+(lambda*sample_x/pi/(omega_0)^2).^2);
intensity_matrix=2/pi/(omega_x).^2.*exp(-2*sample_y.^2./(omega_x).^2);
sample_out=intensity_matrix.*sample;
end

