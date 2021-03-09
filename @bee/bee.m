classdef bee   %declares bee object
    properties    %define bee properties (parameters) 
        pos					% [x,y]  current position
		target				% [x,y]  target location
		speed				% (int)  travel speed
		sensing_radius		% (int)  Radius where it can see
		collected_pollen	% (int)  Pollen stored on the bee
		max_pollen			% (int)  Maximum pollen that can be stored on a bee
		is_infected			% (bool) Whether the bee has been infected with a mite
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
			b.collected_pollen = 0;
			b.sensing_radius = PARAM.BEE_SENSING_RADIUS;
			
			if is_infected
				b.speed = PARAM.BEE_SPEED_INFECTED;
				b.max_pollen = PARAM.BEE_MAX_POLLEN_INFECTED;
			else
				b.speed = PARAM.BEE_SPEED_NORMAL;
				b.max_pollen = PARAM.BEE_MAX_POLLEN_NORMAL;
			end
        end

        function bee=update(bee)
        	should_move = true;

        	% If bee is full then it should just go back to the hive
        	if bee.collected_pollen == bee.max_pollen
        		bee.target = bee.hive_location;

				% If bee is ontop of the hive (within 2 d.p.)
				if round(bee.pos, 2) == bee.hive_location
					bee = deposit_pollen(bee);
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
