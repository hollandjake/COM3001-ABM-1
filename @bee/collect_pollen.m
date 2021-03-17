function [bee, collected_pollen] = collect_pollen(bee)

	% COLLECT_POLLEN collects pollen from the flower the bee is on
	% 
	% returns 
	%	bee - the modified bee object with its collected pollen updated
	%	collected_pollen - amount of pollen collected

	global ENV_DATA IT_STATS PARAM;
	
	cpos = round(bee.pos);
	pollen_levels = ENV_DATA.pollen(cpos(2),cpos(1));
	
	bee_maximum_collectable = bee.max_pollen - bee.collected_pollen;
	
	max_possible_pollen = min(pollen_levels, bee_maximum_collectable);
	
	collected_pollen = max_possible_pollen;
	
	if collected_pollen > 0
		ENV_DATA.pollen(cpos(2),cpos(1)) = pollen_levels - collected_pollen;
		bee.collected_pollen = bee.collected_pollen + collected_pollen;
		if bee.collected_pollen == bee_maximum_collectable
			if bee.is_infected
				bee.speed = PARAM.BEE_SPEED_INFECTED_FULL;
			else
				bee.speed = PARAM.BEE_SPEED_NORMAL_FULL;
			end
		end
		bee.direction = [];
	else
		collected_pollen = 0;
	end
end