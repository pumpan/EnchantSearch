local searchBox
local label
local resultFrame
local resultButtons = {}
local MAX_RESULTS = 10
local selectedButton = nil

-- ======================
-- DIFFICULTY-FÄRGER (BLIZZARD)
-- ======================
local CraftColorInfo = {
    optimal = { text = "Optimal", r = 1.00, g = 0.50, b = 0.00 },
    medium  = { text = "Medium",    r = 1.00, g = 1.00, b = 0.00 },
    easy    = { text = "Easy",      r = 0.25, g = 1.00, b = 0.25 },
    trivial = { text = "Trivial",    r = 0.60, g = 0.60, b = 0.60 },
}

-- ======================
-- EXPANDERA ALLA HEADERS UPP TILL INDEX
-- ======================
local function ExpandHeadersUpTo(index)
    for i = 1, index do
        local _, _, craftType, _, isExpanded = GetCraftInfo(i)
        if craftType == "header" and not isExpanded then
            ExpandCraftSkillLine(i)
        end
    end
end

-- ======================
-- SCROLLA CRAFTLISTAN (VANILLA)
-- ======================
local function ScrollCraftToIndex(index)
    local offset = index - 3
    if offset < 0 then offset = 0 end

    FauxScrollFrame_SetOffset(CraftListScrollFrame, offset)
    CraftFrame_Update()
end

-- ======================
-- EVENT FRAME
-- ======================
local frame = CreateFrame("Frame")
frame:RegisterEvent("CRAFT_SHOW")

frame:SetScript("OnEvent", function()
    if searchBox then return end

    -- ======================
    -- SÖKFÄLT
    -- ======================
    searchBox = CreateFrame("EditBox", "EnchantSearchBox", CraftFrame)
    searchBox:SetWidth(150)
    searchBox:SetHeight(20)
	searchBox:SetTextInsets(5, 5, 0, 0) 
    searchBox:SetAutoFocus(false)
    searchBox:SetFontObject("GameFontHighlightSmall")
    searchBox:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 12,
    })
    searchBox:SetBackdropColor(0, 0, 0, 0.8)
	if IsAddOnLoaded("PFUI") then
		searchBox:SetPoint("TOPLEFT", CraftFrame, "TOPLEFT", 20, -40)
	else
		searchBox:SetPoint("TOPLEFT", CraftFrame, "TOPLEFT", 20, -70) 
	end
    searchBox:Show()

    searchBox:SetScript("OnEscapePressed", function()
        searchBox:SetText("")
        searchBox:ClearFocus()
        resultFrame:Hide()
    end)

    label = CraftFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    label:SetPoint("LEFT", searchBox, "RIGHT", 8, 0)
    label:SetText("Search")
    label:Show()

    -- ======================
    -- RESULT FRAME
    -- ======================
    resultFrame = CreateFrame("Frame", "EnchantSearchResults", CraftFrame)
    resultFrame:SetWidth(250)
    resultFrame:SetPoint("TOPLEFT", CraftFrame, "TOPRIGHT", 10, -20)
    resultFrame:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 12,
    })
    resultFrame:SetBackdropColor(0, 0, 0, 0.9)
    resultFrame:Hide()

    -- ======================
    -- RESULT KNAPPAR
    -- ======================
    for i = 1, MAX_RESULTS do
        local btn = CreateFrame("Button", nil, resultFrame)
        btn:SetWidth(230)
        btn:SetHeight(18)
        btn:SetPoint("TOPLEFT", 10, -10 - (i - 1) * 18)

        btn.bg = btn:CreateTexture(nil, "BACKGROUND")
        btn.bg:SetAllPoints()
        btn.bg:SetTexture(1, 1, 1)
        btn.bg:SetAlpha(0.15)
        btn.bg:Hide()

        btn.colorBar = btn:CreateTexture(nil, "BACKGROUND")
        btn.colorBar:SetWidth(4)
        btn.colorBar:SetHeight(18)
        btn.colorBar:SetPoint("LEFT", 0, 0)
        btn.colorBar:Hide()

        btn.text = btn:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        btn.text:SetPoint("LEFT", 8, 0)
        btn.text:SetWidth(216)
        btn.text:SetJustifyH("LEFT")

        btn:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")


        btn:SetScript("OnClick", function()
            if not btn.craftIndex then return end

            ExpandHeadersUpTo(btn.craftIndex)
            CraftFrame_SetSelection(btn.craftIndex)
            ScrollCraftToIndex(btn.craftIndex)

            if selectedButton then
                selectedButton.bg:Hide()
            end
            btn.bg:Show()
            selectedButton = btn

            searchBox:SetText("")
            searchBox:ClearFocus()
            resultFrame:Hide()
        end)


		btn:SetScript("OnEnter", function()
			if not btn.craftIndex then return end

			GameTooltip:SetOwner(btn, "ANCHOR_RIGHT")
			GameTooltip:ClearLines()

			local name, _, craftType = GetCraftInfo(btn.craftIndex)
			GameTooltip:AddLine(name)
			

			local normalizedName = string.gsub(name, "%s+", " ")
			

			local stats = EnchantStatsDB[normalizedName]
			
			if stats then
				GameTooltip:AddLine("Stats: " .. stats, 0, 1, 0, 1)

			end

			GameTooltip:Show()
		end)

		btn:SetScript("OnLeave", function()
			GameTooltip:Hide()
		end)
        btn:Hide()
        resultButtons[i] = btn
    end

    -- ======================
    -- SÖKLOGIK
    -- ======================
    searchBox:SetScript("OnTextChanged", function()
        local text = string.lower(searchBox:GetText() or "")
        if text == "" then
            resultFrame:Hide()
            return
        end

        local shown = 0
        local numCrafts = GetNumCrafts()

        for i = 1, MAX_RESULTS do
            resultButtons[i]:Hide()
            resultButtons[i].craftIndex = nil
            resultButtons[i].bg:Hide()
        end

        selectedButton = nil

        for i = 1, numCrafts do
            local name, _, craftType = GetCraftInfo(i)
            if name and craftType ~= "header" then
                if string.find(string.lower(name), text, 1, true) then
                    shown = shown + 1
                    if shown > MAX_RESULTS then break end

                    local btn = resultButtons[shown]
                    btn.text:SetText(name)
                    btn.craftIndex = i

                    if CraftColorInfo[craftType] then
                        local c = CraftColorInfo[craftType]
                        btn.text:SetTextColor(c.r, c.g, c.b)
                        btn.colorBar:SetTexture(c.r, c.g, c.b)
                        btn.colorBar:SetAlpha(0.9)
                        btn.colorBar:Show()
                    else
                        btn.text:SetTextColor(1, 1, 1)
                        btn.colorBar:Hide()
                    end

                    btn:Show()
                end
            end
        end

        resultFrame:SetHeight(14 + shown * 17)

        if shown > 0 then
            resultFrame:Show()
        else
            resultFrame:Hide()
        end
    end)
end)
