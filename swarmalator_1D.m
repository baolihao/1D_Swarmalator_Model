function rhs= swarmalator_1D(y,J,K,A,N)
   % phij is a row vector and phii is a column vector
    phii        = y(1:N);
    phij        = phii';

    thetai      = y(N+1:end);
    thetaj      = thetai';

    phi_dot     = 1/N.*sum(J.*A.*sin(phij-phii).*cos(thetaj-thetai),2);
    theta_dot   = 1/N.*sum(K.*A.*sin(thetaj-thetai).*cos(phij-phii),2);

    rhs         = [phi_dot;theta_dot];
end