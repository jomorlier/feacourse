function [p,dp] = legendre(t,n)
% Evaluates Legendre polynomial p of degree n
% and its derivative dp at x = t.
p0 = 1.0; p1 = t;
for k = 1:n-1
    p = ((2*k + 1)*t*p1 - k*p0)/(k + 1); % Eq. (6.19)
    p0 = p1;p1 = p;
end
dp = n *(p0 - t*p1)/(1 - t^2);           % Eq. (6.21)