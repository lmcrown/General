function bar_plot_with_p_publish_updated(variable,index1, index2,variable_name,exclude_outlier)

if nargin<5
    exclude_outlier=false;
end

long=max(sum(index1),sum(index2));
nanmatrix=nan(long,2);
dataset=nanmatrix;
dataset(1:sum(index1),1)=variable(index1);
dataset(1:sum(index2),2)=variable(index2);

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
    zval=stats.zval;
    par='non-par';
    d=cliffs_delta(dataset(:,1),dataset(:,2));

else
    ix1=isoutlier(dataset(:,1),'grubbs');
    ix2=isoutlier(dataset(:,2),'grubbs');
    dataset(ix1,1)=nan;
    dataset(ix2,2)=nan;
    d = computeCohen_d(dataset(:,1), dataset(:,2));
    [~,p,~,stats]=ttest2(dataset(:,1),dataset(:,2),'Vartype','unequal');
    st=stats.tstat;
    df=stats.df;
    par='par';
    isout1=sum(ix1);
isout2=sum(ix2);
fprintf('excluded %1.0f from first group and %1.0f from second group \n',isout1,isout2)
end
% figure
if exclude_outlier==1
    ix1=isoutlier(dataset(:,1),'grubbs');
    ix2=isoutlier(dataset(:,2),'grubbs');
    dataset(ix1,1)=nan;
    dataset(ix2,2)=nan;
end
Error_bars(dataset)
title(sprintf('%s p= %2.4f d= %2.3f %s',variable_name,p,d,par))
%  set(gca,'XTickLabel',{'WT' 'LRRK'})
%  ylabel('seconds')
set(gca,'XLim',[0.5 2.5])
set(gcf,'Position',[1146         488         290         420]) %this i just set because it seemed like a good one
set(gca,'FontName','Arial')
set(gca,'FontSize',14)



if strcmp( par,'par')
sprintf('Test statistic %2.3f df %2.3f p= %2.3f d= %2.3f', st, df, p, d)
end

if strcmp(par, 'non-par')
  sprintf('Ranksum %2.3f zval %2.3f p= %2.3f d= %2.3f', U, zval, p, d)
end
  