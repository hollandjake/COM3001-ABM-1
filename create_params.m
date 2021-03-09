function create_params(num_flowers)
	
	% CREATE_PARAMS initializes the global PARAM which houses the constants
	% used throught the program

	global PARAM
	
	%Environment
	PARAM.NUM_FLOWERS = num_flowers; % Total number of flowers distributed throughout the map
	PARAM.MIN_FLOWER_POLLEN = 1;
	PARAM.MAX_FLOWER_POLLEN	= 10;
	PARAM.NUM_AGENTS = 100;
	PARAM.INFECTED_AGENTS = 10;
		
	%BEE
	PARAM.BEE_SPEED_NORMAL = 2;
	PARAM.BEE_MAX_POLLEN_NORMAL	= 3;
		
	PARAM.BEE_SPEED_INFECTED = 1;
	PARAM.BEE_MAX_POLLEN_INFECTED = 2;

	PARAM.BEE_SENSING_RADIUS = 2;
    
    
    