clc;
a=[3 -1 2;-2 4 0;-4 3 8];
c=[-1 3 -2 0 0 0 0]; %one extra zero for solution column
b=[7;12;10];
s=eye(size(a,1));
A=[a s b];
nv=size(a,2); %nv denotes the no of variable
bv=nv+1:size(A,2)-1;
zjcj=c(bv)*A-c;
h=[zjcj;A];
table=array2table(h,'VariableNames',{'x1','x2','x3','s1','s2','s3','sol'});
if(zjcj(1:size(zjcj,2)-1)<0)
    
    fprintf("Optimal solution is not obtained");
else
ev=min(zjcj); %ev->entering variable
end

