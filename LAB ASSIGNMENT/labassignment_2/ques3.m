clc
clear all
format short
A=[1 0 0 ; 0 1 0 ;-1 1 0; -1 0 2]
C=[-1 2 -1]
b=[4;4;6;4]
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
Z=C*sol
[Zmax,Zindex]=max(Z)
bfs=sol(:,Zindex)
optimal_value=[bfs' Zmax]
optimal_bfs=array2table(optimal_value)
optimal_bfs.Properties.VariableNames(1:size(optimal_bfs,2))={'x_1' , 'x_2' , 'x_3'  , 'Optimal value of Z'}