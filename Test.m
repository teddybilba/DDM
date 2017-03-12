clear all; close all;
%warning off Control:ltiobject:TFComplex

% **** Variables **** %
m = 10;
Jt = m;
Jp = 0;
Omega = 0:400;
param= 0:2:8;
cr1 = param; cr2 = 0; cr3 = 0; cr4 = cr1;
cn1 = cr1; cn2 = 0; cn3 = 0; cn4 = cr1;
k11 = 500; k12 =0; k21 = -k12; k22 = k11;

% **** Matrices **** %
M = [m 0; 0 Jt];
%C = [cr1+cn1 cr2+cn2; cr3+cn3 cr4+cn4];
%K = [k11 k12; k21 k22];
s = tf('s');
poles_system=[];
for k=1:length(param)
    poles_system=append(poles_system,[]);
end
    
% *** Calculates the poles **** %
for n = 1:length(Omega)
G=[0 0; 0 -i*Omega(n)*Jp];
    for k=1:length(cr1)
    C = [2*cr1(k) cr2+cn2; cr3+cn3 2*cr1(k)];
    K12=Omega(n)*cr1(k);
    K21=-K12;
    K = [k11 k12; k21 k22];
    eq_mat = M*s^2 + (C+G)*s + K;
    sys = inv(eq_mat);
    poles_system(k) = [poles_system  pole(sys)];
    end
% Appends poles to matrix 
end


% **** Plot CAMPBELL DIAGRAM **** %
figure();
plot(Omega,Omega,'m');hold on;
title('Diagramme de Campbell');
xlabel('Vitesse de rotation');
ylabel('Im(s)');
for k=1:length(poles_system)
if size(poles_system(k),1) == 4        % If 2 poles
    plot(Omega, imag(poles_system(k(1,:))), 'b', Omega, imag(poles_system(k(2,:))), 'r'); 
    hold on;
    

    
elseif size(poles_system,1) == 6 %3 poles
    plot(Omega, imag(poles_system(k(1,:))), 'b', Omega, imag(poles_system(k(2,:))), 'r', Omega, imag(poles_system(3,:)), 'g');
    hold on;
    
elseif size(poles_system,1) == 8        % If 4 poles
    plot(Omega, imag(poles_system(k(1,:))), 'b', Omega, imag(poles_system(2,:)), 'r', Omega, imag(poles_system(k(3,:))), 'g', Omega, imag(poles_system(k(4,:))), 'k');
    hold on;
end
end

