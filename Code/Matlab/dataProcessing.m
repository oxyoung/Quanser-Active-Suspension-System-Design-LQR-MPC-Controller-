%This function pre-processes the experiment data files.
function [ x, u, y ] = dataProcessing(inputfile, outputfile)
    %Read in a data set to use to perform linear regression to fit the model.
    data = csvread(outputfile,1);
    data2 = csvread(inputfile,1);
    NUM_SAMP = size(data,1); %Number of samples
    NUM_SAMP2 = size(data2,1);
    T = 0.002; %Sample period.

    x = zeros(NUM_SAMP, 4); %Sate vector.
    u = zeros(NUM_SAMP2, 2); %Input vector.

    %Construct states, input and output from data.
    %x1 = z_s - z_us
    x(:,1) = data(:,6) - data(:,4); 

    %x2 = zs_dot
    x(2:NUM_SAMP,2) = data(2:NUM_SAMP,6) - data(1:NUM_SAMP-1,6); %Backward difference
    x(:,2) = x(:,2)/T; %Now it is a velocity approximation. 

    %x3 = z_us - z_r
    x(:,3) = data(:,4) - data(:,2);

    %x4 = z_usdot
    x(2:NUM_SAMP,4) = data(2:NUM_SAMP,4) - data(1:NUM_SAMP-1,4); %Backward difference.
    x(:,4) = x(:,4)/T; %Now it is a velocity approximation.

    %u1 = z_rdot
    u(2:NUM_SAMP,1) = data(2:NUM_SAMP,2) - data(1:NUM_SAMP-1,2); %Backward difference.
    u(:,1) = u(:,1)/T; %Now it is a velocity approximation.

    %u2 = Fc
    u(:,2) = data2(:,2);

    %y1 = x1
    y(:,1)=x(:,1);

    %y2 = x2dot
    y(3:NUM_SAMP,2) = data(3:NUM_SAMP,6) - 2*data(2:NUM_SAMP-1,6) + data(1:NUM_SAMP-2,6);
    y(:,2) = y(:,2)/T^2;
    
    %LPF to get rid off high frequency noise brought by derivative action
    x(:,2) = lowpass(x(:,2),50,500); 
    x(:,4) = lowpass(x(:,4),50,500);
    u(:,1) = lowpass(u(:,1),50,500);
    x(:,2) = smooth(x(:,2),25);
    x(:,4) = smooth(x(:,4),25);
    u(:,1) = smooth(u(:,1),25);
end