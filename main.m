clc;clear;
Time_series=xlsread('Test_series.xlsx','Sheet1');
Time_series=Time_series(:,2);
T_e=length(Time_series);

%% ARIMA_DL ��������
AR_Order=2;
s=10;%��ʾ�ͺ���صĽ���
%% % Nominal changing point ��ԤЧӦ����ǰ���һ����
T_0=48; 
%% ��ȡl1��l2
l1=6; % l1
l2=6; %l2

%%  
[Structure_out,Structure]=Lag_DF_senario(T_0,T_e,l1,l2);

[Time_series_predict,LagEffect,Beta_LagTerm]=Parameter_estimation(T_0,T_e,l1,l2,Time_series,Structure_out(:,1:5),AR_Order,s);


