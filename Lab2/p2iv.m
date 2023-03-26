%{
/*-------------------------------------------------------------------------------------------------------+
| p2iv.m             | Simulation of a Markov chain Monopoly model, with a Monte Carlo coin flip          |
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
Njogadas=10000000; %numero de jogadas em cada run 
NMC=1; %numero de runs
Ndiscard=14; %numero de casas iniciais descartadas
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
		if (x==Ncasas+1)
			x=1;
		end
		if (x > Ncasas+1)
			x= x-Ncasas;
		end
    yrun(l)=x;
  end
	for d=Ndiscard:Njogadas
		p = yrun(d);
		zstates(p)=zstates(p)+1;
    end
    x=0;
end
zstates=zstates/(Njogadas);
figure(1);
    hold on
    p1=bar(zstates);
    xlim([0 7.5]);
    set(p1,'FaceColor','#D95319');
    xlabel("Estados", "Interpreter", "latex", "fontsize", 14);
    ylabel("Frequência Relativa", "Interpreter", "latex", "fontsize", 14);
    title("Frequência relativa de cada estado", "Interpreter", "latex", "fontsize", 14);
    hold off