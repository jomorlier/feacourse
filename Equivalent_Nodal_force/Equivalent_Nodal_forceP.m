%% 
% *Equivalent nodal forces*
% 
% As an example, we calculate the first component of the vector of equivalent 
% nodal forces  *F* due to a trapezoidal load with intensities  _p1_ and  _p2_ 
% .

syms z
syms L
L=1;
N_1 = 1 - 3 * z^2 + 2 * z^3
figure
fplot(N_1, [0, 1])

N_3 = 3 * z^2 - 2 * z^3
figure
fplot(N_3, [0, 1])
%% 
%%
N_2 = L * z * (z - 1)^2
figure
fplot(N_2, [0, 1])
N_4=-L*(z^2-z^3);
figure
fplot(N_4, [0, 1])
%% 
% Works in real coordinate
%%

N_1 = subs(N_1, z, X/L)
N_2 = subs(N_2, z, X/L)
N_3 = subs(N_3, z, X/L)
N_4 = subs(N_4, z, X/L)

int(N_1, X)

int(N_1, X, sym(0), L)

N = [N_1; N_2; N_3; N_4]

int(N, X)

syms Feq
Feq == symhold('p1*int(N, X, 0, L) + (p2 - p1)*int((X*N)/L, X, 0, L)')
%% 
% Finally
%%
syms p1 p2
Feq = p1 * int(N, X, sym(0), L) + (p2 - p1) * int((X * N)/L, X, sym(0), L)

simplify(Feq)
%% 
% Special case were p1=p2=p
%%
syms p
Feq = subs(subs(Feq, p1, p), p2, p)
%% 
%  That's all
%% Local Functions
%% Helpers
%%
function h = symhold(exprstring)
h = evalin(symengine, ['hold(' exprstring ' )']);
end