function [Structure_out,Structure]=Lag_DF_senario(T_0,T_e,Advance_length,Lag_length)
% s=10;
T_b=0;% 时间范围开始点 基本上没有变化
% T_e=30;% 时间范围结束点
%% 参数调节
T_1=T_0-Advance_length;% Initial change point 初始变化点 begin_point
L=Advance_length+Lag_length;% 干预效应持续时间长度 %lag_rang
%% 提取PDF的权重结构
[x_axis,PDFF_y_U,DF_y_U]=Uniform_distribution(L,T_1,T_b,T_e);
[x_axis,PDFF_y_ND,DF_y_ND]=Normal_distribution(L,T_1,T_b,T_e);
[x_axis,PDFF_y_LND,DF_y_LND]=logarithmic_normal_distribution(L,T_1,T_b,T_e);
[x_axis,PDFF_y_LNFD,DF_y_LNFD]=logarithmic_normal_distribution_Flip(L,T_1,T_b,T_e);
%% 输出序列
Structure=[x_axis,PDFF_y_U,PDFF_y_ND,PDFF_y_LND,PDFF_y_LNFD,DF_y_U,DF_y_ND,DF_y_LND,DF_y_LNFD];
Structure_out=[];count=1;
for i=1:length(x_axis)
    if x_axis(i)==count
        Structure_out=[Structure_out;Structure(i,:)];
        count=count+1;
    else
    end
end

%% 其概率密度分布示意图 3*1 并且有PDF(...)标记

figure()
subplot(4,1,1)
plot(Structure(:,1),Structure(:,2),'-r','linewidth',2,'MarkerSize',1);
hold on
bar(Structure_out(:,1),Structure_out(:,2),0.2,'r')
hold on
P_y =1.2*max([max(PDFF_y_LND),max(PDFF_y_ND),max(PDFF_y_U)]); %5为在2点的y值
plot([T_0,T_0],[0,P_y ],'k-.','linewidth',2.5);
hold on
xlim([T_1-2 T_1+L+2])
ylim([0 P_y])
set(gca,'xtick',[T_1 T_0  T_1+L],'xticklabel',{'T_1'  'T_0' 'T_2'})
text(T_1+1,Structure_out(T_1+1,2),'PDF_{UD}(1)','FontSize',8,...
    'HorizontalAlignment','center',...
    'VerticalAlignment','bottom');
text(T_1+2,Structure_out(T_1+2,2),'PDF_{UD}(2)','FontSize',8,...
    'HorizontalAlignment','center',...
    'VerticalAlignment','bottom');
text(T_1+L-1,Structure_out(T_1+L-1,2),'PDF_{UD}(L-1)','FontSize',8,...
    'HorizontalAlignment','center',...
    'VerticalAlignment','bottom');
text(T_1+L,Structure_out(T_1+L,2),'PDF_{UD}(L)','FontSize',8,...
    'HorizontalAlignment','center',...
    'VerticalAlignment','bottom');
% ylabel('Effect');
title('UD');
hold off

subplot(4,1,2)
plot(Structure(:,1),Structure(:,3),'-m','linewidth',2,'MarkerSize',1);
hold on
bar(Structure_out(:,1),Structure_out(:,3),0.2,'m')
hold on
P_y =1.2*max([max(PDFF_y_LND),max(PDFF_y_ND),max(PDFF_y_U)]); %5为在2点的y值
plot([T_0,T_0],[0,P_y ],'k-.','linewidth',2.5);
hold on
xlim([T_1-2 T_1+L+2])
ylim([0 P_y])
set(gca,'xtick',[T_1 T_0  T_1+L],'xticklabel',{'T_1'  'T_0' 'T_2'})
text(T_1+1,Structure_out(T_1+1,3),'PDF_{ND}(1)','FontSize',8,...
    'HorizontalAlignment','center',...
    'VerticalAlignment','bottom');
text(T_1+2,Structure_out(T_1+2,3),'PDF_{ND}(2)','FontSize',8,...
    'HorizontalAlignment','center',...
    'VerticalAlignment','bottom');
text(T_1+L-1,Structure_out(T_1+L-1,3),'PDF_{ND}(L-1)','FontSize',8,...
    'HorizontalAlignment','center',...
    'VerticalAlignment','bottom');
text(T_1+L,Structure_out(T_1+L,3),'PDF_{ND}(L)','FontSize',8,...
    'HorizontalAlignment','center',...
    'VerticalAlignment','bottom');
% ylabel('Effect');
title('ND');
hold off

subplot(4,1,3)
plot(Structure(:,1),Structure(:,4),'-b','linewidth',2,'MarkerSize',1);
hold on
bar(Structure_out(:,1),Structure_out(:,4),0.2,'b')
hold on
P_y =1.2*max([max(PDFF_y_LND),max(PDFF_y_ND),max(PDFF_y_U)]); %5为在2点的y值
plot([T_0,T_0],[0,P_y ],'k-.','linewidth',2.5);
hold on
set(gca,'xtick',[T_1 T_0  T_1+L],'xticklabel',{'T_1'  'T_0' 'T_2'})
text(T_1+1,Structure_out(T_1+1,4),'PDF_{LND}(1)','FontSize',8,...
    'HorizontalAlignment','center',...
    'VerticalAlignment','bottom');
text(T_1+2,Structure_out(T_1+2,4),'PDF_{LND}(2)','FontSize',8,...
    'HorizontalAlignment','center',...
    'VerticalAlignment','bottom');
text(T_1+L-1,Structure_out(T_1+L-1,4),'PDF_{ND}(L-1)','FontSize',8,...
    'HorizontalAlignment','center',...
    'VerticalAlignment','bottom');
text(T_1+L,Structure_out(T_1+L,4),'PDF_{LND}(L)','FontSize',8,...
    'HorizontalAlignment','center',...
    'VerticalAlignment','bottom');
xlim([T_1-2 T_1+L+2])
ylim([0 P_y])
% ylabel('Effect');
title('LND');
hold off

subplot(4,1,4)
plot(Structure(:,1),Structure(:,5),'-g','linewidth',2,'MarkerSize',1);
hold on
bar(Structure_out(:,1),Structure_out(:,5),0.2,'g')
hold on
P_y =1.2*max([max(PDFF_y_LND),max(PDFF_y_ND),max(PDFF_y_U)]); %5为在2点的y值
plot([T_0,T_0],[0,P_y ],'k-.','linewidth',2.5);
hold on
xlim([T_1-2 T_1+L+2])
ylim([0 P_y])
set(gca,'xtick',[T_1 T_0  T_1+L],'xticklabel',{'T_1'  'T_0' 'T_2'})
text(T_1+1,Structure_out(T_1+1,5),'PDF_{LNFD}(1)','FontSize',8,...
    'HorizontalAlignment','center',...
    'VerticalAlignment','bottom');
text(T_1+2,Structure_out(T_1+2,5),'PDF_{LNFD}(2)','FontSize',8,...
    'HorizontalAlignment','center',...
    'VerticalAlignment','bottom');
text(T_1+L-1,Structure_out(T_1+L-1,5),'PDF_{LNFD}(L-1)','FontSize',8,...
    'HorizontalAlignment','center',...
    'VerticalAlignment','bottom');
text(T_1+L,Structure_out(T_1+L,5),'PDF_{LNFD}(L)','FontSize',8,...
    'HorizontalAlignment','center',...
    'VerticalAlignment','bottom');
% ylabel('Effect');
title('LNFD');
hold off





end