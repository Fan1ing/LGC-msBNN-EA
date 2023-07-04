
%input：pop
%output：newpop
function [newpop] = crossover(pop,pc)

[px,py] = size(pop);
newpop = ones(size(pop));
%SELF crossover
for i = 1:1:px
    if(rand<pc)
        cpoint = randi([1,6]);
        newpop(i,1:7) = [pop(i,cpoint+1:7),pop(i,1:cpoint)];
    else
        newpop(i,1:7) = pop(i,1:7);
    end
end
for i = 1:1:px-1
    if(rand<pc)
        cpoint = randi([8,15]);
        newpop(i,8:16) = [pop(i,cpoint+1:16),pop(i,8:cpoint)];
    else
        newpop(i,8:16) = pop(i,8:16);
    end
end
for i = 1:1:px-1
    if(rand<pc)
        cpoint = randi([17,28]);
        newpop(i,17:28) = [pop(i,cpoint+1:28),pop(i,17:cpoint)];
    else
        newpop(i,17:28) = pop(i,17:28);
    end
end
%Interpersonal crossover
for i = 1:2:px-1
    if(rand<pc)
        cpoint = randi([1,6]);
        newpop(i,1:7) = [pop(i,1:cpoint),pop(i+1,cpoint+1:7)];
        newpop(i+1,1:7) = [pop(i+1,1:cpoint),pop(i,cpoint+1:7)];
    else
        newpop(i,1:7) = pop(i,1:7);
        newpop(i+1,1:7) = pop(i+1,1:7);
    end
end
for i = 1:2:px-1
    if(rand<pc)
        cpoint = randi([8,15]);
        newpop(i,8:16) = [pop(i,8:cpoint),pop(i+1,cpoint+1:16)];
        newpop(i+1,8:16) = [pop(i+1,8:cpoint),pop(i,cpoint+1:16)];
    else
        newpop(i,8:16) = pop(i,8:16);
        newpop(i+1,8:16) = pop(i+1,8:16);
    end
end
for i = 1:2:px-1
    if(rand<pc)
        cpoint = randi([17,28]);
        newpop(i,17:28) = [pop(i,17:cpoint),pop(i+1,cpoint+1:28)];
        newpop(i+1,17:28) = [pop(i+1,17:cpoint),pop(i,cpoint+1:28)];
    else
        newpop(i,17:28) = pop(i,17:28);
        newpop(i+1,17:28) = pop(i+1,17:28);
    end
end
%global search
%{
[px,py] = size(pop);
newpop = ones(size(pop));
for i = 1:2:px-1
    if(rand<pc)
        cpoint = round(rand*py);
        newpop(i,:) = [pop(i,1:cpoint),pop(i+1,cpoint+1:py)];
        newpop(i+1,:) = [pop(i+1,1:cpoint),pop(i,cpoint+1:py)];
    else
        newpop(i,:) = pop(i,:);
        newpop(i+1,:) = pop(i+1,:);
    end
end
%}