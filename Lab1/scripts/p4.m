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


p4test(1);
p4test(2);
p4test(3);
p4test(4); 
p4test(5);
p4test(6); % original


function p4test(spac)

% PK and PD models on time domain
	%Constants
		a=3;
		k12 = 0.3*3600;
		k21 = 0.2455*3600;
		k10 = 0.0643*3600;
		v1 = 3110;
		v2 = 3110;
		delta = 1000;
		h=1;
		c50 = 7.1903;
	% Vectors
		x=[a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a];
		d=upsample(x,spac);
		n=length(x);
		c = zeros(n*spac,1);
		c1 = zeros(n*spac,1);
		c2 = zeros(n*spac,1);
		t = zeros(n*spac,1);
		u = zeros(n*spac,1);
       
       % Tumor growth dynamic
	%Vectors
      V = zeros(n*spac,1);

	% Constants
		a = 0.09;
		Kt = 10;
		b = 1;
		V(1) = 1; % Initial tumor size

	%matrixes
		m=[-(k12+k10)/v1 , k21/v1 ; k12/v2 , -k21/v2];
		s=[1/v1 ; 0];

	% Euler's aproximation method for diferential functions
    		for k = 1:(n*spac-1)
        		t(k+1) = k*h;
        		c = m * [c1(k); c2(k)] + s * delta * d(k);
        		c1(k+1) = c1(k) + h * c(1);
        		c2(k+1) = c2(k) + h * c(2);
			    u(k) = c2(k) / (c50 + c2(k));
                V(k+1) = V(k)+h*(a*V(k)*(1-(V(k)/Kt))-b*u(k)*V(k));
            end
              u(n*spac) = c2(n*spac) / (c50 + c2(n*spac));


   	% plot
		figure(spac);
			hold on
                yline(0.1);
				plot(t,V,t,u);
				xlabel('Tempo [Dias]','FontSize',12)
				ylabel('Volume do Tumor','FontSize',12)
				title('Evolução do Tumor ','FontSize',12)
				legend('10% volume','V(t)','u(t)','Location','Southeast');

			hold off
	end