    N            = 10;
    T            = 1000;

    J            = 1;
    K            = -2;
    L            = 10001;
    p            = 1;
   
    phi0         = 2*pi*rand(N, 1);
    theta0       = 2*pi*rand(N, 1); 
    y0           = [phi0;theta0];
    A            = erdos_renyi(N,p);
%% ODE Solver
    tspan        = [0, T];
    rhs          = @(t, y) swarmalator_1D(y, J, K,A, N);
    soln         = ode45(rhs, tspan, y0);
    tint         = linspace(0, T, L);
    yint         = deval(soln, tint);

%% Solution
    x_sol        = yint(1:N,:);
    theta_sol    = yint(N+1:end,:);
    xi           = x_sol+theta_sol;
    eta          = x_sol-theta_sol;
   
    Zp           = 1/N*sum(exp(1i*xi(:,end)));
    Rp           = abs(Zp);

    Zn           = 1/N*sum(exp(1i*eta(:,end)));
    Rn           = abs(Zn);
    Smax         = max(Rp,Rn)
    Smin         = min(Rp,Rn)
   
  
    c            = mean(abs(x_sol(:,end)-x_sol(:,end-1)))
    
   
%plot_ft(tint,yint,N)
%plot_2(tint,yint,Smax,Smin,N)