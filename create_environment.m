function create_environment(size)

%function that populates the global data structure representing
%environmental information

%ENV_DATA is a data structure containing information about the model
   %environment
   %    ENV_DATA.shape - shape of environment - FIXED AS SQUARE
   %    ENV_DATA.units - FIXED AS KM
   %    ENV_DATA.bm_size - length of environment edge in km
   %    ENV_DATA.pollen is  a bm_size x bm_size array containing distribution
   %    of food

global ENV_DATA PARAM DISPLAY

ENV_DATA.shape='square';
ENV_DATA.units='metres';
ENV_DATA.bm_size=size;

ENV_DATA.pollen = zeros(size);

flowerPositions = randperm(size^2, PARAM.NUM_FLOWERS);
ENV_DATA.pollen(flowerPositions) = randi([PARAM.MIN_FLOWER_POLLEN, PARAM.MAX_FLOWER_POLLEN], 1, PARAM.NUM_FLOWERS);

ENV_DATA.total_pollen = sum(sum(ENV_DATA.pollen));

ENV_DATA.hive_location = [randi(size),randi(size)];

check_for_figure();