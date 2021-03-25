function bee = move(bee)

	% MOVE moves the bee towards its target, or randomly
	%
	% If there isn't a target for the bee it will wonder randomly
	% otherwise it will move towards the target

	global ENV_DATA

	if ~isempty(bee.target)
		% Move towards target
		dir = bee.target - bee.pos;
		bee.direction = dir;
	else
		if isempty(bee.direction) || (bee.direction(1) == 0 && bee.direction(2) == 0)
			% Move randomly
			rot = rand*2*pi;
			dir = [cos(rot),sin(rot)];
			bee.direction = dir * bee.speed;
		else
			dir = bee.direction;
		end
	end
	
	l = norm(dir);
	
	max_dist = min(bee.max_distance - bee.distance_travelled, bee.speed);
	
	if (l < max_dist)
		moved_by = dir;
	else
		moved_by = (dir/l) * max_dist;
	end
	newpos = bee.pos + moved_by;
	bee.distance_travelled = bee.distance_travelled + norm(moved_by);
	
	if bee.pos(1) <= 1 || bee.pos(2) <= 1 || bee.pos(1) >= ENV_DATA.bm_size || bee.pos(2) >= ENV_DATA.bm_size
		bee.direction = [];
	end

	bee.pos = constrain(newpos, 1, ENV_DATA.bm_size);
end
