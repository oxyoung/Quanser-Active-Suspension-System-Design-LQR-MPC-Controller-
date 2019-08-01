# Quanser Active Suspension System Design (LQR MPC Controller)
## Introduction
This repository contains the code of designing Linear Quadratic Regulator (LQR) and Model Predictive Controller (MPC) to achieve desired performance based on Quanser Active Suspension System. The code should be run in MATLAB and Labview.
The finished tasks are as follow:
1. The simulated system model is determined based on the experiment data by using least square method. 
2. LQR and MPC controllers are designed according to three performance specifications: ride comfort, suspension travel and road handling. In addition, the performances of the designed controllers are simulated in Simulink.
3. Implement the designed LQR and MPC controllers on the real Quanser Active Suspension System.
## Get Started
Firstly, download or clone the repository to a local folder.

**System Identification**
1. Run model_Estimation.m file to start system identification process.
2. The default path for experiment data is:
**inputfile = '..\..\ExperimentData\SystemID Data\input2.csv'; 
outputfile = '..\..\ExperimentData\SystemID Data\output2.csv';**
Please make sure the CSV files are in the corresponding paths, or the paths should be altered according to the new locations.

**LQR Controller Design**
1. Open LQR_Design.m to run the LQR controller design process. 
2. Open LQR_Implementation.slx file to simulate the performance of LQR controller in Simulink. The achieved feedback gain in step 1 is used in step 2 to generate LQR control effort.
3. Monitoring every scope can check the performance of every state.

**MPC Controller Design**
1. Run RoadBump.slx in Simulink to simulate the road bump disturbance.
2. Open MPC_Design.m file to simulate the performance of MPC controller. Varying weighting matrix of Q and R and altering prediction horizon will change the performance of MPC controller.
