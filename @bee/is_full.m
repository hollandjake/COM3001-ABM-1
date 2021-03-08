function target = is_full(bee)

    %if agent is carrying its max pollen, set target to location of the
    %hive.
    %target returned is new target of individual bee agent

    %Created by Paulina Lasz 08/03/2021
    
    global ENV_DATA IT_STATS;
    
    if bee.collected_pollen >= bee.max_pollen
        target = ENV_DATA.hive_location;
    else 
        target = [];
    end
end