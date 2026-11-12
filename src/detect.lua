-- Which war this launch plays, as the loader tells it (obsidian.war(), Obsidian 2.0.0 and later): an
-- Enhanced war, another custom war, or the official war. No game calls, so the tests drive it directly.
local M = {}

-- "enhanced", "custom" (a Vanilla war from Commander) or "official". `obsidian` is the loader table.
function M.kind(obsidian)
	if type(obsidian) ~= "table" then return "official" end
	local caps = obsidian.capabilities
	if type(caps) ~= "table" or not caps.war or type(obsidian.war) ~= "function" then return "official" end
	local ok, war = pcall(obsidian.war)
	if not ok or type(war) ~= "table" or type(war.id) ~= "string" then return "official" end
	return war.model == "enhanced" and "enhanced" or "custom"
end

-- The id of the war being played, or nil.
function M.war_id(obsidian)
	if M.kind(obsidian) == "official" then return nil end
	local war = obsidian.war()
	return war.id
end

return M
