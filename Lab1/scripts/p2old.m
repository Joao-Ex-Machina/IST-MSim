%constantes
c50 = 7.1903;

%função c e u
c2 = logspace(-2,2,1000);   %Gráfico Logaritmico
l = length(c2);
u = zeros(l,1);
    
    %Equação de Hill
    for k = 1:(l)
        u(k) = c2(k) / (c50 + c2(k));
        
    end
    
    %gráfico
    figure(2);
    semilogx(c2,u);
    hold on
    xlabel('Concentração [kg/dia]','FontSize',12)
    ylabel('Efeito u(t)','FontSize',12)
    title('Efeito por Concentração','FontSize',12)
    hold off
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   

 
f1(3);
f1(7);
f1(11);
f1(20);
f1(27);
f1(33); 
u2= zeros (6,1); % six analyzed dosages  
 
function f1(a)
%Constantes
k12 = 0.3*3600;
k21 = 0.2455*3600;
k10 = 0.0643*3600;
v1 = 3110;
v2 = 3110;
delta = 1000;
h=1;
c50 = 7.1903;

%vetores
x=[a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a];
d=upsample(x,6);
n=length(x);
c = zeros(n*6,1);
c1 = zeros(n*6,1);
c2 = zeros(n*6,1);
t = zeros(n*6,1);
u = zeros(n,1);


%matrizes
m=[-(k12+k10)/v1 , k21/v1 ; k12/v2 , -k21/v2];
s=[1/v1 ; 0];

%método de Euler
    for k = 1:(n*6-1)
        t(k+1) = k*h;
        c = m * [c1(k); c2(k)] + s * delta * d(k);
        c1(k+1) = c1(k) + h * c(1);
        c2(k+1) = c2(k) + h * c(2);
        u(k+1) = c2(k) / (c50 + c2(k));
    end
    

figure(3);
hold on
plot(t,u);
xlabel('Tempo [Dias]','FontSize',12)
ylabel('Efeito u(t)','FontSize',12)
title('Efeito por Tempo','FontSize',12)
legend('3mg','7mg','11mg','20mg','27mg','33mg','Location','Southeast');
hold off
    
end



