function value = point_bicubic_inter(value_matrix,x_matrix,theta_matrix)
x_weight_matrix=zeros(4);
theta_weight_matrix=zeros(4);
for i=1:4
    for j=1:4
        temp=abs(x_matrix(i,j));
        if temp<=1
            x_weight_matrix(i,j)=1-2*temp^2+temp^3;
        elseif temp>1 && temp<2
            x_weight_matrix(i,j)=4-8*temp+5*temp^2-temp^3;
        else
            x_weight_matrix(i,j)=0;
        end
    end
end

for i=1:4
    for j=1:4
        temp=abs(theta_matrix(i,j));
        if temp<=1
            theta_weight_matrix(i,j)=1-2*temp^2+temp^3;
        elseif temp>1 && temp<2
            theta_weight_matrix(i,j)=4-8*temp+5*temp^2-temp^3;
        else
            theta_weight_matrix(i,j)=0;
        end
    end
end

weight_matrix=x_weight_matrix.*theta_weight_matrix;
value=sum(value_matrix.*weight_matrix,'all');
end

