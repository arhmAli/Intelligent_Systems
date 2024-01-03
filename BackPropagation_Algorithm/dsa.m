clear all;
x1=[0 0 1 1];
x2=[0 1 0 1];
y=[0 1 1 0];
w13=0.5;    w14=0.9;
w23=0.4;    w24=1;
w35=-1.2;   w45=1.1;
th3=0.8;    th4=-0.1;   th5=0.3;
alpha=0.1;
jj=1;
er=0;
while true
    error=0;
for ii=1:4
    y3=1/(1+exp(-1*(x1(ii)*w13(ii,jj)+x2(ii)*w23(ii,jj)-th3(ii,jj))));
    y4=1/(1+exp(-1*(x1(ii)*w14(ii,jj)+x2(ii)*w24(ii,jj)-th4(ii,jj))));
    y5=1/(1+exp(-1*(y3*w35(ii,jj)+y4*w45(ii,jj)-th5(ii,jj))));
    
    ek=y(ii)-y5;
    d5=y5*(1-y5)*ek;
    d3=y3*(1-y3)*d5*w35(ii,jj);
    d4=y4*(1-y4)*d5*w45(ii,jj);
    
    dw35=alpha*y3*d5;
    dw45=alpha*y4*d5;
    dw13=alpha*x1(ii)*d3;
    dw23=alpha*x2(ii)*d3;
    dw14=alpha*x1(ii)*d4;
    dw24=alpha*x2(ii)*d4;
    
    if ii==4
    w35(1,jj+1)=w35(ii,jj)+dw35;
    w45(1,jj+1)=w45(ii,jj)+dw45;
    w13(1,jj+1)=w13(ii,jj)+dw13;
    w14(1,jj+1)=w14(ii,jj)+dw14;
    w23(1,jj+1)=w23(ii,jj)+dw23;
    w24(1,jj+1)=w24(ii,jj)+dw24;
    
    th5(1,jj+1)=th5(ii,jj)-alpha*d5;
    th3(1,jj+1)=th3(ii,jj)-alpha*d3;
    th4(1,jj+1)=th4(ii,jj)-alpha*d4;
    
    else
    w35(ii+1,jj)=w35(ii,jj)+dw35;
    w45(ii+1,jj)=w45(ii,jj)+dw45;
    w13(ii+1,jj)=w13(ii,jj)+dw13;
    w14(ii+1,jj)=w14(ii,jj)+dw14;
    w23(ii+1,jj)=w23(ii,jj)+dw23;
    w24(ii+1,jj)=w24(ii,jj)+dw24;
    
    th5(ii+1,jj)=th5(ii,jj)-alpha*d5;
    th3(ii+1,jj)=th3(ii,jj)-alpha*d3;
    th4(ii+1,jj)=th4(ii,jj)-alpha*d4;
    end
    error=error+ek^2;
end
    er(jj)=error;
    fprintf("epoch: ")
    disp(jj)
    if er(jj)<0.001
        break
    end
    jj=jj+1;
end
figure
plot(er,jj);