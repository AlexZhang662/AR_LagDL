
function [x_axis,PDF_y,DF_y]=Normal_distribution(L,T_1,T_b,T_e)



%%
sigma=L/6;
mu=T_1+3*sigma;

advance_cut=T_1;% 滞后期取值
x_L=(T_1:0.01:(L+T_1))';
PDF_L=normpdf(x_L,mu,sigma);
DF_L = normcdf(x_L,mu,sigma)-normcdf(T_1,mu,sigma);

x_pre=(T_b:0.01:T_1)';PDF_pre=zeros(length(x_pre),1);DF_pre=zeros(length(x_pre),1);% 滞后期 前后 取值
x_post=((T_1+L):0.01:T_e)';PDF_post=zeros(length(x_post),1);DF_post=ones(length(x_post),1);


x_axis=[x_pre;x_L; x_post];
PDF_y=[PDF_pre;PDF_L ;PDF_post];
DF_y=[DF_pre;DF_L; DF_post];


