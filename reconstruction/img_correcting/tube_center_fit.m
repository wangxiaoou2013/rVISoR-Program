function [y0,theta] = tube_center_fit(tube_x,tube_center_y)
%TUBE_CEMTER_FIT Use the parameter of tube center to fit the angle and
%position of whole tube
[~,X_sub]=size(tube_x);
tube_x_selected=zeros(1,9);
tube_center_y_selected=zeros(1,9);
step_length=(X_sub-1)/8;
for i=1:9
    tube_x_selected(i)=tube_x(floor(1+step_length*(i-1)));
    tube_center_y_selected(i)=tube_center_y(tube_x_selected(i));
end

fit_result=robustfit(tube_x_selected,tube_center_y_selected);
theta=180*atan(fit_result(2))/pi;
y0=fit_result(1);
end

