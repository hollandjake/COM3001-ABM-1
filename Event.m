classdef Event
	properties (SetAccess = immutable)
		callerId	% [int] unique identifier for the invoking object
		callerType  % [EntityType] type of caller
		targetId	% [int] unique identifier for the target
		targetType	% [EntityType] unique identifier for the target
		operation	% @(caller, target) (caller.MAKE_CHANGES_HERE; target.MAKE_CHANGES_HERE)
	end
	
	methods
		function event = Event(callerType, callerId, targetType, targetId, operation)
			event.callerType = callerType;
			event.callerId = callerId;
			
			event.targetType = targetType;
			event.targetId = targetId;
			
			event.operation = operation;
		end
		
		function ret = execute(event)
			global ENV AGENTS

			switch event.callerType 
				case EntityType.BEE
					caller = AGENTS{event.callerId};
				case EntityType.FLOWER
					caller = ENV.grid(event.callerId);
			end
			
			switch event.targetType 
				case EntityType.BEE
					target = AGENTS{event.targetId};
				case EntityType.FLOWER
					target = ENV.grid(event.targetId);
			end
			ret = event.operation(caller, target);
		end
	end
end

