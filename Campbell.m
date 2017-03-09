clc;clear all;close all;
%Variables
m=300;
% Jt=100;
% Jp = 20;
% %Omega=0:10:1000;
% Omega = 5;
% cr1=1;cr2=1;cr3=1;cr4=1;
% cn1=1;cn2=1;cn3=1;cn4=1;
% K11=5;K12=2;K22=2;

Jt=100;
Jp = 0;
%Omega=0:10:1000;
Omega = 5;
cr1=0;cr2=0;cr3=0;cr4=0;
cn1=0;cn2=0;cn3=0;cn4=0;
K11=5;K12=0;K22=2;

%Matrices
M=[m 0;0 Jt];
C=[cr1+cn1 cr2+cn2;cr3+cn3 cr4+cn4];
K=[K11 K12;K12 K22];
s= tf('s');

figure
a = 0:1:100;
plot(sin(a),a);

figure
n = 0:1:10;
for j=1:length(n)
G=[0 0;0 -i*Omega*Jp];%bug à ce niveau là...
%equations
eq_mat= M*s^2+(C+G)*s+K;
sys=inv(eq_mat);
% for Omega= 0:10:1000
poles= pole(sys);
display(poles);
plot(real(poles(1)),n);
% end
%graphes
end




