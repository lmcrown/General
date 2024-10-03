function bar_plot_with_p_4wayanova(group1,group2,group3,group4, variable_name)

long=max([length(group1),length(group2),length(group3),length(group4)]);
nanmatrix=nan(long,4);
dataset=nanmatrix;
dataset(1:length(group1),1)=group1;
dataset(1:length(group2),2)=group2;
dataset(1:length(group3),3)=group3;
dataset(1:length(group4),4)=group4;
ix1=isoutlier(dataset(:,1),'grubbs');
ix2=isoutlier(dataset(:,2),'grubbs');
ix3=isoutlier(dataset(:,3),'grubbs');
ix4=isoutlier(dataset(:,4),'grubbs');
dataset(ix1,1)=nan;
dataset(ix2,2)=nan;
dataset(ix3,3)=nan;
dataset(ix4,4)=nan;

h1 = adtest(dataset(:,1));
h2= adtest(dataset(:,2));
h3 = adtest(dataset(:,3));
h4= adtest(dataset(:,4));

if (h1+h2+h3+h4)>2
    [p,anovatab,stats] = kruskalwallis(dataset);
    par='non-par';
    disp(anovatab)

else
M = [];C = [];
par='par';
for ii = 1:4
    M = [M ;dataset(:,ii)];
    C = [C; ones(Rows(dataset),1)*ii];
end
GIX = ~isnan(M);
M = M(GIX);
C = C(GIX);
[p,tbl,stats]=anovan(M,C);
[c]=multcompare(stats,'CType','hsd')

% d1 = computeCohen_d(dataset(~ix1,1), dataset(~ix2,2));
% d2 = computeCohen_d(dataset(~ix3,3),dataset(~ix4,4));
end
figure
Error_bars(dataset)
title(sprintf('%s p= %2.3f %s',variable_name,p,par))
set(gca,'Position',[0.1689    0.1100    0.7361    0.8150]) %this i just set because it seemed like a good one
set(gca,'FontName','Arial')
set(gca,'FontSize',16)
set(gca,'XLim',[0.5 4.5])


% ix=isnan(variable)
isout1=sum(ix1);
isout2=sum(ix2);
isout3=sum(ix3);
isout4=sum(ix4);
fprintf('excluded %1.0f from first group and %1.0f from second group  %1.0f from third group and %1.0f from fourth group\n',isout1,isout2, isout3, isout4)
disp(tbl)