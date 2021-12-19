# Fall2021MECA482Project
Group 4

Paul Daniels
Ian Yasui 
Maximiliano Narez
Blake Bahn
Nancy Padillia

# Introduction



# Mathmetical Model



# Matlab Code
clc; clear; close all;

% The motor parameters

R=4.172;
km = 0.00775;
Umax = 13;

% Model of Inertia Wheel
g = 9.81; % Gravity acceleration
mgl = 0.12597;
mbg = mgl;
d11 = 0.0014636;
d12 = 0.0000076;
d21 = d12;
d22 = d21;
J = (d11*d22-d12*d21)/d12;
D = [d11 d12; d21 d22];
Di = inv(D);
di11 = Di(1,1);
di12 = Di(1,2);
di21 = Di(2,1);
di22 = Di(2,2);

% Approx Linear Model

A = [ 0 1 0; di11*mbg 0 0; di21*mbg 0 0];
B = [0; di12*km/R; di22*km/R];

% System parameters

C = eye(size(A));

%No need to define D

D = (0);

% Controllability assessment
% full-state feedback

disp('Controllable system?');
Pc = ctrb(A,B);
if rank(Pc) == size(Pc)
disp('Yes.');
else
disp('No.');
end

% Closed-loop eigenvalues

s1 = -9.27 + 20.6i;
s2 = -9.27 - 20.6i;
s3 = -0.719;
Vp = [ s1, s2, s3];
K = place(A, B, Vp);

% Verify closed-loop eigenvalues of A_new or A_cl
Vp_ = eig(A-B*K);
