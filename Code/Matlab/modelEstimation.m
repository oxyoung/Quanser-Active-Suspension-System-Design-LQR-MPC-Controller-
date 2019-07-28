%% Load experiment data
inputfile = '..\..\ExperimentData\SystemID Data\input2.csv';
outputfile = '..\..\ExperimentData\SystemID Data\output2.csv';
[ x, u, y ] = dataProcessing(inputfile, outputfile);
NUM_SAMP = size(x,1);
T = 0.002;

%% Perform least square estimation.
%Set up matrices.
Psi1 = [x(1:NUM_SAMP-1,:) u(1:NUM_SAMP-1,:)];
Y1 = x(2:NUM_SAMP,1);
Theta1 = inv(Psi1.'*Psi1)*Psi1.'*Y1;

Psi2 = [x(1:NUM_SAMP-1,:), u(1:NUM_SAMP-1,:)];
Y2 = x(2:NUM_SAMP,2);
Theta2 = inv(Psi2.'*Psi2)*Psi2.'*Y2;

Psi3 = [x(1:NUM_SAMP-1,:), u(1:NUM_SAMP-1,:)];
Y3 = x(2:NUM_SAMP,3);
Theta3 = inv(Psi3.'*Psi3)*Psi3.'*Y3;

Psi4 = [x(1:NUM_SAMP-1,:), u(1:NUM_SAMP-1,:)];
Y4 = x(2:NUM_SAMP,4);
Theta4 = inv(Psi4.'*Psi4)*Psi4.'*Y4;

Psi5 = [x(1:NUM_SAMP-1,1:2) x(1:NUM_SAMP-1,4) u(1:NUM_SAMP-1,2)];
Y5 = y(2:NUM_SAMP,2);
Theta5 = inv(Psi5.'*Psi5)*Psi5.'*Y5;

%% Estimated model
Ad = [Theta1(1:4,1).';
      Theta2(1:4,1).';
      Theta3(1:4,1).';
      Theta4(1:4,1).'];
 
Bd = [Theta1(5:6,1).';
      Theta2(5:6,1).';
      Theta3(5:6,1).';
      Theta4(5:6,1).'];   

Cd = [1 0 0 0;
     Theta5(1:2,1).', 0, Theta5(3,1)];

Dd = [0 0;
      0, Theta5(4,1)]; 

 
%% Estimated model performance over test dataset
inputfile = '..\..\ExperimentData\SystemID Data\testinput1.csv';
outputfile = '..\..\ExperimentData\SystemID Data\testoutput1.csv';
[x, u] = dataProcessing(inputfile, outputfile);
[y_model, x_model] = modelDT(x(1,:), u, Ad, Bd, Cd, Dd);

% Plot all states output
figure(1)
subplot(4,1,1);
plot(x(1:14951,1),'r');
hold on
plot(x_model(1:14951,1),'b');

y1 = ylabel('$z_s-z_{us}$', 'Interpreter','latex','Rotation',0);
set(gca, 'fontSize', 16);
set(y1, 'Units', 'Normalized', 'Position', [-0.1, 0.4, 0])
title('Model and Real System States', 'fontsize', 22);

subplot(4,1,2);
plot(x(1:14951,2),'r');
hold on
plot(x_model(1:14951,2),'b');

y2 = ylabel('$\dot{z_s}$', 'Interpreter','latex','Rotation',0);
set(gca, 'fontSize', 16);
set(y2, 'Units', 'Normalized', 'Position', [-0.1, 0.4, 0])
subplot(4,1,3);
plot(x(1:14951,3),'r');
hold on
plot(x_model(1:14951,3),'b');

y3 = ylabel('$z_{us}-z_r$', 'Interpreter','latex','Rotation',0);
set(y3, 'Units', 'Normalized', 'Position', [-0.1, 0.4, 0])
set(gca, 'fontSize', 16);

subplot(4,1,4);
plot(x(1:14951,4),'r');
hold on
plot(x_model(1:14951,4),'b');

y4 = ylabel('$\dot{z_{us}}$', 'Interpreter','latex','Rotation',0);
set(y4, 'Units', 'Normalized', 'Position', [-0.1, 0.4, 0])
xlabel('Samples');
set(gca, 'fontSize', 16);
legend('Real sys', 'Model')


