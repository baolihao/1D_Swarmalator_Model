function rhs = swarmalator_rhs(y, phi, d, N, ode_type, r_neighbor)
% function rhs = swarmalator_rhs(y, phi, d, N, ode_type, r_neighbor)

% (C) M Zhong

% change it back to (x, v) both with size [d, N]
switch ode_type
  case 0
    x                = reshape(y(1 : d * N), [d, N]);
    xi               = reshape(y(d * N + 1 : (d + 1) * N), [1, N]);
    rhs              = zeros((d + 1) * N, 1);
  case 1
    x                = reshape(y(1 : d * N), [d, N]);
    theta            = reshape(y(d * N + 1 : (d + 1) * N), [1, N]);   
    xi               = reshape(y((d + 1) * N + 1 : (d + 2) * N), [1, N]);  
    rhs              = zeros((d + 2) * N, 1);
  case 2
    x                = reshape(y(1 : d * N), [d, N]);
    v                = reshape(y(d * N + 1 : 2 * d * N), [d, N]);
    xi               = reshape(y(2 * d * N + 1 : (2 * d + 1) * N), [1, N]);
    rhs              = zeros((2 * d + 1) * N, 1);
end
% find the pairwise distance in xi
xij                  = repmat(x, N, 1) - repmat(x(:), 1, N);
rij                  = get_pairwise_dist(xij, d, N);
% find the other pairwise quantities
switch ode_type
  case 0
    xiij             = xi(:) - xi;
  case 1
    thetaij          = theta(:) - theta;
    xiij             = xi(:) - xi;
% use the neighborhood
    ind              = rij <= r_neighbor;    
    N_sys            = repmat(sum(ind, 2), 1, N);
  case 2
    vij              = repmat(v, N, 1) - repmat(v(:), 1, N);
    sij              = get_pairwise_dist(vij);
    xiij             = xi(:) - xi;
end
% compute the right hand side
switch ode_type
  case 0
    idx1             = 1;
    idx2             = d * N;
    rhs(idx1 : idx2) = 1/N * sum(kron(phi{1}(rij, xiij), ones(d, 1)).*xij, 2);
    idx1             = d * N + 1;
    idx2             = (d + 1) * N;
    rhs(idx1 : idx2) = 1/N * sum(phi{2}(rij, xiij).*xiij, 2);    
  case 1
    idx1             = 1;
    idx2             = d * N;
    v                = [cos(theta); sin(theta)];
    rhs(idx1 : idx2) = v(:) + sum(kron(phi{1}(rij, thetaij, xiij)./N_sys, ones(d, 1)).*xij, 2);
    idx1             = d * N + 1;
    idx2             = (d + 1) * N;
    rhs(idx1 : idx2) = sum(phi{2}(rij, thetaij, xiij)./N_sys.*thetaij, 2);
    idx1             = (d + 1) * N + 1;
    idx2             = (d + 2) * N;
    rhs(idx1 : idx2) = sum(phi{3}(rij, thetaij, xiij)./Nsys.*xiij, 2);
  case 2
    idx1             = 1;
    idx2             = d * N;
    rhs(idx1 : idx2) = v(:);
    idx1             = d * N + 1;
    idx2             = 2 * d * N;
    rhs(idx1 : idx2) = 1/N * (sum(kron(phi{1}(rij, sij, xiij), ones(d, 1)) .* xij, 2) + ...
                       sum(kron(phi{2}(rij, sij, xiij), ones(d, 1)) .* vij, 2));
    idx1             = (d + 1) * N + 1;
    idx2             = (d + 2) * N;
    rhs(idx1 : idx2) = 1/N * sum(phi{3}(rij, sij, xiij) .* xiij, 2);    
end
end