clc
clear all
format short

A=[1 1 -1 3; 5 1 4 15 ]
C=[1 2 -1 1]
b=[15;12]
n=size(A,2)
m=size(A,1)
if(n>=m)
    nCm=nchoosek(n,m)
    pair=nchoosek(1:n,m)
    sol=[]
    for i=1:nCm
        y=zeros(n,1)
        x=A(:,pair(i,:))\b
        if all(x>=0 & x~=inf & x~=-inf)
            y(pair(i,:))=x
            sol=[sol,y]
        end
    end
else
    error('nCm does not exist')
end
%compute the objective function
Z=C*sol
[Zmax,Zindex]=max(Z)
bfs=sol(:,Zindex)
optimal_value=[bfs' Zmax]
optimal_bfs=array2table(optimal_value) 
optimal_bfs.Properties.VariableNames(1:size(optimal_bfs,2))={'x_1' , 'x_2' , 'x_3' , 'x_4' , 'x_5' , 'x_6' , 'Z'}