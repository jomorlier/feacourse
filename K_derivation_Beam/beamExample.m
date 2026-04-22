clear; clc;
syms x L EI rho A real
xi = x/L;

% Shape functions
N1 = 1 - 3*xi^2 + 2*xi^3;
N2 = L*(xi - 2*xi^2 + xi^3);
N3 = 3*xi^2 - 2*xi^3;
N4 = L*(-xi^2 + xi^3);

N = [N1 N2 N3 N4];

disp('Shape function vector N =');
pretty(N)

% Second derivatives for beam curvature
B = diff(N,x,2);
B = simplify(B);

disp('Second derivative vector B = d2N/dx2');
pretty(B)

% Stiffness matrix
K = int(EI*(B.'*B), x, 0, L);
K = simplify(K);

disp('Symbolic stiffness matrix K =');
pretty(K)

% Factorized form
Kf = simplify(K / (EI/L^3));
disp('K normalized by EI/L^3 =');
pretty(Kf)

% Mass matrix
M = int(rho*A*(N.'*N), x, 0, L);
M = simplify(M);

disp('Symbolic mass matrix M =');
pretty(M)

Mf = simplify(M / (rho*A*L/420));
disp('M normalized by rho*A*L/420 =');
pretty(Mf)

% Optional numeric check
Lnum = 2; EInum = 1000; rhonum = 7800; Anum = 0.01;
Knum = double(subs(K,[L EI],[Lnum EInum]));
Mnum = double(subs(M,[L rho A],[Lnum rhonum Anum]));

disp('Numeric K ='); disp(Knum)
disp('Numeric M ='); disp(Mnum)