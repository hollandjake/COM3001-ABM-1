classdef Bee
	properties (SetAccess = private)
		pos             % [x,y]  current position
		target          % [x,y]  target location
		speed           % (int)  travel speed
		sensingRadius   % (int)  Radius where it can see
		storedPollen    % (int)  Pollen stored on the bee
		maxPollen       % (int)  Maximum pollen that can be stored on a bee
		isInfected      % (bool) Whether the bee has been infected with a mite
	end
	properties (Access=private)
		hiveLocation    % [x,y]  location of hive
	end
	properties (SetAccess=immutable)
		ID				% (int)	 unique identifier for the object, this is the index of the object in the array
	end

	methods
		function bee=Bee(id, hiveLocation, isInfected)
			bee.ID = id;
			bee.hiveLocation = hiveLocation;
			bee.isInfected = isInfected;

			bee.pos = hiveLocation;
			bee.target = []; % null
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

		function [bee, newMessages] = process(bee)
			% UPDATE Updates the Bee Agent
			global ENV;
			
			if isempty(bee.target)
				bee.target = Bee.findFlower(bee);
			end
			
			% If Bee has a target
			if ~isempty(bee.target)
				% Is Bee at target
				if round(bee.pos) == bee.target
					bee.collectPollen()
				else
					
				end
			end
			
			if ~isempty(bee.target)
				% Move towards target
				dir = bee.target - bee.pos;
			else
				% Move randomly
				rot = rand*2*pi;
				dir = [cos(rot),sin(rot)];
			end
			
			l = norm(dir);
			if (l < bee.speed)
				newpos = bee.pos + dir;
			else
				newpos = bee.pos + (dir/l) * bee.speed;
			end
			
			bee.pos = constrain(newpos, 0, ENV.SIZE);
			
			
			newMessages = {};%{Event(bee.ID, @bee.collectPollen)};
		end
	end
	
	methods (Static, Access=private)
		function [caller, target] = collectPollen(caller, target)
% 			disp('monch')
		end
		
		function target = findFlower(bee)
			global ENV;
			beePos = round(bee.pos);
			minX = constrain(beePos(1)-bee.sensingRadius,1,ENV.SIZE);
			maxX = constrain(beePos(1)+bee.sensingRadius,1,ENV.SIZE);
			minY = constrain(beePos(2)-bee.sensingRadius,1,ENV.SIZE);
			maxY = constrain(beePos(2)+bee.sensingRadius,1,ENV.SIZE);
			
			beeOffset = beePos - [minX,minY];
			searchField = ENV.grid(minY:maxY,minX:maxX);
			if (beePos(1) > 10 || beePos(2) > 10)
				disp(beePos);
			end
			if (beeOffset(1) < 1 || beeOffset(2) < 1)
				disp(beeOffset);
			end
			searchField(beeOffset) = 0; % Stop the bee going to the cell it is over
			[y,x] = find(searchField > 0); % Find all cells containing flowers with pollen levels > 0
			squaredDist = (x-beeOffset(:,1)).^2+(y-beeOffset(:,2)).^2;
			[d, nearestIndex] = min(squaredDist);
								
			if d < bee.sensingRadius^2
				target = [minX - 1, minY - 1] + [x(nearestIndex), y(nearestIndex)];
			else
				target = [];
			end
		end
	end
end