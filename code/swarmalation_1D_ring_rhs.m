function rhs= swarmalation_1D_ring_rhs(y,J,K,N)

    phii        = y(1:N);
    phij        = phii';

    thetai      = y(N+1:2*N);
    thetaj      = thetai';

    phi_dot     = J/N.*sum(sin(phij-phii).*cos(thetaj-thetai),2);
    theta_dot   = K/N.*sum(sin(thetaj-thetai).*cos(phij-phii),2);

    rhs         = [phi_dot;theta_dot];
end
