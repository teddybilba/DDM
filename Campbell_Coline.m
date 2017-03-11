clc; close all;
%warning off Control:ltiobject:TFComplex

% **** Variables **** %
m = 10;
Jt = 10;
Jp = 10;
Omega = 0:400;
cr1 = 04; cr2 = 05; cr3 = 0; cr4 = 0;
cn1 = 10; cn2 = 01; cn3 = 0; cn4 = 09;
k11 = 500; k12 =1380; k21 = k12; k22 = 299;

% **** Matrices **** %
M = [m 0; 0 Jt];
C = [cr1+cn1 cr2+cn2; cr3+cn3 cr4+cn4];
K = [k11 k12; k21 k22];
s = tf('s');

poles_system = [];      % All poles of system

% *** Calculates the poles **** %
for n = 1:length(Omega)
G=[0 0; 0 -i*Omega(n)*Jp];
eq_mat = M*s^2 + (C+G)*s + K;
sys = inv(eq_mat);
poles_system = [poles_system  pole(sys)];
% Appends poles to matrix 
end


% **** Plot CAMPBELL DIAGRAM **** %
if size(poles_system,1) == 4        % If 2 poles
    subplot(2,1,1)
    plot(Omega, real(poles_system(1,:)), 'b', Omega, real(poles_system(2,:)), 'r');
    title('Diagramme de Campbell');
    xlabel('Vitesse de rotation');
    ylabel('Re(s)');
    
    subplot(2,1,2)
    plot(Omega, imag(poles_system(1,:)), 'b', Omega, imag(poles_system(2,:)), 'r');   
    xlabel('Vitesse de rotation');
    ylabel('Im(s)');

    
    elseif size(poles_system,1) == 6
    subplot(2,1,1)
    plot(Omega, real(poles_system(1,:)), 'b', Omega, real(poles_system(2,:)), 'r', Omega, real(poles_system(3,:)), 'g');
    title('Diagramme de Campbell');
    xlabel('Vitesse de rotation');
<<<<<<< HEAD:Campbell_Coline.m
end

    
=======
    ylabel('Re(s)');
    
    subplot(2,1,2)
    plot(Omega, imag(poles_system(1,:)), 'b', Omega, imag(poles_system(2,:)), 'r', Omega, imag(poles_system(3,:)), 'g');
    xlabel('Vitesse de rotation');
    ylabel('Im(s)');
    
elseif size(poles_system,1) == 8        % If 4 poles
    figure
    subplot(2,1,1)
    plot(Omega, real(poles_system(1,:)), 'b', Omega, real(poles_system(2,:)), 'r', Omega, real(poles_system(3,:)), 'g', Omega, real(poles_system(4,:)), 'k');
    title('Diagramme de Campbell');
    xlabel('Vitesse de rotation');
    ylabel('Re(s)');


    subplot(2,1,2)
    plot(Omega, imag(poles_system(1,:)), 'b', Omega, imag(poles_system(2,:)), 'r', Omega, imag(poles_system(3,:)), 'g', Omega, imag(poles_system(4,:)), 'k');
    xlabel('Vitesse de rotation');
    ylabel('Im(s)');
end

>>>>>>> origin/master:Campbell Coline
