function target = find_flower(bee, cn)
	global ENV_DATA;
	bee_pos = round(bee.pos);
	minX = constrain(bee_pos(1)-bee.sensingRadius,1,ENV_DATA.bm_size);
	maxX = constrain(bee_pos(1)+bee.sensingRadius,1,ENV_DATA.bm_size);
	minY = constrain(bee_pos(2)-bee.sensingRadius,1,ENV_DATA.bm_size);
	maxY = constrain(bee_pos(2)+bee.sensingRadius,1,ENV_DATA.bm_size);

	bee_offset = bee_pos - [minX,minY];
	search_field = ENV.grid(minY:maxY,minX:maxX);
	if (bee_pos(1) > 10 || bee_pos(2) > 10)
		disp(bee_pos);
	end
	if (bee_offset(1) < 1 || bee_offset(2) < 1)
		disp(bee_offset);
	end
	search_field(bee_offset) = 0; % Stop the bee going to the cell it is over
	[y,x] = find(search_field > 0); % Find all cells containing flowers with pollen levels > 0
	squared_dist = (x-bee_offset(:,1)).^2+(y-bee_offset(:,2)).^2;
	[d, nearest_index] = min(squared_dist);

	if d < bee.sensing_radius^2
		target = [minX - 1, minY - 1] + [x(nearest_index), y(nearest_index)];
	else
		target = [];
	end
end