clc; close all;
warning off Control:ltiobject:TFComplex

tic
% **** Variables **** %
m = 10;
Jt = 60;
Jp = 200;
Omega = 0:3000;
cr1 = 1000; cr2 = 1000; cr3 = 1000; cr4 = 1000;         %e4
cn1 = 1000; cn2 = 1000; cn3 = 1000; cn4 = 1000;         %e4
k11 = 2.5e6; k12 = 1e6; k21 = k12; k22 = k11;   %e6

% **** Matrices **** %
M = [m 0; 0 Jt];
Cn = [cn1 cn2; cn3 cn4];
Cr = [cr1 cr2; cr3 cr4]; 
K = [k11 k12; k21 k22];
s = tf('s');

poles_system = [];

% *** Calculates the poles **** %
for n = 1:length(Omega)
G=[0 0; 0 -1i*Omega(n)*Jp];
eq_mat = M*s^2 + (Cn+Cr+G)*s + (K-1i*Omega(n)*Cr);
poles = pole(inv(eq_mat));
poles_system = [poles_system  wkeep(poles, length(poles)/2, 'l')];   % Appends poles to matrix 
end

for x = 2:size(poles_system,2)
    if (imag(poles_system(1,x-1))*imag(poles_system(1,x))) < 0
        intermediate = poles_system(1, x:end);
        poles_system(1, x:end) = poles_system(2, x:end);
        poles_system(2, x:end) = intermediate;
    end
%     if (poles_system(3,x-1)*poles_system(3,x)) < 0
%         intermediate2 = poles_system(3, x:end);
%         poles_system(3, x:end) = poles_system(4, x:end);
%         poles_system(4, x:end) = intermediate2;
%     end
end


% **** Plot CAMPBELL DIAGRAM ****

if size(poles_system,1) == 2        % If 2 poles
    plot(Omega, imag(poles_system(1,:)), 'b', Omega, imag(poles_system(2,:)), 'r', Omega, Omega, '--', 'k'); 
    title('Diagramme de Campbell');
    xlabel('Vitesse de rotation (rad/s)');
    ylabel('Im(s)');
    box on; grid on;
    
elseif size(poles_system,1) == 4        % If 4 poles
    plot(Omega, imag(poles_system(1,:)), 'b', Omega, imag(poles_system(2,:)), 'r', Omega, imag(poles_system(3,:)), 'g', Omega, imag(poles_system(4,:)), 'm', Omega, Omega, '--k');
    title('Diagramme de Campbell');
    xlabel('Vitesse de rotation (rad/s)');
    ylabel('Im(s)');
    box on; grid on;
end
%display(poles_system);

toc

% 
% % **** Plot CAMPBELL DIAGRAM **** %
% if size(poles_system,1) == 2        % If 2 poles
%     subplot(2,1,1)
%     plot(Omega, real(poles_system(1,:)), 'b', Omega, real(poles_system(2,:)), 'r');
%     title('Diagramme de Campbell');
%     xlabel('Vitesse de rotation');
%     ylabel('Re(s)');
%     
%     subplot(2,1,2)
%     plot(Omega, imag(poles_system(1,:)), 'b', Omega, imag(poles_system(2,:)), 'r');   
%     xlabel('Vitesse de rotation');
%     ylabel('Im(s)');
%     
% elseif size(poles_system,1) == 3
%     subplot(2,1,1)
%     plot(Omega, real(poles_system(1,:)), 'b', Omega, real(poles_system(2,:)), 'r', Omega, real(poles_system(3,:)), 'g');
%     title('Diagramme de Campbell');
%     xlabel('Vitesse de rotation');
%     ylabel('Re(s)');
%     
%     subplot(2,1,2)
%     plot(Omega, imag(poles_system(1,:)), 'b', Omega, imag(poles_system(2,:)), 'r', Omega, imag(poles_system(3,:)), 'g');
%     xlabel('Vitesse de rotation');
%     ylabel('Im(s)');
%     
% elseif size(poles_system,1) == 4        % If 4 poles
%     figure
%     subplot(2,1,1)
%     plot(Omega, real(poles_system(1,:)), 'b', Omega, real(poles_system(2,:)), 'r', Omega, real(poles_system(3,:)), 'g', Omega, real(poles_system(4,:)), 'k');
%     title('Diagramme de Campbell');
%     xlabel('Vitesse de rotation');
%     ylabel('Re(s)');
% 
% 
%     subplot(2,1,2)
%     plot(Omega, imag(poles_system(1,:)), 'b', Omega, imag(poles_system(2,:)), 'r', Omega, imag(poles_system(3,:)), 'g', Omega, imag(poles_system(4,:)), 'k');
%     xlabel('Vitesse de rotation');
%     ylabel('Im(s)');
% end
% 
