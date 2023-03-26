k=0.8;
v=0;
A=sim("p1_simulink");

 figure(1);
 hold on
 plot(A.t,A.z);
 xlabel("Tempo [s]", "Interpreter", "latex", "fontsize", 12);
 ylabel("Posição Z [m]", "Interpreter", "latex", "fontsize", 12);
 title("Posição da bola na vertical ao longo do tempo", "Interpreter", "latex", "fontsize", 12);
 legend('\alpha=0.8','Location','Southeast');
 hold off
 
 figure(2);
 hold on
 k=0;
 A=sim("p1_simulink");
 plot(A.t,A.z);
 k=0.3;
 A=sim("p1_simulink");
 plot(A.t,A.z);
 k=0.5;
 A=sim("p1_simulink");
 plot(A.t,A.z);
 k=0.8;
 A=sim("p1_simulink");
 plot(A.t,A.z);
 k=1;
 A=sim("p1_simulink");
 plot(A.t,A.z);
 xlabel("Tempo [s]", "Interpreter", "latex", "fontsize", 12);
 ylabel("Posição Z [m]", "Interpreter", "latex", "fontsize", 12);
 title("Posição da bola na vertical ao longo do tempo", "Interpreter", "latex", "fontsize", 12);
 legend('\alpha=0','\alpha=0.3','\alpha=0.5','\alpha=0.8','\alpha=1' ,'Location','Southeast');
 hold off
 
figure(3); 
hold on
k=0.8;
v=-7;
A=sim("p1_simulink");
plot(A.t,A.z);
v=0;
A=sim("p1_simulink");
plot(A.t,A.z);
v=7;
A=sim("p1_simulink");
plot(A.t,A.z);
v=20;
A=sim("p1_simulink");
plot(A.t,A.z);
xlabel("Tempo [s]", "Interpreter", "latex", "fontsize", 12);
 ylabel("Posição Z [m]", "Interpreter", "latex", "fontsize", 12);
 title("Posição da bola na vertical ao longo do tempo", "Interpreter", "latex", "fontsize", 12);
 legend('v = -7 m/s','v = 0 m/s','v = -7 m/s','v = 20 m/s' ,'Location','Southeast');
 hold off
 
 k=0.8;
v=0;
A=sim("p1_simulink");

 figure(4);
 hold on
 plot(A.t,A.z);
 ylim([-1 inf])
 xlabel("Tempo [s]", "Interpreter", "latex", "fontsize", 12);
 ylabel("Posição Z [m]", "Interpreter", "latex", "fontsize", 12);
 title("Posição da bola na vertical ao longo do tempo (efeito de zeno)", "Interpreter", "latex", "fontsize", 12);
 hold off