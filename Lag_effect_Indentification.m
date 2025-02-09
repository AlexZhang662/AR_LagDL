function [Time_series_predict,Time_series_LagEffect,Beta_LagTerm]=Lag_effect_Indentification(T_1,L,T_2,T_e,PD_Inclusion,AR_Order,Time_series,T_0,plot_color,s)
% PD_Inclusion
T_b=0;
T_e=length(Time_series);


%% P_1�Ĺ���
P_1=zeros(T_1,s);
%% P_2�Ĺ�������ؼ��Ĳ���
P_2=zeros((L+s),s);
for i=1:s
    P_2(i:(i+L-1),i)=PD_Inclusion;
end
%%  P_3�Ĺ���
P_3=zeros(T_e-T_1-L-s,s);
%% �ϲ��γ������ľ���P
P=[P_1;P_2; P_3];
%% AR_O ARIMA��AR���ֽ��� 
% Time_series
AR_part=zeros(T_e,AR_Order);

for i=1:T_e % �ò��ֵ��㷨˼ά�Ǻ������
    for j=1:AR_Order
        if i-j<1
            continue;
        else
            AR_part(i,j)=Time_series(i-j);
        end
    end
end

%%
X=[AR_part P];%�������Ķ��ع�����
%%

det_XT_X=det((X')*X);%
I=eye(AR_Order+s);%(���ع�����), 

ridge_trace_matrix=[];
X_axis_L=[];
determinant_matrix=[];
MSE =[];

for i=0.001:0.001:1
    
    alpha=i;
    
    Ridge_Return=X'*X+alpha*I; % ��ع����
    
    Beta=inv(Ridge_Return)*X'*Time_series;% ���Ʋ���(�� W )
%     Beta = Ridge_Return \ (X' * Time_series);

    ridge_trace_matrix=[ridge_trace_matrix,Beta]; % �𲽹��ƣ�ϵ���Ĺ���ֵ
    
    X_axis_L=[X_axis_L,i];
    
    determinant_matrix=[determinant_matrix det(Ridge_Return)]; % �𲽹��ƣ���ع���������ʽ��ֵ
    

    if det((X')*X+alpha*I)>0.1 %���׼
        break;
    end
    
end



ARIMA_Beta=Beta(1:AR_Order); % �Իع�AR��ϵ������ֵ
Beta_LagTerm=Beta((AR_Order+1):end); % �Իع�AR��ϵ������ֵ

Time_series_LagEffect=P*Beta_LagTerm;

Time_series_predict=X*Beta;
%%
switch plot_color
    case 'r'
        % �� expression ���� value1 ʱִ��
        Distribution_pattern = ' Uniform Distribution';
    case 'm'
        % �� expression ���� value2 ʱִ��
        Distribution_pattern = ' Normal Distribution';
    case 'b'
        % �� expression ���� value2 ʱִ��
        Distribution_pattern = ' Log-normal Distribution';
    otherwise
        % �� expression �������κ�ָ����ֵʱִ��
        Distribution_pattern = ' Log-normal Flip Distribution';
end

%% ������ЧӦ�Ĺ���ֵ���Լ� �뼣ͼ�������е�Fig4
figure()% �뼣ͼ
subplot(2,2,1)
plot(X_axis_L,ridge_trace_matrix(2:end,:));
plot(X_axis_L,ridge_trace_matrix);
title('Ridge trace')
xlabel('\alpha');ylabel('Coefficient value');
subplot(2,2,2)
bar(X_axis_L,determinant_matrix,0.6,'FaceColor',[0 .5 .5],'EdgeColor',[0 .9 .9],'LineWidth',1);
xlabel('\alpha');ylabel('Value');
title('The determinant of X^T X+\alphaE')
subplot(2,2,[3,4])% �뼣ͼ
bar(Time_series_LagEffect,plot_color);
hold on
P_y =1.2*max(abs(Time_series_LagEffect)); %5Ϊ��2���yֵ
plot([T_0,T_0],[-P_y,P_y ],'k-.','linewidth',2.5);
set(gca,'xtick',[T_1 T_2 T_2+s],'xticklabel',{'T_1' 'T_2' 'T_2+s'})
xlim([T_b T_e])
ylim([-P_y P_y])
ylabel('Impact size');
hold off
title_name = strcat('Intervention Impacts for ', ' ', Distribution_pattern );
title(title_name)



%% �������ֵ

Time_series_predict=X*Beta;
%%

y_test =Time_series;
y_pred =Time_series_predict;

% �������ָ��
metrics.MSE = mean((y_test - y_pred).^2);
metrics.MAE = mean(abs(y_test - y_pred));
metrics.RMSE = sqrt(metrics.MSE);


end