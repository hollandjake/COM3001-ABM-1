function create_environment(size)

	% CREATE_ENVIRONMENT creates the global environment data
	%
	% create_environment(S) creates an environment of size SxS

	global ENV_DATA PARAM DISPLAY

	ENV_DATA.units='metres';
	ENV_DATA.bm_size=size;

	ENV_DATA.pollen = zeros(size);
	
	% Create random locations in the data where flowers will be located
	flowerPositions = randperm(size^2, PARAM.NUM_FLOWERS);
	
	ENV_DATA.pollen(flowerPositions) = randi([PARAM.MIN_FLOWER_POLLEN, PARAM.MAX_FLOWER_POLLEN], 1, PARAM.NUM_FLOWERS);

	ENV_DATA.total_pollen = sum(sum(ENV_DATA.pollen));

	% Create random location for the hive
	ENV_DATA.hive_location = [randi(size),randi(size)];
end