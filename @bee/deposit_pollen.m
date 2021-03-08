function bee = deposit_pollen(bee)

    %once bee arrives at the hive, deposit the pollen
    %returns updated bee value and new target
    
    %Created by Paulina Lasz 08/03/2021

    global ENV_DATA IT_STATS;
    global N_IT;
    
    if bee.pos == ENV_DATA.hive_location 
        IT_STATS.pollen_at_hive(N_IT+1) = IT_STATS.pollen_at_hive(N_IT+1) + bee.collected_pollen;
        bee.collected_pollen = 0;
        bee.target = [];
    end   
end