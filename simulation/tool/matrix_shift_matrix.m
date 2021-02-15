function m2 = matrix_shift_matrix(m1,m2)
%MATRIX_SHIFT_MATRIX Shift matrix to the center
[y,x]=size(m1);
[Y,X]=size(m2);
if Y>y
    m2((1+(Y-y)/2):(Y-(Y-y)/2),(1+(X-x)/2):(X-(X-x)/2))=m1;
else
    m2(:,:)=m1((1+(y-Y)/2):(y-(y-Y)/2),(1+(x-X)/2):(x-(x-X)/2));
end
end

