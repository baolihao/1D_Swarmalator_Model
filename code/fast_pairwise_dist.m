function r = fast_pairwise_dist(x, N)
%

%

xmag               = sum(x .* x, 1);
r                  = abs(repmat(xmag, N, 1) + repmat(xmag', 1, N) - 2*(x')*x); 
r(1 : N + 1 : end) = 0;
r                  = r.^(0.5);
end