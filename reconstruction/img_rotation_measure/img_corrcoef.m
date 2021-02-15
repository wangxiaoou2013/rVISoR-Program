function value = img_corrcoef(img1,img2)
%IMG_CORRCOEF Get the whole correlation coefficient of two images
[Y,~]=size(img1);
img2_t=img2(Y:(-1):1,:);
value_matrix_1=corrcoef(img1,img2);
value_matrix_2=corrcoef(img1,img2_t);
value_1=min(value_matrix_1(:));
value_2=min(value_matrix_2(:));
value=max(value_1,value_2);
end

