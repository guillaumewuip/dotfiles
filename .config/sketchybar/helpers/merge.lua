local function deep(t1, t2)
	local result = {}

	-- Copy t1
	for k, v in pairs(t1) do
		if type(v) == "table" then
			result[k] = deep(v, {})
		else
			result[k] = v
		end
	end

	-- Merge t2
	for k, v in pairs(t2) do
		if type(v) == "table" and type(result[k]) == "table" then
			result[k] = deep(result[k], v)
		elseif type(v) == "table" then
			result[k] = deep({}, v)
		else
			result[k] = v
		end
	end

	return result
end

return {
	deep = deep,
}
