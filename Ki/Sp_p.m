T          = 800;
N          = 1000;
J          = ones(N,1);
k_p        = 1;
k_n        = -0.5;
phi0       = 2*pi*rand(N, 1);
theta0     = 2*pi*rand(N, 1); 



r0         = ones(N,1);
y0         = [phi0;theta0];
tspan      = [0, T];
L          = 401;
p          = 0:0.01:1;
Sp         = zeros(length(p),1);
Sn         = zeros(length(p),1);
v          = zeros(length(p),1);

Tkp_p      = zeros(length(p),1);
Tkp_n      = zeros(length(p),1);

Tkn_p      = zeros(length(p),1);
Tkn_n      = zeros(length(p),1);


K          = zeros(N,1);
ind        = randperm(N); % randomly shuffle 1:N integers

for i = 1:length(p)
       pp                    = p(i);
       N_p                   = floor(pp * N); % better be an integer
       K(ind(1 : N_p))       = k_p;
       K(ind(N_p + 1 : end)) = k_n; 
       rhs                   = @(t, y) swarmalation_1D_ring_rhs(y, J, K, N);
       soln                  = ode45(rhs, tspan, y0);
       tint                  = linspace(0, T, L);
       yint                  = deval(soln, tint);
       x_sol                 = yint(1:N,:);
       theta_sol             = yint(N+1:end,:);
       x_final               = x_sol(:,end);
       theta_final           = theta_sol(:,end);

       x_kp                  = x_final(ind(1 : N_p));
       theta_kp              = theta_final(ind(1:N_p));
       x_kn                  = x_final(ind(ind(N_p + 1 : end)));
       theta_kn              = theta_final(ind(ind(N_p + 1 : end)));





       c                     = swarmalation(x_final,theta_final,J,N);
       v(i)                  = c;  
       xi                    = x_sol+theta_sol;
       eta                   = x_sol-theta_sol;

    

       Sp(i)                 = mean(abs(1/N*sum(exp(1i*xi(:,end-70:end)))));
       Sn(i)                 = mean(abs(1/N*sum(exp(1i*eta(:,end-70:end))))); 

end



plot(p,max(Sp,Sn),'r-o','MarkerEdgeColor','r','MarkerFaceColor','b','MarkerSize',3);
hold on;

plot(p,min(Sp,Sn),'r-o','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',3);
hold on;
hold on;
plot(p,v,'g',LineWidth=2);



function rhs= swarmalation(phii,thetai,J,N)
   % phij is a row vector and phii is a column vector
 
    phij        = phii';

   
    thetaj      = thetai';

    phi_dot     = J/N.*sum(sin(phij-phii).*cos(thetaj-thetai),2);

    rhs         = mean(abs(phi_dot));
   
   
end

