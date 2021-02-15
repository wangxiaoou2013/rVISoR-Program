%main function, to reconstruction rotational image without distortion to 3D
%image stack
clear; close all;

filename='Raw.test.tif';
savename='Raw_reconstruction\Bicubic\tif\Raw.reconstruction.';

cyl_slice_num=309;
angle_num=cyl_slice_num;

[d_num,cart_slice_num]=size(imread(filename,1));

img=zeros(d_num,cart_slice_num,angle_num);


str='Reading...';
bar1=waitbar(0,str);
disp(str);

progress_temp=0;

for i=1:1:cyl_slice_num
   img(:,:,i)=im2double(imread(filename,i));
   progress=round(i/cyl_slice_num*100);
   str=['Reading...(',num2str(progress),'%)'];
   if progress>=progress_temp
       progress_temp=progress_temp+1;
       disp(str);
   end
   waitbar(i/cyl_slice_num,bar1,str);
end
close(bar1);

begin=1;
%len=cart_slice_num;
len=cart_slice_num;

bar2=waitbar(0,'Reconstructing...');

for i=begin:1:begin+len-1
    tic
    str=['Reconstructing...(',num2str(i),'/',num2str(cart_slice_num),' ',num2str(round(i/cart_slice_num*100)),'%)'];
    disp(str);
    waitbar(i/cart_slice_num,bar2,str);
    slice_pol=zeros(angle_num,d_num);
    for j=1:1:angle_num
        slice_pol(j,:)=img(:,i,j);
    end
    [slice_cart,temp_matrix]=img_pol2cart(slice_pol);
%     if i==begin
%         imwrite(im2uint16(slice_cart),savename);
%     else
%         imwrite(im2uint16(slice_cart),savename,'WriteMode','append');
%     end
    name_str=[savename,num2str(i,'%04d'),'.tif'];
    imwrite(im2uint16(slice_cart),name_str);
    toc
end
close(bar2);
