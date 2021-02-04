# SimpleMotorwayCTMSIM

This is a simple motorway simulator developed in MATLAB (mainly prepared for students with little experience on computer coding) with an on-ramp based upon cell transmission model (CTM). The CTM computation is implemented mainly based on work by Kurzhanskiy and Varaiya (2008). 

- Reference: 
Kurzhanskiy A and Varaiya P (2008) CTMSIM - An Interactive macroscopic freeway traffic simulator. Research Report, EECS, UC Berkeley. 


## Input file: 
1. MotorwayConfig.m 

## Main program: 
1. CTM_Motorway.m 
 
## Sub-programs / functions: 
1. CTM.m            - Simulator based upon cell transmission model
2. MOE.m            - Calculation of 'Measures of Effectiveness'
3. ControlVector.m  - Generation of 'control' vector based on given signal timing plan


## Output  
1. delays (mainline, ramp, total) 
2. density contour


