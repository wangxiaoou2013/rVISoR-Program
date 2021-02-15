function [slice_cart,temp_matrix] = img_pol2cart(slice_pol)
%Convert the image from Polar Coordination to Cartesian Coordination

[angle_num,d_num]=size(slice_pol);

d_res=1;
angle_res=pi/angle_num;

rho=((1:d_num)-1-(d_num-1)/2)*d_res;
angle=((1:angle_num)-1)*angle_res;

res_mag=1;

x_res=d_res/res_mag;
y_res=x_res;

x_num=res_mag*d_num;
y_num=x_num;

slice_cart=zeros(x_num);
xx=((1:x_num)-1-(x_num-1)/2)*x_res;
yy=((y_num:-1:1)-1-(y_num-1)/2)*y_res;

temp_matrix=zeros(x_num);

for x_order=1:x_num
    for y_order=1:y_num
        x=xx(x_order);
        y=yy(y_order);
        [theta,r]=cart2pol(x,y);
        
        
        if abs(r)<=max(rho(:))
            if theta<0
                r=-r;
                theta=theta+pi;
            end
            if theta==pi
                r=-r;
                theta=0;
            end
            
            r_position=r/d_res+(d_num-1)/2+1;
            theta_position=theta/angle_res+1;
            
            [r_matrix,theta_matrix]=meshgrid(-1:2,-1:2);
            r_matrix=r_position-floor(r_position)-r_matrix;
            theta_matrix=theta_position-floor(theta_position)-theta_matrix;
            
            r_floor=floor(r_position);
            theta_floor=floor(theta_position);
            r_ref=(1:4)-2+r_floor;
            theta_ref=(1:4)-2+theta_floor;
            
            if r_ref(4)>d_num
                r_ref(4)=0;
            end
            for i=3:4
                if theta_ref(i)>angle_num
                    theta_ref(i)=theta_ref(i)-angle_num;
                end
            end
            if theta_ref(1)==0
                theta_ref(1)=angle_num;
            end
            
            if r_ref(1)==0 || r_ref(4)==0
                value_matrix=zeros(4,2);
                for i=1:4
                    for j=1:2
                        value_matrix(i,j)=slice_pol(theta_ref(i),r_ref(j+1));
                    end
                end
                slice_cart(y_order,x_order)=point_cubiclinear_inter(value_matrix,r_matrix,theta_matrix);
            else
                value_matrix=zeros(4);
                for i=1:4
                    for j=1:4
                        value_matrix(i,j)=slice_pol(theta_ref(i),r_ref(j));
                    end
                end
                slice_cart(y_order,x_order)=point_bicubic_inter(value_matrix,r_matrix,theta_matrix);
            end
            
        end
    end
end

end

