--- @class YufuScoreboardAchievement : DButton
--- @field SetContainer fun(self: YufuScoreboardAchievement, container: YufuScoreboardAchievements)
--- @field SetPlayer fun(self: YufuScoreboardAchievement, ply: Player)
--- @field SetSlot fun(self: YufuScoreboardAchievement, slot: number)
--- @field SetID fun(self: YufuScoreboardAchievement, id: string)
PANEL = {}

AccessorFunc(PANEL, "slot", "Slot", FORCE_NUMBER)
AccessorFunc(PANEL, "container", "Container")
AccessorFunc(PANEL, "id", "ID", FORCE_STRING)
AccessorFunc(PANEL, "player", "Player")

function PANEL:Init()
    self:SetTall(50)
    self:SetText("")

    self.container = nil
    self.id = "hidden"
    self.player = nil
    self.slot = 1
end

function PANEL:DoClick()
    if not IsValid(self.player) or self.player ~= LocalPlayer() then return end
    if self.slot > 3 then return end

    local menu = DermaMenu()
    local achievements = yufu.achievements

    for id, achievement in pairs(achievements) do
        local data = achievement.getData(self.player)
        local option = menu:AddOption(data.title, function()
            RunConsoleCommand("yufu_set_achievement", id, tostring(self.slot))
            timer.Simple(0.5, function()
                if IsValid(self.container) then
                    self.container:Rebuild()
                end
            end)
        end)

        if id == self.id then
            option:SetChecked(true)
        end
    end

    menu:Open()
end

function PANEL:OnCursorEntered()
    if self.slot > 3 or (IsValid(self.player) and self.player ~= LocalPlayer()) then
        self:SetCursor("arrow")
    end
end

function PANEL:Paint(w, h)
    draw.RoundedBox(6, 0, 0, w, h, yufu.colors.generic.DARK)

    if not IsValid(self.player) then return end

    local achievement = yufu.achievements[self.id]
    if not achievement then return end

    local data = achievement.getData(self.player)

    surface.SetDrawColor(data.color)
    surface.SetMaterial(data.icon)
    surface.DrawTexturedRect(10, (h - 28) / 2, 28, 28)

    draw.SimpleText(data.title, "yufu_scoreboard_bodySemiBold",
        47, h / 2 - 9, yufu.colors.generic.WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER
    )
    draw.SimpleText(data.desc, "yufu_scoreboard_body",
        47, h / 2 + 9, yufu.colors.generic.GRAY, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER
    )
end

vgui.Register("YufuScoreboardAchievement", PANEL, "DButton")