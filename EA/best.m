
function [bestindividual, bestfit, mean_fitvalue] = best(newpop,fitvalue)
[px,py] = size(newpop);
bestindividual = newpop(1,:);
bestfit = fitvalue(1);
for i = 2:px
    if fitvalue(i)>bestfit
        bestindividual = newpop(i,:);
        bestfit = fitvalue(i);
    end
end
mean_fitvalue = mean(fitvalue);