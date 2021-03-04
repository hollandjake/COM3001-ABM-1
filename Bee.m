classdef Bee
	properties (SetAccess = private)
		pos             % (x,y)  current position
		target          % (x,y)  target location
		speed           % [int]  travel speed
		sensingRadius   % [int]  Radius where it can see
		storedPollen    % [int]  Pollen stored on the bee
		maxPollen       % [int]  Maximum pollen that can be stored on a bee
		isInfected      % [bool] Whether the bee has been infected with a mite
	end
	properties (Access=private)
		hiveLocation    % (x,y)  location of hive
	end
	properties (SetAccess=immutable)
		ID				% [int]	 unique identifier for the object, this is the index of the object in the array
	end

	methods
		function bee=Bee(id, hiveLocation, isInfected)
			bee.ID = id;
			bee.hiveLocation = hiveLocation;
			bee.isInfected = isInfected;

			bee.pos = hiveLocation;
			bee.target = libpointer; % null
			bee.storedPollen = 0;
			bee.sensingRadius = PARAMS.BEE_SENSING_RADIUS;

			if isInfected
				bee.speed = PARAMS.BEE_SPEED_INFECTED;
				bee.maxPollen = PARAMS.BEE_MAX_POLLEN_INFECTED;
			else
				bee.speed = PARAMS.BEE_SPEED_NORMAL;
				bee.maxPollen = PARAMS.BEE_MAX_POLLEN_NORMAL;
			end
		end
		
		function nearest_flower = findNearestFlower(obj, env)
			x = find(env.grid > 0);
		end

		function newMessages = process(obj, env, messages)
			% UPDATE Updates the Bee Agent
			newMessages = {Event(obj.ID, @Bee.collectPollen)};
		end
	end
	
	methods (Static, Access=private)
		function [caller, target] = collectPollen(caller, target)
			
		end
	end
end