%Ride Comfort
% plot(simout.time, simout.signals.values, 'k')
% hold on
% plot(simout1.time, simout1.signals.values,'g')
% plot(simout2.time, simout2.signals.values,'b')
% plot(simout3.time, simout3.signals.values,'r')
% xlabel('Time (s)')
% h = ylabel('$\ddot{z_s}$ ($m/s^2$)')
% set(h,'Interpreter','latex')
% title('Acceleration of Sprung Part with LQR Controller')
% l = legend('Without LQR', '$Q_2=10$', '$Q_2=100$', '$Q_2=1000$')
% set(l,'Interpreter','latex')
% axis([3.3,4,-5,5])
% 
% %Ride Comfort input Fc
% plot(simout4.time, simout4.signals.values, 'k')
% hold on
% plot(simout5.time, simout5.signals.values,'b')
% plot(simout6.time, simout6.signals.values,'r')
% xlabel('Time (s)')
% % d = ylabel('$F_c$ (N)')
% set(d,'Interpreter','latex')
% h = title('Input Signal $F_c$')
% set(h,'Interpreter','latex')
% l = legend('$Q_2=10$', '$Q_2=100$', '$Q_2=1000$')
% set(l,'Interpreter','latex')
% axis([3.3,5,-22,19])
% 
% % %Without
% A = [simout.signals.values];
% B = [simout7.signals.values(1:5001)];
% d1 = norm(A-B,1)/5001
% %Q=10
% A = [simout1.signals.values];
% B = [simout7.signals.values(1:5001)];
% d2 = norm(A-B,1)/5001
% 
% %Q=100
% A = [simout2.signals.values];
% B = [simout7.signals.values(1:5001)];
% d3 = norm(A-B,1)/5001
% 
% %Q=1000
% A = [simout3.signals.values];
% B = [simout7.signals.values(1:5001)];
% d4 = norm(A-B,1)/5001


%Suspension Travel
% plot(simout11.time, simout11.signals.values, 'k')
% hold on
% plot(simout8.time, simout8.signals.values,'g')
% plot(simout9.time, simout9.signals.values,'b')
% plot(simout10.time, simout10.signals.values,'r')
% xlabel('Time (s)')
% d = ylabel('$z_s-z_{us}$ (m)')
% set(d,'Interpreter','latex')
% title('Displacement between Unsprung and Sprung Parts with LQR Controller')
% l = legend('Without LQR', '$Q_1=1000$', '$Q_1=10000$', '$Q_1=100000$')
% set(l,'Interpreter','latex')
% axis([3.3,5,-0.006,0.006])

%Suspension Travel Fc
% plot(simout4.time, simout4.signals.values, 'k')
% hold on
% plot(simout5.time, simout5.signals.values,'b')
% plot(simout6.time, simout6.signals.values,'r')
% xlabel('Time (s)')
% d = ylabel('$F_c$ (N)')
% set(d,'Interpreter','latex')
% h = title('Input Signal $F_c$')
% set(h,'Interpreter','latex')
% l = legend('$Q_1=1000$', '$Q_1=10000$', '$Q_1=100000$')
% set(l,'Interpreter','latex')
% axis([3.3,4.6,-55,55])

% % %Without
% A = [simout.signals.values];
% B = [simout7.signals.values(1:5001)];
% d1 = norm(A-B,1)/5001
% %Q=10
% A = [simout8.signals.values];
% B = [simout7.signals.values(1:5001)];
% d2 = norm(A-B,1)/5001
% 
% %Q=100
% A = [simout9.signals.values];
% B = [simout7.signals.values(1:5001)];
% d3 = norm(A-B,1)/5001
% 
% %Q=1000
% A = [simout10.signals.values];
% B = [simout7.signals.values(1:5001)];
% d4 = norm(A-B,1)/5001

%Road handling
% plot(simout12.time, simout12.signals.values, 'k')
% hold on
% plot(simout13.time, simout13.signals.values,'g')
% plot(simout14.time, simout14.signals.values,'b')
% plot(simout15.time, simout15.signals.values,'r')
% xlabel('Time (s)')
% d = ylabel('$z_{us}-z_r$ (m)')
% set(d,'Interpreter','latex')
% title('Displacement between Unsprung Part and Road with LQR Controller')
% l = legend('Without LQR', '$Q_3=1000$', '$Q_3=10000$', '$Q_3=1000000$')
% set(l,'Interpreter','latex')
% axis([3.3,4.7,-0.011,0.011])

%% Suspension Travel Fc
% plot(simout4.time, simout4.signals.values, 'k')
% hold on
% plot(simout5.time, simout5.signals.values,'b')
% plot(simout6.time, simout6.signals.values,'r')
% xlabel('Time (s)')
% d = ylabel('$F_c$ (N)')
% set(d,'Interpreter','latex')
% h = title('Input Signal $F_c$')
% set(h,'Interpreter','latex')
% l = legend('$Q_3=1000$', '$Q_3=10000$', '$Q_3=1000000$')
% set(l,'Interpreter','latex')
% axis([3.3,4.6,-250,250])

%% LQR and MPC Comparison
% % State 1
plot(time,x(1:size(x,1),1),'r');
hold on
plot(time,xCopy(1:size(x,1),1),'b');
axis([3.3 4.7 -0.01 0.01])
xlabel('Time (s)')
d = ylabel('$z_s-z_{us}$ (m)')
set(d,'Interpreter','latex')
title('Displacement between Unsprung and Sprung Parts')
legend('MPC', 'LQR')

% % State 2
% plot(time,x(1:size(x,1),2),'r');
% hold on
% plot(time,xCopy(1:size(x,1),2),'b');
% axis([3.3 4.6, -0.2 0.2])
% xlabel('Time (s)')
% d = ylabel('$\dot{z_s}$ ($m/s$)');
% set(d,'Interpreter','latex')
% title('Velocity of Sprung Parts')
% legend('MPC', 'LQR')

% % State 3
% plot(time,x(1:size(x,1),3),'r');
% hold on
% plot(time,xCopy(1:size(x,1),3),'b');
% axis([3.3 4.6 -0.01 0.01])
% xlabel('Time (s)')
% d = ylabel('$z_{us}-z_r$ (m)')
% set(d,'Interpreter','latex')
% title('Displacement between Unsprung Part and Road')
% legend('MPC', 'LQR')

% % Fc
plot(time, u(:,2),'r')
hold on 
plot(time, uCopy(:,2),'b')
xlabel('Time (s)')
d = ylabel('$F_c$ (N)')
set(d,'Interpreter','latex')
h = title('Input Signal $F_c$')
set(h,'Interpreter','latex')
legend('MPC', 'LQR')
axis([3.3,4.6,-16,16])

%% L1-norm MPC
% state 1
A = [x(1:size(x,1),1)];
B = [simout1.signals.values(1:5001)];
d1 = norm(A-B,1)/5001
% state 2
A = [x(1:size(x,1),2)];
B = [simout1.signals.values(1:5001)];
d2 = norm(A-B,1)/5001
% state 3
A = [x(1:size(x,1),3)];
B = [simout1.signals.values(1:5001)];
d3 = norm(A-B,1)/5001

%% L1-norm LQR
% state 1
A = [xCopy(1:size(x,1),1)];
B = [simout1.signals.values(1:5001)];
d1 = norm(A-B,1)/5001
% state 2
A = [xCopy(1:size(x,1),2)];
B = [simout1.signals.values(1:5001)];
d2 = norm(A-B,1)/5001
% state 3
A = [xCopy(1:size(x,1),3)];
B = [simout1.signals.values(1:5001)];
d3 = norm(A-B,1)/5001
