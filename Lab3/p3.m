
figure(1);
 hold on
 k=0.8;
 C=sim("p3_simulink"); 
 plot(C.x,C.z);
 k=0.5;
 C=sim("p3_simulink");
 plot(C.x,C.z,'--');
 xline(20);
 xlabel("Posição horizontal x [m]", "Interpreter", "latex", "fontsize", 12);
 ylabel("Posição vertical Z [m]", "Interpreter", "latex", "fontsize", 12);
 title("Evolução da tragetória da bola ", "Interpreter", "latex", "fontsize", 12);
 legend('Plano de impacto uniforme','Plano de impacto distinto','Instante de mudança de chão','Location','Southeast');
 hold off 