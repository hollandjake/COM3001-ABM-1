classdef PARAMS
	%PARAM Global parameters of the system
	
	properties (Constant)
		%Environment
		NUM_FLOWERS				= 10; % Total number of flowers distributed throughout the map
		MIN_FLOWER_POLLEN		= 1;
		MAX_FLOWER_POLLEN		= 10;
		NUM_AGENTS				= 100;
		INFECTED_AGENTS			= 10;
		
		%BEE
		BEE_SPEED_NORMAL		= 2;
		BEE_MAX_POLLEN_NORMAL	= 500;
		
		BEE_SPEED_INFECTED		= 1;
		BEE_MAX_POLLEN_INFECTED = 250;

		BEE_SENSING_RADIUS		= 2;
	end
end

