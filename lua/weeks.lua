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

	local pattern = vim.regex([[\zs\d\{4\}\ze-W\d\{2\}-\d]])
	local a, z = pattern:match_str(line)
	local year = string.sub(date, a, z)

	local pattern = vim.regex([[\d\{4\}-W\zs\d\{2\}\ze-\d]])
	local a, z = pattern:match_str(line)
	local week = string.sub(date, a + 1, z)

	local pattern = vim.regex([[\d\+\.\?\d*h]])
	local a, z = pattern:match_str(line)
	local time = string.sub(line, a + 1, z - 1)

	return { date = date, year = year, week = week, time = time }
end

local function get_daily_totals()
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

local function get_weekly_totals()
	local totals = {}
	local lines = vim.fn.getline(1, "$")
	for _, line in pairs(lines) do
		local entry = parse_entry(line)
		if entry ~= nil then
			local key = entry.year .. "-W" .. entry.week
			totals[key] = (totals[key] or 0) + entry.time
		end
	end
	return totals
end

local function get_yearly_totals()
	local totals = {}
	local lines = vim.fn.getline(1, "$")
	for _, line in pairs(lines) do
		local entry = parse_entry(line)
		if entry ~= nil then
			local key = entry.year
			totals[key] = (totals[key] or 0) + entry.time
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

	local buf_lines = {}
	for _, key in pairs(keys) do
		local sum = totals[key]
		table.insert(buf_lines, key .. ": " .. sum)
	end

	vim.cmd("vsplit")
	vim.cmd("vertical resize 40")
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, 1, false, buf_lines)
	vim.api.nvim_set_current_buf(buf)
end

M.daily_summary = function()
	local totals = get_daily_totals()
	display_totals(totals)
end

M.weekly_summary = function()
	local totals = get_weekly_totals()
	display_totals(totals)
end

M.yearly_summary = function()
	local totals = get_yearly_totals()
	display_totals(totals)
end

M.summary = function(summary_type)
	if summary_type == "d" or summary_type == "daily" then
		M.daily_summary()
	elseif summary_type == "y" or summary_type == "yearly" then
		M.yearly_summary()
	else
		M.weekly_summary()
	end
end

return M
