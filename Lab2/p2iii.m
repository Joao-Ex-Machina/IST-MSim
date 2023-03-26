%{
/*-------------------------------------------------------------------------------------------------------+
| p2iii.m             | Simulation of a Markov chain Monopoly model, with a Monte Carlo coin flip     |
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
Njogadas=50; %numero de jogadas em cada run 
NMC=100000; %numero de runs
Ndiscardmax=20; %numero de casas iniciais descartadas
Ncasas=7; %numero de casa no tabuleiro
zstates= zeros(Ncasas,Ndiscardmax); %numero de vezes que se caiu em cada casa
yrun= zeros(Njogadas,1); %casa em que se caiu em  cada jogada
x=0; %estado instantaneo
aluguer=[10 10 0 15 20 25 35]; %valor do aluguer para cada estado
avanca=0; %resultado do lançamento
avancavec=zeros(Njogadas,1); %valores de cada lançamento 
state=4;
for Ndiscard=1:Ndiscardmax
	rng(0);%reset seed for new evaluation
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
		for d=Ndiscard:Njogadas
			p = yrun(d);
			zstates(p,Ndiscard)=zstates(p,Ndiscard)+1;
	    end
	    x=0;
	    for p=1:Ncasas
	    	zstates(p,Ndiscard)=zstates(p,Ndiscard)/(Njogadas);
	    end
	end
end


figure(1);
    bar3(zstates);
    xlabel("Número de jogadas descartadas", "Interpreter", "latex", "fontsize", 14);
    ylabel("Estados", "Interpreter", "latex", "fontsize", 14);
    zlabel("Frequência Relativa", "Interpreter", "latex", "fontsize", 14);
    title("Frequências Relativas para vários valores de Ndiscard", "Interpreter", "latex", "fontsize", 14);
