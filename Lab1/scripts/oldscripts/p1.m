%{
/*-----------------------------------------------------------------------------------------------------+
| p1.m                   |                                                                             |
|                        |                                                                             |
|                        |                                                                             |
+------------------------------------------------------------------------------------------------------+
| Authors: Inês Cardoso Paiva nº9996, João Barreiros C. Rodrigues nº99968                               |
|          LEEC-IST                                                                                    |
| Date: 12 December 2022                                                                               |
+-----------------------------------------------------------------------------------------------------*/
%}

%Constantes
k12 = 0.3*3600;
k21 = 0.2455*3600;
k10 = 0.0643*3600;
v1 = 3110;
v2 = 3110;
delta = 1000;
h=1;

%vetores
x=[3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3];
d=upsample(x,6);
n=length(x);
c = zeros(n*6,1);
c1 = zeros(n*6,1);
c2 = zeros(n*6,1);
t = zeros(n*6,1);

%matrizes
m=[-(k12+k10)/v1 , k21/v1 ; k12/v2 , -k21/v2];
s=[1/v1 ; 0];

%método de Euler
    for k = 1:(n*6-1)
        t(k+1) = k*h;
        c = m * [c1(k); c2(k)] + s * delta * d(k);
        c1(k+1) = c1(k) + h * c(1);
        c2(k+1) = c2(k) + h * c(2);
    end
    
%gráfico
figure(1);
hold on
plot(t,c1);
plot(t,c2);
plot(t,d);
xlabel('Tempo [Dias]','FontSize',12)
ylabel('Concentração [mg/kg]','FontSize',12)
title('Concentração por Tempo','FontSize',12)
legend('c1(t)','c2(t)','d(t)','Location','Southeast');
hold off

    
    
   
