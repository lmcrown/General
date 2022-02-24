function [] = errorpatch(x,Data,varargin)
%errorpatch(x,Data,color)
% x is a vector of x values just like plot(x,y)
% Data is a matrix of data - dimension 1 is variability dimension; dimension
% 2 is x dimension.
% color is a color string, for example 'k' or 'g'

if ~isempty(varargin)
    color = varargin{1};
else
    color = 'k';
end
        
Dm = nanmean(Data,1);
Dse = nanstd(Data,0,1)./sqrt(size(Data,1));
patch([x,fliplr(x)],[Dm+Dse/2,fliplr(Dm-Dse/2)],color,'facecolor',color,'facealpha',.5)
hold on
h1 = plot(x,Dm,'k','linewidth',2);

plot(x,Dm-Dse/2,'k--');
plot(x,Dm+Dse/2,'k--');

end

