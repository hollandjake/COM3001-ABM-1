function [bee, collected_pollen] = collect_pollen(bee)
	global ENV_DATA IT_STATS N_IT;
	cpos = round(bee.pos);
	pollen_levels = ENV_DATA.pollen(cpos(2),cpos(1));
	if pollen_levels > 0
		collected_pollen = 1;
		ENV_DATA.pollen(cpos(2),cpos(1)) = pollen_levels - collected_pollen;
		bee.collected_pollen = bee.collected_pollen + collected_pollen;
	else
		collected_pollen = 0;
	end
end