function U_output = RS_diffraction_integration(k,U_0,xx,yy,z)
%RS_DIFFRACTION_INTEGRATION Doing Rayleigh-Sommerfeld diffraction integral
    [y_aim,x_aim]=size(xx);
    [y_org,x_org]=size(U_0);
    x_ext(1:x_aim)=xx(1)-xx(1,x_aim:(-1):1);
    y_ext(1:y_aim)=yy(1)-(yy(y_aim:(-1):1,1))';
    x_ext((x_aim+1):(x_aim*2))=-x_ext(x_aim:(-1):1);
    y_ext((y_aim+1):(y_aim*2))=-y_ext(y_aim:(-1):1);
    [xx_ext,yy_ext]=meshgrid(x_ext,y_ext);
    
    delta_size=abs([y_aim,x_aim]-[y_org,x_org]);
    t=max(delta_size);
    if t==0
        U_0_shift=U_0;
    else
        U_0_shift=zeros(y_aim,x_aim);
        U_0_shift((1+(y_aim-y_org)/2):(y_aim-(y_aim-y_org)/2),(1+(x_aim-x_org)/2):(x_aim-(x_aim-x_org)/2))=U_0;
    end
    
    rr=sqrt(xx_ext.^2+yy_ext.^2+z^2);
    G=1/(2*pi).*exp(1i*k*rr)./rr.^2*z.*(1./rr-1i*k);
    
    U_0_input=zeros(size(xx_ext));
    
    U_0_input((1:y_aim)+y_aim/2,(1:x_aim)+x_aim/2)=U_0_shift;
    
    fft_U=fft2(U_0_input);fft_G=fft2(G);
    fft_U_output=fft_U.*fft_G;
    U_output_ext=fftshift(ifft2(fft_U_output));
    U_output=U_output_ext((1:y_aim)+y_aim/2,(1:x_aim)+x_aim/2);
    
end

