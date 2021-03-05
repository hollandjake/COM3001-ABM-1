function create_params

%set up breeding, migration and starvation threshold parameters. These
%are all completely made up!

%PARAM - structure containing values of all parameters governing agent
%behaviour for the current simulation

global PARAM

    PARAM.R_SPD=2;         %speed of movement - units per itn (rabbit)
    PARAM.F_SPD=5;         %speed of movement - units per itn (fox)
    PARAM.R_BRDFQ=10;      %breeding frequency - iterations
    PARAM.F_BRDFQ=21;
    PARAM.R_MINFOOD=0;      %minimum food threshold before agent dies 
    PARAM.F_MINFOOD=0;
    PARAM.R_FOODBRD=10;     %minimum food threshold for breeding
    PARAM.F_FOODBRD=10;
    PARAM.R_MAXAGE=50;      %maximum age allowed 
    PARAM.F_MAXAGE=50;
    
    %DUMMY VALUES FOR NOW CHANGE LATER
    
    PARAM.B_SPD=5;              %speed of movement - units per itn (healthy bee)
    PARAM.I_SPD=5;              %speed of movement - units per itn (infected bee)
    PARAM.MAXFLWPCOUNT=10;      %max amount of pollen a flower can hold
    PARAM.MINFLWPCOUNT=1;       %min amount of pollen a flower can hold
    PARAM.B_MAXPCOUNT=0.05;     %maximum pollen threshold that healthy bee can carry
    PARAM.I_MAXPCOUNT=0.02;     %maximum pollen threshold that infected bee can carry
    PARAM.B_SNSINGRAD=20;       %maximum sensing radius of bee
	
	
	%Environment
	PARAM.NUM_FLOWERS = 10; % Total number of flowers distributed throughout the map
	PARAM.MIN_FLOWER_POLLEN = 1;
	PARAM.MAX_FLOWER_POLLEN	= 10;
	PARAM.NUM_AGENTS = 100;
	PARAM.INFECTED_AGENTS = 10;
		
	%BEE
	PARAM.BEE_SPEED_NORMAL = 2;
	PARAM.BEE_MAX_POLLEN_NORMAL	= 500;
		
	PARAM.BEE_SPEED_INFECTED = 1;
	PARAM.BEE_MAX_POLLEN_INFECTED = 250;

	PARAM.BEE_SENSING_RADIUS = 2;
    
    
    