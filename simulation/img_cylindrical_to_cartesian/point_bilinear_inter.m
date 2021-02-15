function value = point_bilinear_inter(value11,value12,value21,value22,r,r1,r2,theta,theta1,theta2)
    if r2==r1
        if theta2==theta1
            value=value11;
        else
            value1_t=abs((theta2-theta)/(theta2-theta1))*value11;
            value2_t=abs((theta1-theta)/(theta2-theta1))*value22;
            value=value1_t+value2_t;
        end
    else
        if theta2==theta1
            value1_t=abs((r2-r)/(r2-r1))*value11;
            value2_t=abs((r1-r)/(r2-r1))*value22;
            value=value1_t+value2_t;
        else
            value11_t=abs((r2-r)*(theta2-theta)/((r2-r1)*(theta2-theta1)))*value11;
            value12_t=abs((r2-r)*(theta1-theta)/((r2-r1)*(theta2-theta1)))*value12;
            value21_t=abs((r1-r)*(theta2-theta)/((r2-r1)*(theta2-theta1)))*value21;
            value22_t=abs((r1-r)*(theta1-theta)/((r2-r1)*(theta2-theta1)))*value22;
            value=value11_t+value12_t+value21_t+value22_t;
        end
    end
    
end

