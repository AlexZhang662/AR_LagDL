function [x_axis,PDF_y,DF_y]=Uniform_distribution(L,T_1,T_b,T_e)
%% 均匀分布



x_L= (T_1:0.01:(T_1+L))';
PDF_L=unifpdf(x_L,T_1,(T_1+L));% legend('\sigma = 0.5','\sigma = 2' )
DF_L=unifcdf(x_L,T_1,(T_1+L));% plot(x,f_1,'r-',x,F_1,'r-.','linewidth',1.5);


x_pre=(T_b:0.01:T_1)';PDF_pre=zeros(length(x_pre),1);DF_pre=zeros(length(x_pre),1);% 滞后期 前后 取值
x_post=((T_1+L):0.01:T_e)';PDF_post=zeros(length(x_post),1);DF_post=ones(length(x_post),1);


x_axis=[x_pre ;x_L; x_post];
PDF_y=[PDF_pre ;PDF_L ;PDF_post];
DF_y=[DF_pre ;DF_L; DF_post];

