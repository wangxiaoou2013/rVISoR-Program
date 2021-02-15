function PSF = point_spread_to_lens(k,U_0,point_x,point_y,lens_x,lens_y,z)
%POINT_SPREAD_TO_LENS Light field distribution from point to lens
x=lens_x-point_x;
y=lens_y-point_y;
r=sqrt(x.^2+y.^2+z^2);
PSF=1./r*U_0.*exp(1i*k*r);
end

