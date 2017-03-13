clc; close all;
%warning off Control:ltiobject:TFComplex

% **** Variables **** %
m = 10;
Jt = 5;
Jp = 1.2;
Omega = 0:3000;
cr1 =400; cr2 = 5; cr3 = 0; cr4 = 400;
cn1 = 400; cn2 = 01; cn3 = 0; cn4 = 400;
k11 = 2.5e6; k12 =1380;k21 =k12;k22 = k11;

% **** Matrices **** %
M = [m 0; 0 Jt];
C = [cr1+cn1 cr2+cn2; cr3+cn3 cr4+cn4];
K = [k11 k12; k21 k22];
s = tf('s');
poles_system=[];

    
% *** Calculates the poles **** %
for n = 1:length(Omega)
G=[0 0; 0 -i*Omega(n)*Jp];
    %k12=Omega(n)*cr1;
    %k21=-k12;
    %K = [k11 k12; k21 k22];
    eq_mat = M*s^2 + (C+G)*s + K;
    sys = inv(eq_mat);
    poles_system = [poles_system  pole(sys)];
   
% Appends poles to matrix 
end


% **** Plot CAMPBELL DIAGRAM **** %
figure();
plot(Omega,Omega,'m');hold on;
title('Diagramme de Campbell');
xlabel('Vitesse de rotation');
ylabel('Im(s)');
box on;grid on;

if size(poles_system,1) == 4        % If 2 poles
    plot(Omega, imag(poles_system(1,:)), 'b', Omega, imag(poles_system(2,:)), 'r'); 
    hold on;
    

    
elseif size(poles_system,1) == 6 %3 poles
    plot(Omega, imag(poles_system(1,:)), 'b', Omega, imag(poles_system(2,:)), 'r', Omega, imag(poles_system(3,:)), 'g');
    hold on;
    
elseif size(poles_system,1) == 8        % If 4 poles
    plot(Omega, imag(poles_system(1,:)), 'b', Omega, imag(poles_system(2,:)), 'r', Omega, imag(poles_system(3,:)), 'g', Omega, imag(poles_system(4,:)), 'k');
    hold on;
end


