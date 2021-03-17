function target = find_flower(bee)

	% FIND_FLOWER attempts to find a flower for the bee to move towards
	%
	% returns a coordinate [x, y] indicating the target that has been found

	global ENV_DATA;
	
	bee_pos = round(bee.pos);
	
	radius = bee.sensing_radius;
	
	minX = constrain(bee_pos(1)-radius,1,ENV_DATA.bm_size);
	maxX = constrain(bee_pos(1)+radius,1,ENV_DATA.bm_size);
	minY = constrain(bee_pos(2)-radius,1,ENV_DATA.bm_size);
	maxY = constrain(bee_pos(2)+radius,1,ENV_DATA.bm_size);
	bee_offset = bee_pos - [minX,minY];

	search_field = ENV_DATA.pollen(minY:maxY,minX:maxX);
    search_field(bee_offset + [1,1]) = 0; % Stop the bee going to the cell it is over

    [y,x] = find(search_field > 0); % Find all cells containing flowers with pollen levels > 0
	
% 	rand_indices = randperm(length(ENV_DATA.flower_positions));
% 	flower_positions = ENV_DATA.flower_positions(:,rand_indices)';
% 	x = flower_positions(:,1);
% 	y = flower_positions(:,2);
% 	
% 	squared_dist = (x-bee_offset(:,1)).^2+(y-bee_offset(:,2)).^2;
% 	i = squared_dist < radius^2;
% 	in_range = flower_positions(i,:);
% 	
% 	target = in_range(1,:);
	

% 	search_field = ENV_DATA.pollen(in_range(:,1), in_range(:,2));
	
	
% 	squared_dist = (x-bee_offset(:,1)).^2+(y-bee_offset(:,2)).^2;
% 	[d, nearest_index] = min(squared_dist);
	
 	len = length(x);
% 	if len > 0
	nearest_index = randi(len);

% 		if d < bee.sensing_radius^2
	target = [minX - 1, minY - 1] + [x(nearest_index), y(nearest_index)];
% 	return;
% 		end
% 	end
% 	target = [];
end