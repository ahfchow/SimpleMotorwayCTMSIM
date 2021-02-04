
% A script written for running CTM simulation of motorways 
%
% by: Andy Chow
% Centre for Transport Studies
% University College London  
% revised: OCT 2012 
% 
% This is the 'MAIN' program 
% 
% Configuration file: "MotorwayConfig.m"
%
% sub-program: 
% --------------
% 1. ACTM.m           - Aymmetric CTM Simulator (for motorway traffic
%    simulation)
% 2. MOE.m            - Calculation of 'Measures of Effectiveness'



% Simulation settings
dt = 1;                             % simulation sampling time step - [sec] 
TotalTimeStep = 3000;               % Total number of simiulation time steps 


% Import network configuration: 
[Link] = MotorwayConfig('Links');

% Calculate control vector 
control = ones(length(Link),TotalTimeStep); % No Control 

% Traffic state updates (with Cell transmission model) 
[Outflow rho RampQueue] = CTM(control,Link,dt,TotalTimeStep); 

% Calculate the performance indices (VHT, VMT, MainlineDelay, RampDelay, Productivity Loss) 
[VHT VMT MainlineDelay RampDelay PL] = MOE(rho,Outflow,RampQueue,Link,control,dt,TotalTimeStep);
% total system delay
Delay = MainlineDelay + RampDelay; 


% Plot of total delay, mainline delay, and ramp delay 
figure;
hold on;
plot(sum(MainlineDelay,1),'g')
plot(sum(RampDelay,1),'r')
plot(sum(Delay,1),'b')
legend('Mainline','Ramp','Total');
xlabel('Time [sec]','fontsize',18);
ylabel('Total network delay [veh-hr/sec]','fontsize',18); 
title('Delays','fontsize',18);
hold off


% Density contour along main-line
figure;
hold on;
[X,Y] = meshgrid(1:TotalTimeStep, 1:length(Link));  
h = surf(X,Y,rho(:,1:TotalTimeStep));    
shading flat;
xlabel('Time','fontsize',18); 
ylabel('Location','fontsize',18)
title('Density contour') 
% colormap gray  
set(gca,'FontSize',18)
colorbar('fontsize',18)
hold off;
