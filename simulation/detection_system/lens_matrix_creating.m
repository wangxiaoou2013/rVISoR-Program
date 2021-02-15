function [lens,xx,yy] = lens_matrix_creating(k,f,radius,dx)
%LENS_MATRIX_CREATING matrix for lens
d=2*radius;
d_num=d/dx;
x=((1:d_num)-(1+d_num)/2)*dx;
y=x;
[xx,yy]=meshgrid(x,y);
r=sqrt(xx.^2+yy.^2);
lens=exp(-1i*k/2/f*r.^2);
lens(r>radius)=0;
end

