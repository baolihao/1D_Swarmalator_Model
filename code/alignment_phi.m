function phi = alignment_phi(r, K, sigma, beta)
% function phi = alignment_phi(r, K, sigma, beta)

% M. Zhong

% see the equations (2) and (3) in the paper: Emergent Behavior in Flocks, Cucker and Smale, 2007
% there the independent variable y = r^2
% K, sigma > 0, and beta >= 0, and when beta < 1/2, unconditional flocking occurs

phi = K./(sigma^2 + r.^2).^(beta);
end