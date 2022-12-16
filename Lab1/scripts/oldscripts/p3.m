%{
/*-----------------------------------------------------------------------------------------------------+
| p4.m                   | Simulation of a PharmoKinetic and PharmoDynamic model for cancer treatment  |
|                        | with growing tumor dynamic model.                                           |
|                        |                                                                             |
+------------------------------------------------------------------------------------------------------+
| Authors: Inês Cardoso Paiva nº99961, João Barreiros C. Rodrigues nº99968                             |
|          LEEC-IST                                                                                    |
| Date: 12 December 2022                                                                               |
+-----------------------------------------------------------------------------------------------------*/
%}




function p4test(spac,days)

% PK and PD models on time domain
	%Constants
		a = 3;
		k12 = 0.3*3600;
		k21 = 0.2455*3600;
		k10 = 0.0643*3600;
		v1 = 3110;
		v2 = 3110;
		delta = 1000;
		h=1;
		c50 = 7.1903;
	% Vectors
		n=days; %Maximum doses taken is a dose a day 
		x=a * ones(n,1);
		d=upsample(x,spac);
		c = zeros(n*spac,1);
		c1 = zeros(n*spac,1);
		c2 = zeros(n*spac,1);
		t = zeros(n*spac,1);
		u = zeros(n*spac,1);
	        u1 = zeros(n*spac,1);

	%matrixes
		m=[-(k12+k10)/v1 , k21/v1 ; k12/v2 , -k21/v2];
		s=[1/v1 ; 0];

	% Euler's aproximation method for diferential functions
    		for k = 1:(n*spac-1)
        		t(k+1) = k*h;
        		c = m * [c1(k); c2(k)] + s * delta * d(k);
        		c1(k+1) = c1(k) + h * c(1);
        		c2(k+1) = c2(k) + h * c(2);
			u1(k) = c2(k) / (c50 + c2(k));
    		end

	% plot
	%	figure(1);
	%		hold on
	%			plot(t,u);
	%			xlabel('Tempo [Dias]','FontSize',12)
	%			ylabel('Efeito u(t)','FontSize',12)
	%			title('Efeito por Tempo','FontSize',12)
	%			legend('3mg','7mg','11mg','20mg','27mg','33mg','Location','Southeast');
	%		hold off

% Tumor growth dynamic
	%Vectors
      V = zeros(n*spac,1);

	% Constants
		a = 0.09;
		Kt = 10;
		b = 1;
		V(1) = 1; % Initial tumor size

	% Applying Euler's aproximation method to the diferential equation
		for k = 1:(n*spac-1)
        		t(k+1) = k*h;
        		V(k+1) = V(k)+h*(a*V(k)*(1-(V(k)/Kt))-b*u1(k)*V(k));
   		end
   	% plot
		figure(spac);
			hold on
				plot(t,V);
				plot(t,u1);
				xlabel('Tempo [Dias]','FontSize',12)
				ylabel('Volume do Tumor','FontSize',12)
				title('Evolução do Tumor ','FontSize',12)
				legend('V(t)','u(t)','1','2','3','6','9','12','15','18','21');

			hold off
	end


