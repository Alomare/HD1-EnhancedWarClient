-- Offline tests for everything that doesn't need the game. From the repository's root:
--   luajit tests/run.lua
local passed, failed = 0, 0
local function test(name, fn)
	local ok, err = xpcall(fn, debug.traceback)
	if ok then
		passed = passed + 1
	else
		failed = failed + 1
		print("FAIL " .. name .. "\n" .. err)
	end
end

local function eq(got, want, what)
	if got ~= want then error((what or "value") .. ": expected " .. tostring(want) .. ", got " .. tostring(got), 2) end
end

local detect = dofile("src/detect.lua")

-- The loader table as a mod sees it, playing `war` (nil: the official war).
local function loader(war, caps)
	return {
		capabilities = caps or { war = true },
		war = function() return war end,
	}
end

test("an_enhanced_war_is_detected", function()
	local o = loader({ id = "k3x9q2", model = "enhanced" })
	eq(detect.kind(o), "enhanced")
	eq(detect.war_id(o), "k3x9q2")
end)

test("a_vanilla_war_is_a_custom_war", function()
	eq(detect.kind(loader({ id = "k3x9q2", model = "vanilla" })), "custom")
	eq(detect.kind(loader({ id = "k3x9q2" })), "custom", "no model")
end)

test("the_official_war_has_no_war", function()
	local o = loader(nil)
	eq(detect.kind(o), "official")
	eq(detect.war_id(o), nil)
end)

test("an_older_loader_without_obsidian_war_is_the_official_war", function()
	eq(detect.kind({ capabilities = {} }), "official")
	eq(detect.kind({ capabilities = { war = true } }), "official", "capability without the call")
	eq(detect.kind(nil), "official")
end)

test("a_failing_or_odd_answer_is_the_official_war", function()
	eq(detect.kind({ capabilities = { war = true }, war = function() error("boom") end }), "official")
	eq(detect.kind(loader({ model = "enhanced" })), "official", "no id")
	eq(detect.kind(loader("enhanced")), "official")
end)

print(passed .. " passed, " .. failed .. " failed")
if failed > 0 then os.exit(1) end
