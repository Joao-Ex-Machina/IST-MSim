figure(1);
 hold on
 parede=25;
 D=sim("p4_simulink");
 plot(D.x,D.z);
 xlim([-1,inf]);
 xlabel("Posição horizontal x [m]", "Interpreter", "latex", "fontsize", 12);
 ylabel("Posição vertical Z [m]", "Interpreter", "latex", "fontsize", 12);
 title("Evolução da tragetória da bola ", "Interpreter", "latex", "fontsize", 12)
 hold off
