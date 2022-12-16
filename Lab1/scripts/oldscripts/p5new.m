%{
/*-----------------------------------------------------------------------------------------------------+
| p5.m                   | Simulation of a PharmoKinetic and PharmoDynamic model for cancer treatment  |
|                        | with growing tumor dynamic model. Added irregular medication spacing using  |
|                        | bernoulli test.                                                             |
+------------------------------------------------------------------------------------------------------+
| Authors: Inês Cardoso Paiva nº99961, João Barreiros C. Rodrigues nº99968                             |
|          LEEC-IST                                                                                    |
| Date: 12 December 2022                                                                               |
+-----------------------------------------------------------------------------------------------------*/
%}

%test bench
p5test(30,6,0);
p5test(30,6,1);
%p5test(30,6,2,1);

function p5test(days,doses,spacingtype)
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
		d=zeros(days,1);
		c = zeros(days,1);
		randomspac = zeros (days,1);
		c1 = zeros(days,1);
		c2 = zeros(days,1);
		t = zeros(days,1);
		u = zeros(days,1);
	        u1 = zeros(days,1);

	%matrixes
		m=[-(k12+k10)/v1 , k21/v1 ; k12/v2 , -k21/v2];
		s=[1/v1 ; 0];
	
	% Manual Spacing
		remainingdoses=doses-1
		meddays=zeros(doses-1,1);
		loopflag=1
		if(spacingtype == 1)
			while remainingdoses >= 0
				while boolean (loopflag)
					loopflag=0;
					medday = randi([2 days],1);
					if d(medday)==a
						loopflag=1;
					end
				end
				d(medday)=a;
				remainingdoses=remainingdoses-1;
				loopflag=1;
			end
		end
		if (spacingtype==0)
			d=upsample(x,5);
		end
	% Euler's aproximation method for diferential functions
		randomspac(1)=a
		for k = 2:(days-1)
			t(k+1) = k*h;
        		c = m * [c1(k); c2(k)] + s * delta * d(k);
			c1(k+1) = c1(k) + h * c(1);
        		c2(k+1) = c2(k) + h * c(2);
			u1(k) = c2(k) / (c50 + c2(k));
    		end



% Tumor growth dynamic
	%Vectors
      V = zeros(days,1);

	% Constants
		a = 0.09;
		Kt = 10;
		b = 1;
		V(1) = 1; % Initial tumor size

	% Applying Euler's aproximation method to the diferential equation
		for k = 1:(days-1)
        		t(k+1) = k*h;
        		V(k+1) = V(k)+h*(a*V(k)*(1-(V(k)/Kt))-b*u1(k)*V(k));
   		end
   	% plot
		figure(spacingtype);
			hold on
				plot(t,V);
				plot(t,u1);
				xlabel('Tempo [Dias]','FontSize',12)
				ylabel('Volume do Tumor','FontSize',12)
				title('Evolução do Tumor ','FontSize',12)
				legend('V(t)','u(t)','1','2','3','6','9','12','15','18','21');

			hold off
		end

end
