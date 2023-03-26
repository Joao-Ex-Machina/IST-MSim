%{
/*-------------------------------------------------------------------------------------------------------+
| p2ii.m             | Simulation of a Markov chain Monopoly model, with a Monte Carlo coin flip          |
|                        | decision model                                                                |
|                        |                                                                               |
+--------------------------------------------------------------------------------------------------------+
| Authors: Inês Cardoso Paiva nº99961, João Barreiros C. Rodrigues nº99968, Ricardo F. D. Simões nº70389 |
|          Tomás Amoroso Archer nº100097                                                                 |
|          LEEC-IST                                                                                      |
| Date: 20 December 2022                                                                                 |
+-------------------------------------------------------------------------------------------------------*/
%}

y=[0,1,2,3,4];
z=[0.10,0.050,0.250,0.150,0.200,0.200,0.050; 0.0450,0.0750,0.2750,0.160,0.210,0.1850,0.050;0.0660,0.09050,0.24150,0.15950,0.1960,0.1680,0.07850; 0.0630,0.09380, 0.244950,0.15810,0.192950,0.166950,0.080250; 0.0619850,0.0918350,0.2460150,0.1602350,0.1942150,0.1669250,0.078790];
%Os valores de z foram retirados a partir do problema p1b
figure(1);
    bar3(y,z);
    xlabel("Estados", "Interpreter", "latex", "fontsize", 14);
    ylabel("10^x(Runs)", "Interpreter", "latex", "fontsize", 14);
    zlabel("Frequência Relativa", "Interpreter", "latex", "fontsize", 14);
    title("Frequências Relativas para várias runs", "Interpreter", "latex", "fontsize", 14);
