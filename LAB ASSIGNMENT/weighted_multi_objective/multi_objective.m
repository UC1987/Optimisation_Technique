clear
clc
var={'x1','x2','x3','s1','s2','a2','soln'};
M=1000;
cost=[3 2 4; 1 5 3];
a=[2 4 1 0 1 0; 3 5 4 -1 0 1];
b=[8; 15];
c=[];
num=size(cost,1);
c=sum(cost)/num;
c=[c 0 0 -M 0];
A=[a b];
s=eye(size(A,1));
bv=[];
for j=1:size(s,2)
    for i=1:size(A,2)
        if A(:,i)==s(:,j)
bv=[bv,i];
        end
    end
end
B=A(:,bv);
A=inv(B)*A;
ZjCj=c(bv)*A-c;
run=true;
k=1;
while run
ZjCjRow=ZjCj(:,1:end-1);
    if any(ZjCjRow<0)
        if k>1
fprintf("Optimal soln. not reached yet.\n");
        end
fprintf("\nIteration %d:\n",k);
        k=k+1;
fprintf("Previous Basic Variables = \n");
disp(bv);
        [entCol,pivCol]=min(ZjCjRow);
fprintf("The entering variable is %d\n",pivCol);
soln=A(:,end);
valPivCol=A(:,pivCol);
        if all(valPivCol<=0)
error("LPP unbounded as all entries <=0 in column %d",pivCol);
        else
            for i=1:size(A,1)
                if(valPivCol(i)>0)
                    ratio(i)=soln(i)./valPivCol(i);
                else
                    ratio(i)=inf;
                end
            end
            [minRatio,pivRow]=min(ratio);
fprintf("The leaving variable is %d\n",bv(pivRow));
        end
bv(pivRow)=pivCol;
fprintf("Updated Basic Variables = \n");
disp(bv);
        B=A(:,bv);
        A=inv(B)*A;
ZjCj=c(bv)*A-c;              
    else
        run=false;
disp("Optimal Solution Reached.");    
    end
end
bfs=zeros(1,size(A,2));
bfs(bv)=A(:,end);
bfs(end)=sum(bfs.*c);
valuesOfVariables=array2table(bfs);

valuesOfVariables.Properties.VariableNames(1:size(valuesOfVariables,2))=var