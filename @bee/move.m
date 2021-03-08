function bee = move(bee)

	% MOVE moves the bee towards its target, or randomly
	%
	% If there isn't a target for the bee it will wonder randomly
	% otherwise it will move towards the target

	global ENV_DATA IT_STATS N_IT

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

	bee.pos = constrain(newpos, 1, ENV_DATA.bm_size);
end
