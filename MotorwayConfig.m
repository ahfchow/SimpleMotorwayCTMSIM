function [result]=MotorwayConfig(z,varargin)

if(strcmp(z,'Links'))
    % Link configuration 
    Link(1).FrNode = -1;
    Link(1).ToNode = 1;
    Link(1).Length = 0.5; 
    Link(1).V = 100;
    Link(1).SatFlow = 6000;
    Link(1).kjam = 440;
    Link(1).Demand = [4700 4850 4700 0]; 
    
    Link(2).FrNode = 1;
    Link(2).ToNode = 2;
    Link(2).Length = 0.5; 
    Link(2).V = 100;
    Link(2).SatFlow = 6000;
    Link(2).kjam = 440;
    Link(2).Demand = 0; 
    
    Link(3).FrNode = 2;
    Link(3).ToNode = 3;
    Link(3).Length = 0.5; 
    Link(3).V = 100;
    Link(3).SatFlow = 6000;
    Link(3).kjam = 440;
    Link(3).Demand = 0; 
    
    Link(4).FrNode = 3;
    Link(4).ToNode = 4;
    Link(4).Length = 0.5; 
    Link(4).V = 100;
    Link(4).SatFlow = 6000;
    Link(4).kjam = 440;
    Link(4).Demand = [0 1250 0]; 
    
    Link(5).FrNode = 4;
    Link(5).ToNode = 5;
    Link(5).Length = 0.5; 
    Link(5).V = 100;
    Link(5).SatFlow = 6000;
    Link(5).kjam = 440;
    Link(5).Demand = [1100 850 1100 0];  
    
    Link(6).FrNode = 5;
    Link(6).ToNode = 6;
    Link(6).Length = 0.5; 
    Link(6).V = 100;
    Link(6).SatFlow = 6000;
    Link(6).kjam = 440;
    Link(6).Demand = 0; 
    
    Link(7).FrNode = 6;
    Link(7).ToNode = 7;
    Link(7).Length = 0.5; 
    Link(7).V = 100;
    Link(7).SatFlow = 6000;
    Link(7).kjam = 440;
    Link(7).Demand = [1100 1250 1100 0];   
   
    Link(8).FrNode = 7;
    Link(8).ToNode = 8;
    Link(8).Length = 0.5; 
    Link(8).V = 100;
    Link(8).SatFlow = 6000;
    Link(8).kjam = 440;
    Link(8).Demand = 0; 
    
    Link(9).FrNode = 8;
    Link(9).ToNode = 9;
    Link(9).Length = 0.5; 
    Link(9).V = 100;
    Link(9).SatFlow = 6000;
    Link(9).kjam = 440;
    Link(9).Demand = 0; 
   
    Link(10).FrNode = 9;
    Link(10).ToNode = -1;
    Link(10).Length = 0.5; 
    Link(10).V = 100;
    Link(10).SatFlow = 6000;
    Link(10).kjam = 440;
    Link(10).Demand = 0; 

    
    for i = 1:length(Link) 
        Link(i).kcrit = Link(i).SatFlow/Link(i).V;
        Link(i).W = Link(i).SatFlow/(Link(i).kjam-Link(i).kcrit);
%         if Link(i).FrNode > 0
%             Link(i).Demand = 0; 
%         elseif Link(i).Demand == 0 
%             warning(['there is no demand from source Link ' num2str(i)]);
%         end
    end
    
    result = Link;
    return
end




