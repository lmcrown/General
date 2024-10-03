function [data_mean,data_SEM]=plot_mean_SEM(xvals,data,dim,color)
%COLOR IS IN RGB
%dim is dimension to take mean and std from

data_mean = nanmean(data,dim);                           
data_SEM = nanstd(data,[],dim)/sqrt(size(data,dim));       

plot(xvals, data_mean,'LineWidth',2,'Color',color)
hold on
plot(xvals, data_mean+data_SEM,'LineWidth',0.5,'Color',color)
hold on
plot(xvals, data_mean-data_SEM,'LineWidth',0.5,'Color',color)

