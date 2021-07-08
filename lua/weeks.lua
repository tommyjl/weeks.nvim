local M = {}

local function parse_entry(line)
	local pattern = vim.regex([[^\d\{4\}-W\d\{2\}-\d\s\+\d\+\.\?\d*h]])
	local ok = pattern:match_str(line)
	if ok == nil then
		return nil
	end

	local pattern = vim.regex([[\d\{4\}-W\d\{2\}-\d]])
	local a, z = pattern:match_str(line)
	local date = string.sub(line, a, z)

	local pattern = vim.regex([[\d\+\.\?\d*h]])
	local a, z = pattern:match_str(line)
	local time = string.sub(line, a + 1, z - 1)

	return { date = date, time = time }
end

local function get_totals()
	local totals = {}
	local lines = vim.fn.getline(1, "$")
	for _, line in pairs(lines) do
		local entry = parse_entry(line)
		if entry ~= nil then
			totals[entry.date] = (totals[entry.date] or 0) + entry.time
		end
	end
	return totals
end

local function display_totals(totals)
	local keys = {}
	for key in pairs(totals) do
		table.insert(keys, key)
	end
	table.sort(keys)
	for _, key in pairs(keys) do
		local sum = totals[key]
		print(key .. ": " .. sum)
	end
end

M.summary = function()
	local totals = get_totals()
	display_totals(totals)
end

return M
