function target = find_flower(bee)

	% FIND_FLOWER attempts to find a flower for the bee to move towards
	%
	% returns a coordinate [x, y] indicating the target that has been found

	global ENV_DATA;
	
	bee_pos = round(bee.pos);
	
	radius = bee.sensing_radius;
	radius_sqr = radius ^ 2;

%     search_field(bee_offset + [1,1]) = 0; % Stop the bee going to the cell it is over

%     [y,x] = find(ENV_DATA.flower_positions + search_field > 0); % Find all cells containing flowers with pollen levels > 0
	
	
	% Randomise order of flowers
	flower_positions = ENV_DATA.flower_positions';
% 	x = flower_positions(:,1);
% 	y = flower_positions(:,2);
	
% 	squared_dist = (x-bee_pos(:,1)).^2+(y-bee_pos(:,2)).^2;
% 	i = squared_dist < radius^2;
% 	in_range = flower_positions(i,:);
		
	target = [];
	index = randi(length(flower_positions));
	
	while isempty(target)
		rand_position = flower_positions(index,:);
		dist = (rand_position(:,1)-bee_pos(:,1)).^2+(rand_position(:,2)-bee_pos(:,2)).^2;
		if dist < radius_sqr && ENV_DATA.pollen(flower_positions(index,1),flower_positions(index,2)) > 0
			target = flower_positions(index, :);
			return
		end
		index = randi(length(flower_positions));
	end
end