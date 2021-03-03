classdef bee   %declares rabbit object
    properties    %define rabbit properties (parameters) 
        pos;
        target; 
        speed;
        sensingRadius;
        pollenCount;
        onFlower;
        infected;
    end
    methods                         %note that this class definition mfile contains only the constructor method!
                                    %all additional member functions associated with this class are included as separate mfiles in the @rabbit folder. 
        function b=bee(varargin) %constructor method for rabbit - assigns values to rabbit properties
                %r=rabbit(age,food,pos....)
                %
                %age of agent (usually 0)
                %food - amount of food that rabbit has eaten
                %pos - vector containg x,y, co-ords 

                %Modified by Martin Bayley on 29/01/13


                switch nargin           %Use switch statement with nargin,varargin contructs to overload constructor methods
                    case 0				%create default object
                       b.pos=[];
                       b.target=[];
                       b.speed=[];
                       b.sensingRadius=[];
                       b.pollenCount=[];
                       b.onFlower=[];
                       b.infected=[];
                    case 1              %input is already a bee, so just return!
                       if (isa(varargin{1},'bee'))		
                            b=varargin{1};
                       else
                            error('Input argument is not a bee')
                            
                       end
                    case 7               %create a new rabbit (currently the only constructor method used)
                       b.pos=varargin{1};               %age of rabbit object in number of iterations
                       b.target=varargin{2};              %current food content (arbitrary units)
                       b.speed=varargin{3};               %current position in Cartesian co-ords [x y]
                       b.sensingRadius=varargin{4};             %number of kilometres rabbit can migrate in 1 day
                       b.pollenCount=varargin{5};        %number of iterations since rabbit last reproduced.
                       b.onFlower=varargin{6};
                       b.infected=varargin{7};
                    otherwise
                       error('Invalid no. of input arguments')
                end
        end
    end
end
