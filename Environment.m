classdef Environment
	properties
		grid
	end
	properties (SetAccess = immutable)
		HIVE_LOCATION
		SIZE
	end

	methods
		function Env = Environment(size)
			Env.grid = Environment.GenerateInitialGrid(size);
			Env.SIZE = size;
			Env.HIVE_LOCATION = Environment.GenerateInitialHiveLocation(size);
		end
		
		function process(env)
			global ENV AGENTS MESSAGES;
			%process decides what events will and will not take place
			for message = MESSAGES
				message.execute(env);
			end
			MESSAGES = cell(1, PARAMS.NUM_AGENTS);
		end
		
		function render(obj)
			imagesc(obj.grid);
			colormap('summer');
			axis('square');
		end
	end

	methods (Static, Access=private)
		function grid = GenerateInitialGrid(size)
			grid = zeros(size);
			flowerPositions = randperm(size^2, PARAMS.NUM_FLOWERS);
			grid(flowerPositions) = randi([PARAMS.MIN_FLOWER_POLLEN, PARAMS.MAX_FLOWER_POLLEN], 1, PARAMS.NUM_FLOWERS);
		end
		function hiveLocation = GenerateInitialHiveLocation(size)
			hiveLocation = struct('x', randi(size), 'y', randi(size));
		end
	end
end