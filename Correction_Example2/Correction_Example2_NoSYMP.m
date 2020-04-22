clear all; close all;
%% 
% Correction of Example 2 not using SYMBOLIC COMPUTING, Now, E A L have 
% values !!!
% 
% 

E=20e3 %MPa
A=20*20
L=1000 %mm 

alpha=E*A/L
k=alpha*[1 -1;-1 1]


%2 orientations 45;135°
%can also use symbolic here
%theta1 = sym([pi/43])
theta1=pi/4;
l1=cos(theta1);
m1=sin(theta1);
theta2=3*pi/4;
l2=cos(theta2);
m2=sin(theta2);

%augmented problem
T_tilde1=[l1 m1;-m1 l1];
T1=zeros(4,4);
T1(1:2,1:2)=T_tilde1;
T1(3:4,3:4)=T_tilde1

T_tilde2=[l2 m2;-m2 l2];
T2=zeros(4,4);
T2(1:2,1:2)=T_tilde2;
T2(3:4,3:4)=T_tilde2
%syms k_prime
k_prime=(zeros(4,4));
k_prime(1,1)=k(1,1);
k_prime(1,3)=k(1,2);
k_prime(3,1)=k(2,1);
k_prime(3,3)=k(2,2)

k1=T1'*k_prime*T1
k2=T2'*k_prime*T2

%assembly
K=(zeros(6,6));
K(1:4,1:4)=k1;
K(3:6,3:6)=k2;
K(5:6,5:6)=k2(3:4,3:4);
%DOF u2 v2
K(3:4,3:4)= k1(3:4,3:4)+k2(1:2,1:2)


P1=100 %N
P2=200 %N

f=[0 0 P1 P2 0 0]'
%full problem
U_full=inv(K)*f

%condensed
U_condensed=inv(K(3:4,3:4))*f(3:4)

%partionned
%   Special case: ALL imposed displacements are zero 
% (Ub = 0)

freedofs=[3:4];
constraineddofs=[1:2 5:6];
Kaa=K(freedofs,freedofs)
Kba=K(constraineddofs,freedofs)
fa=f(freedofs)
Ua=inv(Kaa)*fa
R=Kba*Ua
%on x
R(1)+R(3)
%on y
R(2)+R(4)