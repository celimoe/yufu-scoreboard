--- @class YufuScoreboardAchievements : DPanel
PANEL = {}

function PANEL:Init()
    self.isExpanded = false
    self.player = nil
    self.panels = {}

    --- @class SBExpandButton : DButton
    self.ExpandButton = self:Add("DButton")
    self.ExpandButton:SetText("")
    self.ExpandButton:SetTall(30)
    self.ExpandButton:Dock(BOTTOM)
    self.ExpandButton:DockMargin(6, 0, 6, 6)
    self.ExpandButton:SetVisible(false)
    self.ExpandButton.Paint = function(s, w, h)
        local col = s:IsHovered() and yufu.colors.generic.MAGENTA or yufu.colors.generic.LIGHTERER
        draw.RoundedBox(6, 0, 0, w, h, col)

        local icon = self.isExpanded and yufu.mats.icons.CHEVRON_UP_24 or yufu.mats.icons.CHEVRON_DOWN_24
        surface.SetDrawColor(yufu.colors.generic.WHITE)
        surface.SetMaterial(icon)
        surface.DrawTexturedRect((w - 20) / 2, (h - 20) / 2, 20, 20)
    end
    self.ExpandButton.DoClick = function()
        self:ToggleExpand()
    end
end

function PANEL:SetPlayer(ply)
    self.player = ply
    self:Rebuild()

    local lp = LocalPlayer()
    if IsValid(lp) and lp:GetUserGroup() ~= "user" then
        self.ExpandButton:SetVisible(true)
    end
end

function PANEL:Rebuild(suppressResizeCallback)
    local oldHeight = self:GetTall()

    for _, panel in ipairs(self.panels) do
        if IsValid(panel) then panel:Remove() end
    end
    self.panels = {}

    if not IsValid(self.player) then return end

    local achievements = yufu.achievements
    local slots = self.player:GetNWString("yufu_achievements", "like,rp,pvp"):Split(",")
    local shown = {}

    for i = 1, math.min(3, #slots) do
        local id = slots[i]
        if id and id ~= "" and achievements[id] then
            self:CreateAchievement(id, i)
            shown[id] = true
        end
    end

    if self.isExpanded and self.ExpandButton:IsVisible() then
        local slot = 4
        for id, _ in pairs(achievements) do
            if not shown[id] and id ~= "hidden" then
                self:CreateAchievement(id, slot)
                slot = slot + 1
            end
        end
    end

    self:UpdateHeight()

    if suppressResizeCallback then return end
    if not self.isExpanded then return end

    local heightDelta = self:GetTall() - oldHeight
    if heightDelta ~= 0 then
        self:OnExpandToggled(heightDelta)
    end
end

function PANEL:CreateAchievement(typeId, slot)
    local panel = self:Add("YufuScoreboardAchievement")
    panel:Dock(TOP)
    panel:DockMargin(6, #self.panels == 0 and 6 or 0, 6, 6)
    panel:SetID(typeId)
    panel:SetPlayer(self.player)
    panel:SetSlot(slot)
    panel:SetContainer(self)

    table.insert(self.panels, panel)
end

function PANEL:ToggleExpand(silent)
    local oldHeight = self:GetTall()
    self.isExpanded = not self.isExpanded
    self:Rebuild(true)

    if silent then return end

    local newHeight = self:GetTall()
    local heightDelta = newHeight - oldHeight

    self:OnExpandToggled(heightDelta)
end

function PANEL:UpdateHeight()
    local total = 0

    for _, panel in ipairs(self.panels) do
        if IsValid(panel) then
            total = total + panel:GetTall() + 6
        end
    end

    if #self.panels > 0 then total = total end
    if self.ExpandButton:IsVisible() then
        total = total + 42
    else
        total = total + 6
    end

    self:SetTall(math.max(total, 1))
end

function PANEL:Paint(w, h)
    draw.RoundedBox(6, 0, 0, w, h, yufu.colors.generic.LIGHTER)
end

function PANEL:OnExpandToggled(heightDelta) end

vgui.Register("YufuScoreboardAchievements", PANEL, "DPanel")