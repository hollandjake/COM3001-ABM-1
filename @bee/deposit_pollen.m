function bee = deposit_pollen(bee)

	% DEPOSIT_POLLEN deposits the pollen at the hive it is currently ontop of

    global ENV_DATA IT_STATS;
    global N_IT;

    IT_STATS.pollen_at_hive(N_IT+1) = IT_STATS.pollen_at_hive(N_IT+1) + bee.collected_pollen;
    bee.collected_pollen = 0;
end