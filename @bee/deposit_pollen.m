function bee = deposit_pollen(bee)

	% DEPOSIT_POLLEN deposits the pollen at the hive it is currently ontop of

    global ENV_DATA IT_STATS;
    global N_IT;

	if bee.is_infected
		IT_STATS.pollen_at_hive_infected(N_IT+1) = IT_STATS.pollen_at_hive_infected(N_IT+1) + bee.collected_pollen;
	else
		IT_STATS.pollen_at_hive_normal(N_IT+1) = IT_STATS.pollen_at_hive_normal(N_IT+1) + bee.collected_pollen;
	end
    bee.collected_pollen = 0;
end