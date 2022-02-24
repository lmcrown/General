function [me,se]=bar_plot_with_p_rm_outliers(variable,index1, index2,variable_name)

long=max(sum(index1),sum(index2));
nanmatrix=nan(long,2);
dataset=nanmatrix;
dataset(1:sum(index1),1)=variable(index1);
dataset(1:sum(index2),2)=variable(index2);
ix1=isoutlier(dataset(:,1),'grubbs');
ix2=isoutlier(dataset(:,2),'grubbs');
dataset(ix1,1)=nan;
dataset(ix2,2)=nan;
try
    h1 = adtest(dataset(:,1));
    h2= adtest(dataset(:,2));
catch
    long=max(sum(index1),sum(index2));
    nanmatrix=nan(long,2);
    dataset=nanmatrix;
    dataset(1:sum(index1),1)=variable(index1);
    dataset(1:sum(index2),2)=variable(index2);
    disp('something was an outlier but makes AD test not ok')
    [~,p,~,stats]=ttest2(dataset(:,1),dataset(:,2),'Vartype','unequal');
    h1=0;
end

if h1==1 && h2==1
    [p,~,stats]=ranksum(dataset(:,1),dataset(:,2));
    U=stats.ranksum;
    par='non-par';
    d=cliffs_delta(dataset(:,1),dataset(:,2));

else
    d = computeCohen_d(dataset(:,1), dataset(:,2));
    [~,p,~,stats]=ttest2(dataset(:,1),dataset(:,2),'Vartype','unequal');
    par='par';
end
figure
Error_bars(dataset)
title(sprintf('%s p= %2.4f d= %2.3f %s',variable_name,p,d,par))
title(sprintf('%s p= %2.4f %s',variable_name,p,par))

% set(gca,'XTickLabel',{'WT' 'LRRK'})
% ylabel('seconds')
set(gca,'XLim',[0.5 2.5])
set(gca,'FontName','Arial')
set(gca,'FontSize',14)


isout1=sum(ix1);
isout2=sum(ix2);
fprintf('excluded %1.0f from first group and %1.0f from second group \n',isout1,isout2)

se = Sem(dataset);
me=nanmean(dataset,1);

