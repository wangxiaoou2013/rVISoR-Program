function bw_out = img_clean(bw)
%IMG_REPAIR clean the noise point of the image
[Y,X]=size(bw);
bw_out=bw;

for y=11:Y-10
    for x=11:X-10
        if bw(y,x)==1
            sum_matrix=zeros(21);
            sum_matrix(:,:)=bw(y-10:y+10,y-10:y+10);
            count=sum(sum_matrix,'all');
            if count<100
                bw_out(y,x)=0;
            end
        end
        if bw(y,x)==0
            sum_matrix=zeros(21);
            sum_matrix(:,:)=bw(y-10:y+10,y-10:y+10);
            count=441-sum(sum_matrix,'all');
            if count<100
                bw(y,x)=1;
            end
        end
    end
end

end

