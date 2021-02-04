% -------------------------------------------------------------------------
function [Outflow rho RampQueue] = ACTM(control,Link,dt,TotalTimeStep) 

% Traffic model -- Asymmetric Cell transmission model 
% References: Kurzhanskiy A and Varaiya P (2008) CTMSIM - An Interactive 
% macroscopic freeway traffic simulator. Research Report, EECS, UC Berkeley. 


% Outflow(i,t)   - flow [veh/hr] out of cell i during time interval t  
% rho(i,t)       - density [veh/mile] in cell i by the end of time interval t 

% ramp geometric parameters for ACTM: 
% -----------------------------------
% zeta(i)        - = '1' if ramp is at the upstream end 
% gamma(i)       - = '1' if ramp is at the upstream end 


% Initialize matrics
Outflow = zeros(length(Link), TotalTimeStep);
rho     = zeros(length(Link), TotalTimeStep);

zeta  = ones(length(Link),1);
gamma = ones(length(Link),1);

% Ramp variables 
RampDemand = zeros(length(Link), TotalTimeStep);
RampQueue  = zeros(length(Link), TotalTimeStep);
RampIn     = zeros(length(Link), TotalTimeStep);
RampOut    = zeros(length(Link), TotalTimeStep);
RampCap    = 18000*ones(length(Link),1);


% Off-ramp turning ratio 
beta       = zeros(length(Link), TotalTimeStep);    
for t = 1:TotalTimeStep 
    beta(4,t) = 0.3;
end


dt = dt/3600; 

for t = 1:TotalTimeStep
    
    % Initialize and compute on-ramp flow 
    % (Step 5, Kurzhanskiy and Varaiya)
    
    for i=1:length(Link)
        % demand profile resolution: 15-min
        % assume demand is normally distributed with variance = 10% of
        % mean 
        if t/900+1 > length(Link(i).Demand)
             RampDemand(i,t) = Link(i).Demand(end) + sqrt(0.1*Link(i).Demand(end))*randn(1);
        else
             RampDemand(i,t) = Link(i).Demand(floor(t/900)+1)+ ...
                 sqrt(0.1*Link(i).Demand(floor(t/900)+1))*randn(1);      
        end
        RampDemand(i,t) = max(RampDemand(i,t),0);
    end 
    
    % Compute on-ramp flows (Step 5, Kurzhanskiy and Varaiya)
    for i=1:length(Link)
        RampIn(i,t) = min(...
            min(RampDemand(i,t)+RampQueue(i,t)/dt,...
            zeta(i)*(Link(i).kjam - rho(i,t))*Link(i).Length/dt),... 
            RampCap(i)...
        );      
    end 
    
    % Update on-ramp queue (Step 6, urzhanskiy and Varaiya)
    for i=1:length(Link)
        RampQueue(i,t+1) = max(RampQueue(i,t)+(RampDemand(i,t)-RampIn(i,t))*dt,0);
    end
    
    % Compute cell-to-cell flows (Step 7, urzhanskiy and Varaiya)
    for i=1:length(Link)
        if i < length(Link)
            Outflow(i,t) = min(...
                (1-beta(i,t))*Link(i).V*(rho(i,t)+gamma(i)*RampIn(i,t)*dt/Link(i).Length),... 
                 min(Link(i).SatFlow,...
                 Link(i+1).W*(Link(i+1).kjam-(rho(i+1,t)+gamma(i+1)*RampIn(i+1,t)*dt/Link(i+1).Length)))...
            );
        else
             Outflow(i,t) = min(...
                (1-beta(i,t))*Link(i).V*(rho(i,t)+gamma(i)*RampIn(i,t)*dt/Link(i).Length),... 
                 Link(i).SatFlow...                 
             );
        end
    end
    
   
    % Compute off-ramp flows (Step 8, Kurzhanskiy and Varaiya)
    for i=1:length(Link)
        if beta(i,t) < 1
            RampOut(i,t) = (beta(i,t)/(1-beta(i,t)))*Outflow(i,t);
        else
            RampOut(i,t) = Link(i).V*(rho(i,t)+gamma(i)*RampIn(i,t)*dt/Link(i).Length); 
        end
    end
    
    
    % Update density (Step 9, Kurzhanskiy and Varaiya)
    for i = 1:length(Link) 
        if i > 1
            rho(i,t+1) = rho(i,t) + (Outflow(i-1,t)+RampIn(i,t)-Outflow(i,t)-RampOut(i,t))*dt/Link(i).Length;
        else
            rho(i,t+1) = rho(i,t) + (RampIn(i,t)-Outflow(i,t)-RampOut(i,t))*dt/Link(i).Length;
        end
    end
    
end

end


    