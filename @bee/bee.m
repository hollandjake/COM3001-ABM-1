classdef bee   %declares bee object
    properties    %define bee properties (parameters) 
        pos					% [x,y]  current position
		target				% [x,y]  target location
		speed				% (int)  travel speed
		direction			% [x,y]  current direction
		collected_pollen	% (int)  Pollen stored on the bee
		distance_travelled	% (int)  Distance travelled
	end
	properties (SetAccess=immutable)
		max_distance		% (int)  Max distance to travel
		is_infected			% (bool) Whether the bee has been infected with a mite
		max_pollen			% (int)  Maximum pollen that can be stored on a bee
		sensing_radius		% (int)  Radius where it can see
	end
	properties (GetAccess=private, SetAccess=immutable)
		hive_location		% [x,y]  location of hive
	end
    methods
        function b=bee(pos, is_infected) %constructor method for bee - assigns values to bee properties
			global ENV_DATA PARAM;
			b.pos = pos;
			b.hive_location = ENV_DATA.hive_location;
			b.is_infected = is_infected;
			b.target = [];
			b.direction = [];
			b.collected_pollen = 0;
			b.distance_travelled = 0;
			
			if is_infected
				b.speed = PARAM.BEE_SPEED_INFECTED * (1+(randn-0.5)*0.2);
				b.max_pollen = PARAM.BEE_MAX_POLLEN_INFECTED;
				b.max_distance = PARAM.BEE_MAX_DISTANCE_INFECTED;
				b.sensing_radius = PARAM.BEE_SENSING_RADIUS_INFECTED;
			else
				b.speed = PARAM.BEE_SPEED_NORMAL * (1+(randn-0.5)*0.2);
				b.max_pollen = PARAM.BEE_MAX_POLLEN_NORMAL;
				b.max_distance = PARAM.BEE_MAX_DISTANCE_NORMAL;
				b.sensing_radius = PARAM.BEE_SENSING_RADIUS;
			end
        end

        function bee=update(bee)
			global N_IT;
        	should_move = true;

        	% If bee is full then it should just go back to the hive
        	if (bee.collected_pollen == bee.max_pollen) || (bee.distance_travelled >= bee.max_distance-bee.speed)
        		bee.target = bee.hive_location;
				bee.distance_travelled = 0;
				bee = move(bee);

				% If bee is ontop of the hive (within 2 d.p.)
				if round(bee.pos, 2) == bee.hive_location
					bee = deposit_pollen(bee);
					bee.distance_travelled = 0;
				end
        	else
        		% If bee doesnt have a target then try to find a flower
                if isempty(bee.target)
                    bee.target = find_flower(bee);
                end

                % If we have a target location
                if ~isempty(bee.target)
					
                    % If bee is ontop of the target (within 2 d.p.)
                    if round(bee.pos,2) == bee.target
                        % Collect pollen from the flower
                        [bee, new_pollen] = collect_pollen(bee);

                        % If it didnt collect any pollen then it 
						% should move
                        if new_pollen > 0
                            should_move = false;
                        else
                            % remove target so it can wonder around looking
                            % for new flower
                            bee.target = [];
                            should_move = true;
                        end
                    end
                end
        	end

			% If the bee should move then it can do so
            if should_move
                bee = move(bee);
            end
		end
    end
end
