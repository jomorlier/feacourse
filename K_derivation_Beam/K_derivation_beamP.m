syms clear
clear

syms z
N_1 = 1 - 3 * z^2 + 2 * z^3
figure
fplot(N_1, [0, 1])

N_3 = 3 * z^2 - 2 * z^3
figure
fplot(N_3, [0, 1])

syms L
N_2 = L * z * (z - 1)^2
figure
% MuPAD code that caused issue 1: plot::Function2d(subs(N_2, L = 1), z = 0..1, L = -5..5)
aux1 = subs([0, 1], L, sym(5));
fplot(subs(subs(N_2, L, sym(1)), L, sym(5)), double(aux1))

N_4 = -(L * (z^2 - z^3))
figure
% MuPAD code that caused issue 2: plot::Function2d(subs(N_4, L = 1), z = 0..1, L = -5..5)
aux2 = subs([0, 1], L, sym(5));
fplot(subs(subs(N_4, L, sym(1)), L, sym(5)), double(aux2))

syms X
N_1 = subs(N_1, z, X/L)
N_2 = subs(N_2, z, X/L)
N_3 = subs(N_3, z, X/L)
N_4 = subs(N_4, z, X/L)

N = [N_1; N_2; N_3; N_4]

B = symhold('transpose(diff(diff(N, X), X))')

B = transpose(diff(diff(N, X), X))

syms K
K == symhold('EI*int(transpose(B)*B, X, 0, L)')

syms EI
K = EI * int(transpose(B) * B, X, sym(0), L)
%% Local Functions
%% Helpers
%%
function h = symhold(exprstring)
h = evalin(symengine, ['hold(' exprstring ' )']);
end