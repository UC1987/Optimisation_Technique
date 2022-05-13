
c=[3 11 4 14 15;6 16 18 2 28;10 13 15 19 17;7 12 5 8 9];
a=[15 25 10 15];
b=[20 10 15 15 5];
p=sum(a);
q=sum(b);
 if p==q
 fprintf("the problem is balanced");
 
 else
     fprintf("the problem is unbalanced");
     if p<q
         c(end+1,:)=zeros(1,size(a,2));
         a(end+1)=q-p;
     elseif p>q
         c(:,end+1)=zeros(1,size(a,2));
         b(end+1)=p-q;
     end
     end
nc=c;
x=zeros(size(c));
   [m,n]=size(c);
   bfs=m+n-1;
   for i=1:size(c,1)
       for j=1:size(c,2)
    hh=min(c(:));
    [rind,cind]=find(hh==c);
x11=min(a(rind),b(cind));
[val,ind]=max(x11);
ii =rind(ind);
jj=cind(ind);
y11=min(a(ii),b(jj));
x(ii,jj)=y11;
a(ii) = a(ii)-y11;
b(jj) = b(jj)-y11;
c(ii,jj)=inf;

       end
   end

    fprintf("initial bfs")
    ib =array2table(x);
    disp(ib);
 
    tbfs=length(nonzeros(x));
    if tbfs==bfs
         fprintf("initial bfs is non degenetate\n");
    else
      fprintf("initial bfs is  degenetate\n");
    end
  
    icost=sum(sum(nc.*x)); 
     fprintf("initial bfs cost =%d",icost);



 

     