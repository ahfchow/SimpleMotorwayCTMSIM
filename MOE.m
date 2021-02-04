% -----------------------------------------------------------------
function [VHT VMT MainlineDelay RampDelay PL] = MOE(rho,Outflow,RampQueue,Link,control,dt,TotalTimeStep)

% Measure of Effectiveness 
% ----------------------------

dt = dt/3600; 
for i = 1:length(Link)
    for t = 1:TotalTimeStep
       VHT(i,t) = rho(i,t)*Link(i).Length*dt; 
       VMT(i,t) = Outflow(i,t)*Link(i).Length*dt;
       MainlineDelay(i,t) = max(0,VHT(i,t)-VMT(i,t)/Link(i).V); 
       RampDelay(i,t) = RampQueue(i,t)*dt;
       if rho(i,t) <= Link(i).kcrit 
           PL(i,t) = 0; 
       elseif control(i,t) == 1 
           PL(i,t) = (1-Outflow(i,t)/Link(i).SatFlow)*Link(i).Length*dt;
       else
           PL(i,t) = 0;
       end 
    end
end
