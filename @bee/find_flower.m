function target = find_flower(bee)

	% FIND_FLOWER attempts to find a flower for the bee to move towards
	%
	% returns a coordinate [x, y] indicating the target that has been found

	global ENV_DATA;

	target = [];

	bee_pos = round(bee.pos);
	
	radius = bee.sensing_radius;
	radius_sqr = radius ^ 2;
	
	mins = constrain(bee_pos-radius, 1, ENV_DATA.bm_size);
	maxs = constrain(bee_pos+radius, 1, ENV_DATA.bm_size);

	minX = mins(1);
	maxX = maxs(2);
	minY = mins(2);
	maxY = maxs(2);
	bee_offset = bee_pos - mins;

	search_field = ENV_DATA.pollen(minY:maxY,minX:maxX);
	search_field(bee_offset + [1,1]) = 0; % Stop the bee going to the cell it is over
	
	[y,x] = find(search_field > 0); % Find all cells containing flowers with pollen levels > 0

	squared_dist = (x-bee_offset(:,1)).^2+(y-bee_offset(:,2)).^2;
	i = squared_dist < radius_sqr;
	squared_join = [x(i),y(i),squared_dist(i)];
	if ~isempty(squared_join)
		sorted = sortrows(squared_join,3);
		i = ceil(min(1 + abs(normrnd(0,1)), size(sorted,1)));
		c = sorted(i,:);
		x = c(1);
		y = c(2);

		target = mins - [1,1] + [x,y];
	end
end