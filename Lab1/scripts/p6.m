%{
/*-----------------------------------------------------------------------------------------------------+
| p6.m                   | Simulation of a PharmoKinetic and PharmoDynamic model for cancer treatment  |
|                        | with growing tumor dynamic model.                                           |
|                        |                                                                             |
+------------------------------------------------------------------------------------------------------+
| Authors: Inês Cardoso Paiva nº99961, João Barreiros C. Rodrigues nº99968                             |
|          LEEC-IST                                                                                    |
| Date: 12 December 2022                                                                               |
+-----------------------------------------------------------------------------------------------------*/
%}


p6test(6,10);

function p6test(spac,days)

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
		n=days; %Maximum doses taken is a dose a day 
		x=a * ones(n,1);
		d=upsample(x,spac);
		c = zeros(n*spac,1);
		c1 = zeros(n*spac,1);
		c2 = zeros(n*spac,1);
		t = zeros(n*spac,1);
		u = zeros(n*spac,1);
        u1 = zeros(n*spac,1);
        
        % Tumor growth dynamic
	%Vectors and variables
        V = zeros(n*spac,1);
        V1 = zeros(n*spac,1);
	% Constants
		a = 0.09;
		Kt = 10;
		b = 1;
		V(1) = 1; % Initial tumor size
        V1(1) = 1;
        c_control=0.8;
        R=0;
        R_fixo=0;
       
        
	  
	%matrixes
		m=[-(k12+k10)/v1 , k21/v1 ; k12/v2 , -k21/v2];
		s=[1/v1 ; 0];

	% Euler's aproximation method for diferential functions
    		for k = 1:(n*spac-1)
        		t(k+1) = k*h;
        		c = m * [c1(k); c2(k)] + s * delta * d(k);
        		c1(k+1) = c1(k) + h * c(1);
        		c2(k+1) = c2(k) + h * c(2);
                if (c2(k)<=c_control && (c2(k)~=0))
                    R=R_fixo+0.4*(c_control-c2(k));
                    R_fixo=R;
                end 
                u(k) = c2(k) / (c50 + c2(k));
                u1(k) = c2(k) / (c50 + c2(k))*(1/(1+R));
                V(k+1) = V(k)+h*(a*V(k)*(1-(V(k)/Kt))-b*u(k)*V(k));
                V1(k+1) = V1(k)+h*(a*V1(k)*(1-(V1(k)/Kt))-b*u1(k)*V1(k));
            end
             u(n*spac) = c2(n*spac) / (c50 + c2(n*spac));
             u1(n*spac) = c2(n*spac) / (c50 + c2(n*spac))*(1/(1+R));
        
 

   	% plot
		figure(1);
			hold on
				plot(t,V,t,V1);
				xlabel('Tempo [Dias]','FontSize',12)
				ylabel('Volume do Tumor','FontSize',12)
				title('Evolução do Tumor ','FontSize',12)
				legend('V(t)','V(t) com resistencia','Location','Southeast');

			hold off
            
            figure(2);
			hold on
				plot(t,u,t,u1);
				xlabel('Tempo [Dias]','FontSize',12)
				ylabel('Efeito do Tumor','FontSize',12)
				title('Evolução do efeito ','FontSize',12)
				legend('u(t)','u(t) com resistencia','Location','Southeast');

			hold off
	end


