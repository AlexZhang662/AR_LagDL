function [Time_series_predict,Time_series_LagEffect,Beta_LagTerm]=Lag_effect_Indentification(T_1,L,T_2,T_e,PD_Inclusion,AR_Order,Time_series,T_0,plot_color,s)
% PD_Inclusion
T_b=0;
T_e=length(Time_series);


%% P_1的构建
P_1=zeros(T_1,s);
%% P_2的构建，最关键的部分
P_2=zeros((L+s),s);
for i=1:s
    P_2(i:(i+L-1),i)=PD_Inclusion;
end
%%  P_3的构建
P_3=zeros(T_e-T_1-L-s,s);
%% 合并形成整个的矩阵P
P=[P_1;P_2; P_3];
%% AR_O ARIMA中AR部分阶数 
% Time_series
AR_part=zeros(T_e,AR_Order);

for i=1:T_e % 该部分的算法思维是横行填充
    for j=1:AR_Order
        if i-j<1
            continue;
        else
            AR_part(i,j)=Time_series(i-j);
        end
    end
end

%%
X=[AR_part P];%处理矩阵的多重共线性
%%

det_XT_X=det((X')*X);%
I=eye(AR_Order+s);%(多重共线性), 

ridge_trace_matrix=[];
X_axis_L=[];
determinant_matrix=[];
MSE =[];

for i=0.001:0.001:1
    
    alpha=i;
    
    Ridge_Return=X'*X+alpha*I; % 岭回归矩阵
    
    Beta=inv(Ridge_Return)*X'*Time_series;% 估计参数(Φ W )
%     Beta = Ridge_Return \ (X' * Time_series);

    ridge_trace_matrix=[ridge_trace_matrix,Beta]; % 逐步估计，系数的估计值
    
    X_axis_L=[X_axis_L,i];
    
    determinant_matrix=[determinant_matrix det(Ridge_Return)]; % 逐步估计，岭回归矩阵的行列式的值
    

    if det((X')*X+alpha*I)>0.1 %其标准
        break;
    end
    
end



ARIMA_Beta=Beta(1:AR_Order); % 自回归AR的系数估计值
Beta_LagTerm=Beta((AR_Order+1):end); % 自回归AR的系数估计值

Time_series_LagEffect=P*Beta_LagTerm;

Time_series_predict=X*Beta;
%%
switch plot_color
    case 'r'
        % 当 expression 等于 value1 时执行
        Distribution_pattern = ' Uniform Distribution';
    case 'm'
        % 当 expression 等于 value2 时执行
        Distribution_pattern = ' Normal Distribution';
    case 'b'
        % 当 expression 等于 value2 时执行
        Distribution_pattern = ' Log-normal Distribution';
    otherwise
        % 当 expression 不等于任何指定的值时执行
        Distribution_pattern = ' Log-normal Flip Distribution';
end

%% 画出其效应的估计值，以及 岭迹图，正文中的Fig4
figure()% 岭迹图
subplot(2,2,1)
plot(X_axis_L,ridge_trace_matrix(2:end,:));
plot(X_axis_L,ridge_trace_matrix);
title('Ridge trace')
xlabel('\alpha');ylabel('Coefficient value');
subplot(2,2,2)
bar(X_axis_L,determinant_matrix,0.6,'FaceColor',[0 .5 .5],'EdgeColor',[0 .9 .9],'LineWidth',1);
xlabel('\alpha');ylabel('Value');
title('The determinant of X^T X+\alphaE')
subplot(2,2,[3,4])% 岭迹图
bar(Time_series_LagEffect,plot_color);
hold on
P_y =1.2*max(abs(Time_series_LagEffect)); %5为在2点的y值
plot([T_0,T_0],[-P_y,P_y ],'k-.','linewidth',2.5);
set(gca,'xtick',[T_1 T_2 T_2+s],'xticklabel',{'T_1' 'T_2' 'T_2+s'})
xlim([T_b T_e])
ylim([-P_y P_y])
ylabel('Impact size');
hold off
title_name = strcat('Intervention Impacts for ', ' ', Distribution_pattern );
title(title_name)



%% 计算拟合值

Time_series_predict=X*Beta;
%%

y_test =Time_series;
y_pred =Time_series_predict;

% 计算误差指标
metrics.MSE = mean((y_test - y_pred).^2);
metrics.MAE = mean(abs(y_test - y_pred));
metrics.RMSE = sqrt(metrics.MSE);


end