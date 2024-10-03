function Plot_SEM(PARAM,M1,M2,isM1,isM2,dbcorrect)
%Pass in the PARAM- which should have PARAM.frex
%Vect 1 and 2 are the full matrix of things you want the power for with
%trials as rows and frequencies as cols
%isVect1 and isVect2 are strings that will populate the title and legend
if nargin<5
    dbcorrect=false;
end

if dbcorrect==true
    db1=10*log10(M1);
    db2=10*log10(M2);
elseif dbcorrect==false
    db1=M1;
    db2=M2;
end

figure;
plot(PARAM.frex, mean(db1),'r','LineWidth',3)
hold on;
plot(PARAM.frex,mean(db2),'b','LineWidth',3);
semL=std(db1(:))/sqrt(Cols(db1));  %is this right- should the SEM be just one number?
hold on;
plot(PARAM.frex,(mean(db1)+semL),'r');
hold on;
plot(PARAM.frex,(mean(db1)-semL),'r')
hold on;

semH=std(db2(:))/sqrt(Cols(db2));
plot(PARAM.frex,(mean(db2)+semH),'b')
hold on;
plot(PARAM.frex,(mean(db2)-semH),'b')
axis tight
legend(isM1,isM2)
pubify_figure_axis
title([isM1 ' vs ' isM2])
xlabel('Frequency')
ylabel('Power')
set(gca,'fontsize',20)