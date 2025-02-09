function [Time_series_predict,LagEffect,Beta_LagTerm]=Parameter_estimation(T_0,T_e,L1,L2,Time_series,lag_term,AR_Order,s)

X_sequence=(1:T_e);
T_b=0;

%% 参数调节
T_1=T_0-L1;% 首个柱子所对应的坐标
L=L1+L2;% 干预效应持续时间长度 %lag_rang
T_2=T_0+L2;

lag_term_PD=lag_term((T_1+1):(T_2),:);
%%
PD_U=lag_term_PD(:,2);
PD_ND=lag_term_PD(:,3);
PD_LND=lag_term_PD(:,4);
PD_LNFD=lag_term_PD(:,5);
%%

[Time_series_predict_U,LagEffect_U,Beta_LagTerm_U]=Lag_effect_Indentification(T_1,L,T_2,T_e,PD_U,AR_Order,Time_series,T_0,'r',s);

[Time_series_predict_ND,LagEffect_ND,Beta_LagTerm_ND]=Lag_effect_Indentification(T_1,L,T_2,T_e,PD_ND,AR_Order,Time_series,T_0,'m',s);

[Time_series_predict_LND,LagEffect_LND,Beta_LagTerm_LND]=Lag_effect_Indentification(T_1,L,T_2,T_e,PD_LND,AR_Order,Time_series,T_0,'b',s);

[Time_series_predict_LNFD,LagEffect_LNFD,Beta_LagTerm_LNFD]=Lag_effect_Indentification(T_1,L,T_2,T_e,PD_LNFD,AR_Order,Time_series,T_0,'g',s);

%%
LagEffect=[LagEffect_U,LagEffect_ND,LagEffect_LND,LagEffect_LNFD];
Time_series_predict=[Time_series_predict_U Time_series_predict_ND Time_series_predict_LND Time_series_predict_LNFD];
Beta_LagTerm=[Beta_LagTerm_U,Beta_LagTerm_ND,Beta_LagTerm_LND,Beta_LagTerm_LNFD]';

end