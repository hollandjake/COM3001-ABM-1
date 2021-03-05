classdef Environment
	properties
		grid
	end
	properties (SetAccess = immutable)
		HIVE_LOCATION
		SIZE
	end
	properties (Constant)
		% Use hexagons as markers
		hex=[-sqrt(3)/5 -1/5; 
			0 -2/5;  
			+sqrt(3)/5 -1/5;
			+sqrt(3)/5 +1/5;
			0  2/5;
			-sqrt(3)/5 1/5;
			-sqrt(3)/5 -1/5];
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
			global AGENTS;
			imagesc(obj.grid);
			colormap('summer');
			axis('square');
			hold on;
			
			% Render the agents
			for a = 1:PARAMS.NUM_AGENTS
				agent = AGENTS{a};
				agentPoint = plot(agent.pos(1),agent.pos(2));
				set(agentPoint, 'Marker', 'o');
				set(agentPoint, 'MarkerSize', 10);
				set(agentPoint, 'MarkerEdgeColor', 'k');
				set(agentPoint, 'LineWidth', 2);
				set(agentPoint, 'MarkerFaceColor', [1 1 0]);
				hold on;
			end
			hold on;
			
			% Render the hive
% 			hive = patch('Faces', [1,2,3,4,5,6],...
% 				'Vertices', Environment.hex+[obj.HIVE_LOCATION.x obj.HIVE_LOCATION.y],...
% 				'FaceColor',[0.9290 0.6940 0.1250],...
% 				'LineWidth', 2);
			
			theta = 30:60:360;
			x = cosd(theta)*0.5;
			y = sind(theta)*0.5;
			hive = fill(x+obj.HIVE_LOCATION(1),y+obj.HIVE_LOCATION(2),[0.9290 0.6940 0.1250]);
			hive.LineWidth = 2;
			
			hold off;
		end
	end

	methods (Static, Access=private)
		function grid = GenerateInitialGrid(size)
			grid = zeros(size);
			flowerPositions = randperm(size^2, PARAMS.NUM_FLOWERS);
			grid(flowerPositions) = randi([PARAMS.MIN_FLOWER_POLLEN, PARAMS.MAX_FLOWER_POLLEN], 1, PARAMS.NUM_FLOWERS);
		end
		function hiveLocation = GenerateInitialHiveLocation(size)
			hiveLocation = [randi(size), randi(size)];
		end
	end
end