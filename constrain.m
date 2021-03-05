function num = constrain(val, minVal, maxVal)
	num = min(maxVal,max(minVal,val));
end