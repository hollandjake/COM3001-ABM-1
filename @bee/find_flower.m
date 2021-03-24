function target = find_flower(bee)

	% FIND_FLOWER attempts to find a flower for the bee to move towards
	%
	% returns a coordinate [x, y] indicating the target that has been found

	global ENV_DATA;
		
	bee_pos = round(bee.pos);
	
	radius = bee.sensing_radius;
	radius_sqr = radius ^ 2;
	
	mins = constrain(bee_pos-radius, 1, ENV_DATA.bm_size);	
	bee_offset = bee_pos - mins;

	flower_positions = ENV_DATA.flower_positions;
	
	x = flower_positions(:,1);
	y = flower_positions(:,2);
		
	squared_dist = (x-bee_offset(:,1)).^2+(y-bee_offset(:,2)).^2;
	
	flower_positions = flower_positions(squared_dist < radius_sqr,:);
	
	x = flower_positions(:,2);
	y = flower_positions(:,1);
	indicies = flower_positions(:,3);
	
	poll = ENV_DATA.pollen(indicies);
	matching_indicies = poll > 0;
	squared_dist = squared_dist(matching_indicies);
	if ~isempty(squared_dist)
		x = x(matching_indicies);
		y = y(matching_indicies);
		n = ceil(min(1 + abs(randn), size(squared_dist,1)));
		[~, idx] = topkrows(squared_dist, n, 'ascend');
		t = [x(idx(end)),y(idx(end))];

		target = mins - [1,1] + t;
	end
end