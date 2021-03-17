function create_environment(size)

	% CREATE_ENVIRONMENT creates the global environment data
	%
	% create_environment(S) creates an environment of size SxS

	global ENV_DATA PARAM DISPLAY

	ENV_DATA.units='metres';
	ENV_DATA.bm_size=size;

	ENV_DATA.pollen = zeros(size);
	
	% Create random locations in the data where flowers will be located
	flower_positions = randperm(size^2, PARAM.NUM_FLOWERS);
	[flower_pos_x, flower_pos_y] = ind2sub(size, flower_positions);
	ENV_DATA.flower_positions = [flower_pos_x; flower_pos_y];
	
	ENV_DATA.pollen(flower_positions) = randi([PARAM.MIN_FLOWER_POLLEN, PARAM.MAX_FLOWER_POLLEN], 1, PARAM.NUM_FLOWERS);
	ENV_DATA.total_pollen = sum(sum(ENV_DATA.pollen));

	% Create random location for the hive
	ENV_DATA.hive_location = [size/2, size/2];
end