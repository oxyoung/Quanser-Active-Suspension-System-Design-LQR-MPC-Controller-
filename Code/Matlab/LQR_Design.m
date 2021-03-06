%% Simulated Model
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

B2 = Bd(:,2)
B1 = Bd(:,1)
C1 = Cd(:,1)
C2 = Cd(:,2)
T = 0.002

% Pre-define Q and R
Q1 = [1000 0 0 0;
     0 500 0 0;
     0 0 250 0;
     0 0 0 1]
R = 0.001
[K1,P]=dlqr(Ad,B2,Q1,R)





