clc;clear all;close all;
%Variables
m=300;
Jt=100;
Jp=20;
Omega=0:10:1000;
cr1=1;cr2=1;cr3=1;cr4=1;
cn1=1;cn2=1;cn3=1;cn4=1;
K11=5;K12=2;K22=2;
%Matrices
M=[m 0;0 Jt];
C=[cr1+cn1 cr2+cn2;cr3+cn3 cr4+cn4];
G=[0 0;0 -i*Omega*Jp];%bug à ce niveau là...
K=[K11 K12;K12 K22];
%equations
s= ft(s);
eq_mat= M*s^2+(C+G)*s+K;
sys=inv(eq_mat);
% for Omega= 0:10:1000
poles= pole(sys);
% end
%graphes





