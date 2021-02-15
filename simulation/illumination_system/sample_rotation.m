function [sample_theta_new,sample_x,sample_y] = sample_rotation(sample_theta,sample_r,theta)
%SAMPLE_ROTATION An operation for rotating the sample
sample_theta_new=sample_theta+theta;
[sample_x,sample_y]=pol2cart(sample_theta_new,sample_r);
end

