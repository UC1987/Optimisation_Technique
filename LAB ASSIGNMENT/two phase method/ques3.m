var={'x1','x2','s1','s2','A1','Sol'};
optvariable={'x1','x2','s1','s2','Sol'};

c=[3 2 0 0 1 0] ;
a=[1 1 1 0 0 2;1 3 0 1 0 3;1 -1 0 0 1 1];
BV=[3 4 5];


d=[0 0 0 0 -1 0];  
StartBV=find(d<0);   

fprintf('*******Phase 1 Starts ********\n');
[BFS,a]=simp(a,BV,d,var);

fprintf('*******Phase 2********\n');
a(:,StartBV)=[];  
c(:,StartBV)=[]; 
[OptBFS,OptA]=simp(a,BFS,c,optvariable);

FINAL_BFS=zeros(1,size(a,2));
FINAL_BFS(OptBFS)=OptA(:,end);
FINAL_BFS(end)=sum(FINAL_BFS.*c);

OptimalBFS=array2table(FINAL_BFS);
OptimalBFS.Properties.VariableNames(1:size(OptimalBFS,2))=optvariable

function [BFS,A]=simp(A,BV,D,Variables)
    ZjCj=D(BV)*A-D;
    RUN=true;
while RUN
  ZC=ZjCj(1:end-1);
if any(ZC<0); 
    fprintf(' The Current BFS is NOT Optimal \n\n')
    
    [entcol pvt_col]=min(ZC);
    fprintf('Entering Col=%d \n',pvt_col) ;
    
    sol=A(:,end);
    Column=A(:,pvt_col);
    if Column<0
        fprintf('Unbounded Solution\n');
    else
        for i=1:size(A,1)
            if Column(i)>0
                ratio(i)=sol(i)./Column(i);
            else
                ratio(i)=inf;
            end
        end
        
        [MinRatio, pvt_row]=min(ratio);
        fprintf('Leaving Row =%d \n',pvt_row)
        
    end
    
   
    BV(pvt_row)=pvt_col;
    
    pvt_key=A(pvt_row,pvt_col);
    A(pvt_row,:)=A(pvt_row,:)./pvt_key;
     for i=1:size(A,1)
         if i~=pvt_row
             A(i,:)=A(i,:)-A(i,pvt_col).*A(pvt_row,:);
         end
     end
    ZjCj=ZjCj-ZjCj(1,pvt_col).*A(pvt_row,:);
    
    
    ZCj=[ZjCj;A];
    TABLE=array2table(ZCj);
    TABLE.Properties.VariableNames(1:size(ZCj,2))=Variables
    
    BFS(BV)=A(:,end);
else RUN=false;
    fprintf('Current BFS is Optimal\n');
    fprintf('*******Phase 1 END*******\n\n\n');
    BFS=BV;
end
end

end