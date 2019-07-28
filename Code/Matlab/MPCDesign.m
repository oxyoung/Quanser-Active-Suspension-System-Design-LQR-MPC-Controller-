%% Estimated Model
Ad = [0.9970    0.0020    0.0021   -0.0019;
   -1.3927    0.9867   -0.0140    0.0131;
    0.0016    0.0000    0.9978    0.0019;
    1.6285    0.0156   -2.1388    0.9444]
Bd = [-0.0000    0.0000;
       0.0003    0.0009;
      -0.0020   -0.0000;
       0.0400   -0.0011]
Cd = [1.0000         0         0         0;
     -706.2857   -6.0524       0    6.0524]
Dd = [0   0;
      0   0.4762]

%% LQR Controller Design
B2 = Bd(:,2)
Q = [400 0 0 0;
     0 50 0 0;
     0 0 10 0;
     0 0 0 0.01];
R = 0.001
[K,P]=dlqr(Ad,B2,Q,R)

%% Design MPC controller
clear u x
%Build predictor equaiton.
N = 4;

m  = size(Ad,1);
n  = size(Ad,2);
Bd_fc = Bd(:,2);
n2 = size(Bd_fc,2);
Phi   = zeros(N*m,n);
Gamma = zeros(N*m,N*n2);
for i=1:N
   Phi((i-1)*m+1:i*m,:) = Ad^i;
end
for i=1:N
    for j=1:i
        Gamma((i-1)*m+1:i*m,(j-1)*n2+1:j*n2) = (Ad^(i-j))*Bd_fc;
    end
end
Mi = [0 0 0 0;
     0 0 0 0;
     1 0 0 0;
    -1 0 0 0;
     0 1 0 0;
     0 -1 0 0;];
E = [1;-1;0;0;0;0];
f = [4;4;0.01;0.01;0.2;0.2];  %8
D_curl = zeros((N+1)*size(Mi,1),n);
M = zeros((N+1)*size(Mi,1),N*n);
Eps = zeros((N+1)*size(Mi,1),N*size(E,2));
c = zeros((N+1)*size(Mi,1),size(f,2));
D_curl(1:size(Mi,1), :) = Mi;
for i=2:N+1
   M((i-1)*size(Mi,1)+1:i*size(Mi,1),(i-2)*n+1:(i-1)*n) = Mi;
end
for i=1:N
   Eps((i-1)*size(Mi,1)+1:i*size(Mi,1),(i-1)*size(E,2)+1:i*size(E,2)) = E;
end
for i=1:N+1
   c((i-1)*size(Mi,1)+1:i*size(Mi,1),:) = f;
end

P = eye(4);
Omega = zeros(N*m,N*m);
Psi   = zeros(N*n2,N*n2);

for i=1:N
    Omega((i-1)*n+1:i*n,(i-1)*n+1:i*n) = Q;
end

for i=1:N
    Psi((i-1)*n2+1:i*n2,(i-1)*n2+1:i*n2) = R;
end

% Objective function
F = 2*Gamma.'*Omega*Phi;
G = 2*(Psi + Gamma.'*Omega*Gamma);

% Constraints
J = M*Gamma+Eps;
W = -1*M*Phi-D_curl;

% Simulating Disturbance (Should run RoadBump.slx first)
T = 0.002
sim_time = 10; %run simulation for sim_time secs
time = (0:T:sim_time).'; %time vector
disturbance = simout.signals.values;
x(1,:) = [0 0 0 0]; %Initialise state at 0.
u(:,1) = disturbance;


for i=1:length(time)-1
%     MPC Controller
    U = quadprog(G,F*x(i,:).',J,c+W*x(i,:).'); %This has a horizon of 4.
    u(i,2) = U(1); %The optimal control input sequence.

%   LQR Controller
%     u(i,2) = -K * x(i,:).';
    %Plant simulation
    x(i+1,:) = x(i,:)*Ad.'+u(i,:)*Bd.';
end

y = x*Cd.'+u(1:length(time),:)*Dd.';

subplot(4,1,1);
plot(time,x(1:size(x,1),1),'r');
axis([3.3 4.6 -0.01 0.01])

y1 = ylabel('$z_s-z_{us}$', 'Interpreter','latex','Rotation',0);
set(gca, 'fontSize', 16);
set(y1, 'Units', 'Normalized', 'Position', [-0.07, 0.5, 0])
title('Simulated Model with MPC Controller', 'fontsize', 22);


subplot(4,1,2);
plot(time,x(1:size(x,1),2),'r');
axis([3.3 4.6 -0.2 0.2])

y2 = ylabel('$\dot{z_s}$', 'Interpreter','latex','Rotation',0);
set(gca, 'fontSize', 16);
set(y2, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0])

subplot(4,1,3);
plot(time,x(1:size(x,1),3),'r');
axis([3.3 4.6 -0.02 0.02])

y3 = ylabel('$z_{us}-z_r$', 'Interpreter','latex','Rotation',0);
set(y3, 'Units', 'Normalized', 'Position', [-0.07, 0.5, 0])
set(gca, 'fontSize', 16);

subplot(4,1,4);
plot(time,x(1:size(x,1),4),'r');
axis([3.3 4.6 -0.25 0.25])

y4 = ylabel('$\dot{z_{us}}$', 'Interpreter','latex','Rotation',0);
set(y4, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0])
xlabel('Samples');
set(gca, 'fontSize', 16);
legend('Model','sys')
axis([3.3 4.6 -0.4 0.4])

