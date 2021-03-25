function target = find_flower(bee)

	% FIND_FLOWER attempts to find a flower for the bee to move towards
	%
	% returns a coordinate [x, y] indicating the target that has been found

	global ENV_DATA;


	bee_pos = round(bee.pos);
	
	radius = bee.sensing_radius;
	radius_sqr = radius^2;
	
	flower_positions = ENV_DATA.flower_positions;
	search_field = ENV_DATA.pollen(flower_positions(:, 3));
	indices = search_field > 0;
	flower_pos = flower_positions(indices,1:2);
	distance_offset = flower_pos-bee_pos;
	n_in_range = size(distance_offset,2);
	target_index = ceil(max(1,min(abs(normrnd(1,1)), n_in_range)));
	[d,i] = pdist2(distance_offset,zeros(1,n_in_range), 'squaredeuclidean', 'Smallest', target_index);
	
	for idx = target_index:-1:1
		cc = i(idx);
		if d(idx) < radius_sqr
			target = flower_pos(cc,:);
			return
		end
	end
	target = [];
end