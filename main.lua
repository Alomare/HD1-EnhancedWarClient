-- Enhanced War Client: the client side of Enhanced wars from Obsidian Commander.
--
-- An Enhanced war is the Vanilla Galactic War of Commander with more on top: custom events, orders and
-- subfactions, which this mod is to show and play on every machine of the war. For now it only detects
-- an Enhanced war and says so in the loader log. Anywhere else (the official war, a Vanilla war) the
-- mod does nothing.
local detect = obsidian.module("src/detect")

local ok, kind = pcall(detect.kind, obsidian)
if not ok then
	obsidian.log("enhancedwar: could not read the war: " .. tostring(kind))
	return
end

if kind == "enhanced" then
	obsidian.log("enhancedwar: Enhanced war " .. tostring(detect.war_id(obsidian)))
else
	obsidian.log("enhancedwar: not an Enhanced war (" .. kind .. "), nothing to do")
end
