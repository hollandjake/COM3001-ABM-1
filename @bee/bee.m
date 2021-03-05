classdef bee   %declares bee object
    properties    %define bee properties (parameters) 
        pos             % [x,y]  current position
		target          % [x,y]  target location
		speed           % (int)  travel speed
		sensing_radius   % (int)  Radius where it can see
		stored_pollen    % (int)  Pollen stored on the bee
		max_pollen       % (int)  Maximum pollen that can be stored on a bee
		is_infected      % (bool) Whether the bee has been infected with a mite
	end
	properties (GetAccess=private, SetAccess=immutable)
		hive_location    % [x,y]  location of hive
	end
    methods
        function b=bee(pos, is_infected) %constructor method for bee - assigns values to bee properties
			global ENV_DATA PARAM;
			b.pos = pos;
			b.hive_location = ENV_DATA.hive_location;
			b.is_infected = is_infected;
			b.target = [];
			b.stored_pollen = 0;
			b.sensing_radius = PARAM.BEE_SENSING_RADIUS;
			
			if is_infected
				b.speed = PARAM.BEE_SPEED_INFECTED;
				b.max_pollen = PARAM.BEE_MAX_POLLEN_INFECTED;
			else
				b.speed = PARAM.BEE_SPEED_NORMAL;
				b.max_pollen = PARAM.BEE_MAX_POLLEN_NORMAL;
			end
        end
    end
end
