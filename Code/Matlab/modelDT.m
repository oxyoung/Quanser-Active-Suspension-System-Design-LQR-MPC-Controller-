
function [ y, x ] = modelDT( x0, u, Ad, Bd, Cd, Dd )
% Returns output and state of system.

 NUM_SAMP = size(u,1);
 NUM_STAT = size(x0, 2);
 x = zeros(NUM_SAMP,NUM_STAT);
 
 x(1,:) = x0;
 
 for k=1:NUM_SAMP-1
     x(k+1,:) = x(k,:)*Ad.' + u(k,:)*Bd.';
 end
 
 y = x*Cd.' + u*Dd.';

end

