local msg = require("mp.msg")

local secondarySubtitleLanguages = { "eng", "en" }

function setSecondarySubtitle()
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
		msg.info("Secondary subtitle set to: " .. bestMatch.id) -- Optional: for debugging
	end
end

-- Observe the track-list property for any changes
mp.observe_property("track-list", "native", setSecondarySubtitle)

msg.info("Jellyfin Secondary Sub Selector script loaded.")
