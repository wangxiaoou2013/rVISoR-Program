function img_out = img_cut(img,y0_2,width)
%TUBE_CUT delete the zone which is out of the tube
[~,X]=size(img);
width_half=width/2;

center_position=round(y0_2);
up_position=center_position-width_half;
down_position=center_position+width_half-1;

img_corrected=zeros(width,X-10);
img_corrected(:,:)=im2double(img(up_position:down_position,6:X-5));
img_out=im2uint16(img_corrected);
end

