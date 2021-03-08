function num = constrain(val, minVal, maxVal)

	% CONSTRAIN function for bounding a value
	%
	% Equivalent of min(max())
	
	num = min(maxVal,max(minVal,val));
end