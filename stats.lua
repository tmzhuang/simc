local _, simc = ...

local mage_specs = {'arcane', 'fire', 'frost'}

local function get_talent_string(spec_id)
    s = ''
    for tier=1,7 do
        tier_num = 0
        for col=1,3 do
            _,_,_,_,_,_,_,_,_,active = GetTalentInfo(tier, col, spec_id)
            if active then tier_num = col end
        end
        s = s .. tier_num
    end
    return s
end

local function get_stats_string()
    local _, _, int = UnitStat('player', 4)
    return (string.format("gear_intellect=%d", int) .. '\n'
    .. string.format("gear_crit_rating=%d", GetCombatRating(9)) .. '\n'
    .. string.format("gear_haste_rating=%d", GetCombatRating(18)) .. '\n'
    .. string.format("gear_mastery_rating=%d", GetCombatRating(26)) .. '\n'
    .. string.format("gear_versatility_rating=%d", GetCombatRating(29)))
end

local function get_profile_string()
    local class = string.lower(UnitClass('player'))
    local name = UnitName('player')
    local race = string.lower(UnitRace('player'))
    local spec_id = GetSpecialization()
    local spec = mage_specs[spec_id]
    return (
    string.format("%s=%s", class, name) .. '\n'
    .. 'spec=' .. spec .. '\n'
    .. 'race=' .. race .. '\n'
    .. 'level=' .. UnitLevel('player') .. '\n'
    .. 'talents=' .. get_talent_string(spec_id) .. '\n'
    .. get_stats_string()
    )
end

function simc.create_stats_frame()
    local width = 200
    local height = 200
	local frame = CreateFrame("Frame", "MyStatsFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate")
	table.insert(UISpecialFrames, "MyStatsFrame")
	frame:SetBackdrop(PaneBackdrop)
	frame:SetBackdropColor(200,200,200,1)
	frame:SetWidth(width)
	frame:SetHeight(height)
	frame:SetPoint("CENTER", UIParent, "CENTER")
	frame:Hide()
	frame:SetFrameStrata("DIALOG")

	local scrollArea = CreateFrame("ScrollFrame", "MyStatsScroll", frame, "UIPanelScrollFrameTemplate")
	scrollArea:SetPoint("TOPLEFT", frame, "TOPLEFT", 8, -30)
	scrollArea:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -30, 8)

	local editBox = CreateFrame("EditBox", "MyStatsText", frame)
	editBox:SetMultiLine(true)
	editBox:SetMaxLetters(99999)
	editBox:EnableMouse(true)
	editBox:SetAutoFocus(false)
	editBox:SetFontObject(ChatFontNormal)
	editBox:SetWidth(width)
	editBox:SetHeight(height)
	editBox:SetScript("OnEscapePressed", function() frame:Hide() end)
	editBox:SetText('')

	scrollArea:SetScrollChild(editBox)

	local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
	close:SetPoint("TOPRIGHT", frame, "TOPRIGHT")
end

function simc.show_stats_frame()
	MyStatsText:SetText(get_profile_string())
	MyStatsFrame:Show()
end
