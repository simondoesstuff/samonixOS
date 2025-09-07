local msg = require("mp.msg")
local secondarySubtitleLanguages = { "eng", "en" }
local currentVideoPath = nil
local hasSetSecondaryForCurrentVideo = false

function setSecondarySubtitle()
	-- Get the current video path/filename
	local videoPath = mp.get_property("path")

	-- Check if this is a new video
	if videoPath ~= currentVideoPath then
		currentVideoPath = videoPath
		hasSetSecondaryForCurrentVideo = false
		msg.info("New video detected: " .. (videoPath or "unknown"))
	end

	-- Only set secondary subtitle if we haven't done it for this video yet
	-- This way the user can perform an override and change it back if they want.
	if hasSetSecondaryForCurrentVideo then
		return
	end

	-- Create a quick lookup table with language priorities
	local languagePriorities = {}
	for i, lang in ipairs(secondarySubtitleLanguages) do
		languagePriorities[lang] = i
	end

	local bestMatch = {
		id = nil,
		priority = 999,
	}

	local trackCount = mp.get_property_number("track-list/count")
	local primary_sid = mp.get_property_number("sid")

	-- Corrected Loop: Iterate from 0 to count - 1
	for i = 0, trackCount - 1 do
		local track_type = mp.get_property("track-list/" .. i .. "/type")
		if track_type == "sub" then
			local track_id = mp.get_property_number("track-list/" .. i .. "/id")
			local track_lang = mp.get_property("track-list/" .. i .. "/lang")
			local priority = languagePriorities[track_lang]

			-- Check if this track is a better match than what we've found so far
			if priority and priority < bestMatch.priority then
				bestMatch.id = track_id
				bestMatch.priority = priority
			end
		end
	end

	-- If we found a suitable track AND it's not already the primary subtitle
	if bestMatch.id and bestMatch.id ~= primary_sid then
		mp.set_property_number("secondary-sid", bestMatch.id)
		msg.info("Secondary subtitle set to: " .. bestMatch.id)
		hasSetSecondaryForCurrentVideo = true
	else
		-- Mark as processed even if no suitable track was found
		hasSetSecondaryForCurrentVideo = true
	end
end

-- Reset the flag when a new file starts loading
function onFileLoaded()
	hasSetSecondaryForCurrentVideo = false
end

-- Observe file-loaded event to reset our tracking
mp.register_event("file-loaded", onFileLoaded)

-- Observe the track-list property for any changes
mp.observe_property("track-list", "native", setSecondarySubtitle)

msg.info("Jellyfin Secondary Sub Selector script loaded.")
