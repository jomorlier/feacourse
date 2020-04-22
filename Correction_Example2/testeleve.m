clc; clear all; close all;

%Authors:
%Mena Checa, Alberto
%Ezkurdia Apeztegia, Josu

%% Pre-processing

%Initial data

p1 = 100; %external force in N
p2 = 200; %external force in N
E = 200e3; %Young's modulus in MPa
A = 20*20; %cross section in mm2
L = 1000; %length in mm
sigma = 250; %yield strength in MPa

%stiffness matrix of a bar element in local coordinates
k = E*A/L*[1 -1; -1 1];

%rotation matrix for the first element
angle1=pi/4;
P1=[cos(angle1) sin(angle1);-sin(angle1) cos(angle1)];
T1=[P1 zeros(2,2); zeros(2,2) P1];

%rotation matrix for the second element
angle2=3*pi/4;
P2=[cos(angle2) sin(angle2);-sin(angle2) cos(angle2)];
T2=[P2 zeros(2,2); zeros(2,2) P2];

%augmented stiffness matrix in local coordinates
k_augmented=zeros(4,4);
k_augmented(1,1)=k(1,1);
k_augmented(1,3)=k(1,2);
k_augmented(3,1)=k(2,1);
k_augmented(3,3)=k(2,2);

%stiffness matrixes in the global coordinates
k1=T1'*k_augmented*T1;
k2=T2'*k_augmented*T2;

%assembly of the global stiffness matrix
K=zeros(6,6);
K(1:4,1:4)=k1;
K(3:6,3:6)=k2;
K(3:4,3:4)= k1(3:4,3:4)+k2(1:2,1:2);

%external nodal forces
f=[0 0 p1 p2 0 0]';

%sub-matrixes of the stiffness matrix needed to obtain the displacements
%and the reactions
dof=[3:4];
constraineddof=[1:2 5:6];
Kdisp=K(dof,dof);
Kreact=K(constraineddof,dof);
fdisp=f(dof);

%% Solving

%unknown displacements
disp('Displacements:');
U=inv(Kdisp)*fdisp;
fprintf('u2: %g mm\n', U(1));
fprintf('v2: %g mm\n', U(2));
disp(' ');

%reactions
disp('Reactions:');
R=Kreact*U;
fprintf('R1x: %g N\n', R(1));
fprintf('R1y: %g N\n', R(2));
fprintf('R3x: %g N\n', R(3));
fprintf('R3y: %g N\n', R(4));
disp(' ');
%% Post-processing

B = [-1/L 1/L];

%for element 1
u1 = [0 U(1)*cos(angle1)+U(2)*sin(angle1)]';
strain1 = B*u1;
stress1 = E*strain1;

%for element 2
u2 = [U(1)*cos(angle2)+U(2)*sin(angle2) 0]';
strain2 = B*u2;
stress2 = E*strain2;

disp('Strains in the bars:');
fprintf('strain 1: %g microdef\n', strain1*1e6);
fprintf('strain 2: %g microdef\n', strain2*1e6);
disp(' ');

disp('Stresses in the bars:');
fprintf('stress 1: %g MPa\n', stress1);
fprintf('stress 2: %g MPa\n', stress2);
disp(' ');

%Reserve Factor
RF = sigma/max(abs(stress1),abs(stress2));

fprintf('Initial RF: %g \n', RF);
disp(' ');

%% Optimization

%stresses are inversely proportional to the section; therefore, the RF is
%directly proportional to the section
Aopt = A/RF;
stress1opt = stress1*A/Aopt;
stress2opt = stress2*A/Aopt;
RFopt = sigma/max(abs(stress1opt),abs(stress2opt));

fprintf('The optimal section is : %g mm^2\n', Aopt);
fprintf('The RF obtained with the optimization is : %g\n', RFopt);

%the proportionality relation can be verified with the next plot
Areas = linspace(A,Aopt,100);
stress1list = stress1*A./Areas;
stress2list = stress2*A./Areas;
RFlist = zeros(size(Areas));

for i=1:length(Areas)
    RFlist(i) = sigma/max(abs(stress1list(i)),abs(stress2list(i)));
end

figure
plot1=plot(Areas,RFlist); hold on;
title('Relation between the section and the RF','Interpreter','latex','FontSize',15)
xlabel('$A$ ($mm^{2}$)','Interpreter','latex','FontSize',14)
ylabel('$RF$ (-)','Interpreter','latex','FontSize',14)
grid on
ax1 = ancestor(plot1, 'axes');
yrule1 = ax1.YAxis;
xrule1 = ax1.XAxis;