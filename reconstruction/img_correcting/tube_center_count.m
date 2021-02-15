function tube_center_y = tube_center_count(bw)
%TUBE_CENTER_COUNT Find the center axis of the tube from image
[Y,X]=size(bw);

tube_center_y=zeros(1,X-20);

for x=11:X-10
    count=0;
    sum_y=0;
    for y=11:Y-10
        if bw(y,x)==1
            count=count+1;
            sum_y=sum_y+y;
        end
    end
    tube_center_y(1,x-10)=sum_y/count;
end
end

