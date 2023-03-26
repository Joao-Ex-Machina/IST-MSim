k=0.8;
v=0;
L=0.6; 
A=sim("p1_simulink");
B=sim("p2_simulink");

 figure(1);
 hold on
 plot(A.t,A.z);
 plot(B.t,B.z);
 xlabel("Tempo [s]", "Interpreter", "latex", "fontsize", 12);
 ylabel("Posição Z [m]", "Interpreter", "latex", "fontsize", 12);
 title("Posição da bola na vertical ao longo do tempo", "Interpreter", "latex", "fontsize", 12);
 legend('Sem atrito','Com atrito','Location','Southeast');
 hold off