function value = point_cubiclinear_inter(value_matrix,x_matrix,theta_matrix)
%POINT_CUBICLINEAR_INTER Cubic-linear function for edge point
x_matrix_eff=zeros(4,2);
theta_matrix_eff=zeros(4,2);
x_matrix_eff(:,:)=1-abs(x_matrix(1:4,2:3));
theta_matrix_eff(:,:)=abs(theta_matrix(1:4,2:3));
x_weight_matrix=x_matrix_eff;
theta_weight_matrix=zeros(4,2);
for i=1:4
    for j=1:2
        temp=theta_matrix_eff(i,j);
        if temp<=1
            theta_weight_matrix(i,j)=1-2*temp^2+temp^3;
        elseif temp>1 && temp<2
            theta_weight_matrix(i,j)=4-8*temp+5*temp^2-temp^3;
        else
            theta_weight_matrix(i,j)=0;
        end
    end
end
weight=x_weight_matrix.*theta_weight_matrix;
value=sum(value_matrix.*weight,'all');
end

