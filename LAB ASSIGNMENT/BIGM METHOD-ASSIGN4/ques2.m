variables = {'x1','x2','s1','s2','s3','A1','A2','A3','sol'};
M = 10000;
cost = [-12 -10 0 0 0 -M -M -M 0];

A = [5 1 -1 0 0 1 0 0 10 ;6 5 0 -1 0 0 1 0 30; 1 4 0 0 -1 0 0 1 8 ];
s = eye(size(A,1));


BV=[];
for j=1:size(s,2)
    for i=1:size(A,2)
        if A(:,i)==s(:,j)
            BV = [BV i];
        end
    end
end

B = A(:,BV);
A = inv(B)*A;
ZjCj = cost(BV)*A -cost;

ZCj=[ZjCj;A];

SimpTable = array2table(ZCj);
SimpTable.Properties.VariableNames(1:size(ZCj,2)) = variables;

RUN = true;
while RUN
   
ZC = ZjCj(:,1:end-1);
if any(ZC<0);
    fprintf('The current BFS is not optimal \n ');
    
    [Enterval, pvt_col] = min(ZC);
    fprintf('Entering Column = %d\n',pvt_col);
    
    
    sol = A(:,end);
    Column = A(:,pvt_col);
    if all(Column)<=0
        fprintf('Solution is unbounded \n');
    else
        Har = find(Column>0);
        ratio = inf.*ones(1,length(sol));
        ratio(Har) = sol(Har)./Column(Har);
        
        for i=1:size(Column,1)
            if Column(i)>0
                ratio(i)=sol(i)./Column(i);
            else
                ratio(i)=inf;
            end
        end
        
        [minR,pvt_row]=min(ratio);
        fprintf('Leaving Row - %d \n',pvt_row);
        
     
        
        BV(pvt_row)=pvt_col;
        B = A(:,BV);
        A = inv(B)*A;
        ZjCj = cost(BV)*A - cost
        
        
        
        ZCj=[ZjCj;A];

        Table = array2table(ZCj);
        Table.Properties.VariableNames(1:size(ZCj,2)) = variables;
    end
   
    else
        RUN = false;
        fprintf(' Current BFS is optimal \n');
    end
end


FINAL_BFS = zeros(1,size(A,2));
FINAL_BFS(BV) = A(:,end);
FINAL_BFS(end) = sum(FINAL_BFS.*cost);

OptimalBFS = array2table(FINAL_BFS);
OptimalBFS.Properties.VariableNames(1:size(OptimalBFS,2))=variables;