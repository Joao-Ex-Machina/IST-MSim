%{
/*-----------------------------------------------------------------------------------------------------+
| p2.m                   | Simulation of a PharmoDynamic model for cancer treatment.                   |
|                        | Drug effect determination on time and dosage domain using Hill's equation.  |
|                        |                                                                             |
+------------------------------------------------------------------------------------------------------+
| Authors: Inês Cardoso Paiva nº99961, João Barreiros C. Rodrigues nº99968                             |
|          LEEC-IST                                                                                    |
| Date: 12 December 2022                                                                               |
+-----------------------------------------------------------------------------------------------------*/
%}

%Constants
c50 = 7.1903;
k12 = 0.3*3600;
k21 = 0.2455*3600;
k10 = 0.0643*3600;
v1 = 3110;
v2 = 3110;
delta = 1000;
h=1;

%Vectors
d=zeros(35,1);
c2=zeros(35,1);
l = length(c2);
u = zeros(l,1);
du = zeros(l,1);
du(1)=1;
u(1)=0;

for k = 2:(35)
	d(k)=k;
	c2(k)=(k12/(k21*k10))*delta*d(k);
	% Determine drug effect parameter using Hill's equation
	u(k) = c2(k) / (c50 + c2(k));
end

% Determine drug effect dosage derivative
for k = 2:(34)
	du(k)=u(k+1)-u(k);
end
  
%plot
figure(2);
    plot(d,u,d,du);
    hold on
    	xlabel('d [mg]','FontSize',12)
    	ylabel('Efeito u(d)','FontSize',12)
    	title('Efeito por dosagem','FontSize',12)
    	legend('u(d)','du(d)','Location','Southeast');
    hold off
   
%Test Bench
p2test(3);
p2test(15);
p2test(27);
p2test(36);
p2test(43);
p2test(55);
p2test(66); 
p2test(73); 
 
 
function p2test(a)
	%Constants
	k12 = 0.3*3600;
	k21 = 0.2455*3600;
	k10 = 0.0643*3600;
	v1 = 3110;
	v2 = 3110;
	delta = 1000;
	h=1;
	c50 = 7.1903;

	% Vectors
	x=[a,a,a,a,a,a,a,a,a,a,a,a,a,a];
	d=upsample(x,6);
	n=length(x);
	c = zeros(n*6,1);
	c1 = zeros(n*6,1);
	c2 = zeros(n*6,1);
	t = zeros(n*6,1);
	u = zeros(n,1);

	% Matrixes
	m=[-(k12+k10)/v1 , k21/v1 ; k12/v2 , -k21/v2];
	s=[1/v1 ; 0];

	% Euler's aproximation method for a differetial function solution
	    for k = 1:(n*6-1)
		t(k+1) = k*h;
		c = m * [c1(k); c2(k)] + s * delta * d(k);
		c1(k+1) = c1(k) + h * c(1);
		c2(k+1) = c2(k) + h * c(2);
		u(k+1) = c2(k) / (c50 + c2(k));
	    end
	    
	%plot   
	figure(3);
		hold on
			plot(t,u);
			xlabel('Tempo [Dias]','FontSize',12)
			ylabel('Efeito u(t)','FontSize',12)
			title('Efeito por Tempo','FontSize',12)
			legend('3mg','15mg','27mg','36mg','43mg','55mg','63mg','73mg','Location','Southeast');
		hold off
	    
end



