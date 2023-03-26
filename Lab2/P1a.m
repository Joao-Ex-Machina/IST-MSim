%{
/*-------------------------------------------------------------------------------------------------------+
| p1a.m             | Simulation of a Markov chain Monopoly model, with a Monte Carlo coin flip          |
|                        | decision model                                                                |
|                        |                                                                               |
+--------------------------------------------------------------------------------------------------------+
| Authors: Inês Cardoso Paiva nº99961, João Barreiros C. Rodrigues nº99968, Ricardo F. D. Simões nº70389 |
|          Tomás Amoroso Archer nº100097                                                                 |
|          LEEC-IST                                                                                      |
| Date: 20 December 2022                                                                                 |
+-------------------------------------------------------------------------------------------------------*/
%}
%Variables
Njogadas=20; %numero de jogadas em cada run 
NMC=1; %numero de runs
Ndiscard=1; %numero de casas iniciais descartadas
Ncasas=7; %numero de casa no tabuleiro
zstates= zeros(Ncasas,1); %numero de vezes que se caiu em cada casa
yrun= zeros(Njogadas,1); %casa em que se caiu em  cada jogada
x=0; %estado instantaneo
aluguer=[10 10 0 15 20 25 35]; %valor do aluguer para cada estado
avanca=0; %resultado do lançamento (0-cara 1-coroa)
avancavec=zeros(Njogadas,1); %valores de cada lançamento 
rng(42069);

for k=1:NMC
	for l=1:Njogadas
		avanca=randi(2);
    avancavec(l)=avanca;
		x= x+avanca;
    if(l ~= 1)
		  if ((x > Ncasas) && (yrun(l-1)==7))
			  x= x-Ncasas;
		  end
    end
		if (x==Ncasas)
			x=3;
		end
		if (x==Ncasas+1)
			x=7;
		end
		if (x > Ncasas+1)
			x= x-Ncasas;
		end
    yrun(l)=x;
  end
	for d=1:Njogadas
		p = yrun(d);
		zstates(p)=zstates(p)+1;
    end
    x=0;

end
 figure(1);
    hold on
    p1=bar(avancavec);
    set(p1,'FaceColor','blue');
    yticks([1 2]);
    xlabel("N\textordmasculine \ da jogada", "Interpreter", "latex", "fontsize", 14);
    ylabel("Lançamento da moeda", "Interpreter", "latex", "fontsize", 14);
    title("Resultados dos vários lançamentos", "Interpreter", "latex", "fontsize", 14);
    hold off
    
    figure(2);
    hold on
    p2=bar(yrun);
    set(p2,'FaceColor','cyan');
    yticks([1 2 3 4 5 6 7]);
    xlabel("N\textordmasculine \ da jogada", "Interpreter", "latex", "fontsize", 14);
    ylabel("Estado", "Interpreter", "latex", "fontsize", 14);
    title("Estados obtidos ao longo dos vários lançamentos", "Interpreter", "latex", "fontsize", 14);
    hold off
    
    
  


 
    
 
