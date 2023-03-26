%{
/*-----------------------------------------------------------------------------------------------------+
| p4.m                   | Mesh plotting of a volume in t+1 using u and volume in t to determine if a  |
|                        | growing tumor dynamic volume model can be trusted to use in a real scenario |
|                        | with no negative volumes.                                                   |
+------------------------------------------------------------------------------------------------------+
| Authors: Inês Cardoso Paiva nº99961, João Barreiros C. Rodrigues nº99968                             |
|          LEEC-IST                                                                                    |
| Date: 12 December 2022                                                                               |
+-----------------------------------------------------------------------------------------------------*/
%}
function p3test(spac)

    % Euler's aproximation method for diferential functions
    V0=linspace(0.000001,10,100);
        u=linspace(0,1,100);
    	h=1;
        size1=length(V0);
        size2=length(u);
        Vresult=zeros(size1,size2);
        a=0.09
        Kt=10
        b=1;
    hh=waitbar(0);
        for k=1:length(V0)
      hh=waitbar(k/10000);
            for p=1:length(u)
                        V1 = V0(k)+h*(a*V0(k)*(1-(V0(k)/Kt))-b*u(p)*V0(k))
                Vresult(k,p)=V1;
            end
    end
    close(hh)
      mp =mesh(V0,u,Vresult);
      xlabel('Volume at t (reversed scale)')
	    ylabel('medication effect')
	    zlabel('Volume at t+1')

	    plot(mp)
end

p3test()
