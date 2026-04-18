--- @class YufuScoreboardPlayer : DButton
--- @field SetPlayer fun(self: YufuScoreboardPlayer, ply: Player)
--- @field SetColumns fun(self: YufuScoreboardPlayer, columns: table)
PANEL = {}

AccessorFunc(PANEL, "player", "Player")
AccessorFunc(PANEL, "columns", "Columns")

function PANEL:Init()
    self:SetText("")
    self:SetTall(44)
    self.player = nil
    self.columnPanels = {}

    self.hoverAlpha = 0
    self.hoverProgress = 0
    self.hoverTween = nil

    self.jobColor = nil
    self.jobName = ""
    self.playerName = ""
    self.teamColor = Color(255, 255, 255)
    self.bannerType = "default"

    self.Avatar = self:Add("AvatarImage")
    self.Avatar:SetSize(36, 36)
    self.Avatar:SetPos(4, 4)

    --- @class SBAvatarButton : DButton
    self.AvatarButton = self:Add("DButton")
    self.AvatarButton:SetSize(36, 36)
    self.AvatarButton:SetPos(4, 4)
    self.AvatarButton:SetText("")
    self.AvatarButton.Paint = function() end
    self.AvatarButton.DoClick = function()
        if IsValid(self.player) then
            self.player:ShowProfile()
        end
    end

    self.Columns = self:Add("DPanel")
    self.Columns:Dock(RIGHT)
    self.Columns:SetWide(0)
    self.Columns:SetBackgroundColor(Color(0, 0, 0, 0))
    --- @diagnostic disable-next-line: inject-field
    self.Columns.Paint = function (_, _, _) end
end

function PANEL:SetPlayer(ply)
    self.player = ply
    if IsValid(self.Avatar) and IsValid(ply) then
        self.Avatar:SetPlayer(ply, 36)
        self:RefreshSnapshot()
    end
end

function PANEL:RefreshSnapshot()
    if not IsValid(self.player) then return end

    --- @diagnostic disable-next-line: undefined-field
    local jobTable = self.player.getJobTable and self.player:getJobTable() or {}
    self.jobColor = jobTable.color or yufu.colors.generic.LIGHTERER
    self.jobName = jobTable.name or "Неизвестно"
    self.playerName = self.player:Nick()
    self.teamColor = team.GetColor(self.player:Team())
    self.bannerType = self.player:GetNWString("yufu_bg_type", "default")
end

function PANEL:SetColumns(columns)
    for _, panel in pairs(self.columnPanels) do
        if IsValid(panel) then
            panel:Remove()
        end
    end
    self.columnPanels = {}

    local totalWidth = 0
    for _, col in ipairs(columns) do
        if yufu.gui.scoreboard.columnsEnabled[col.id] and col.panel then
            local colPanel = col:panel(self.Columns, self.player)
            if IsValid(colPanel) then
                self.columnPanels[col.id] = colPanel
                totalWidth = totalWidth + col.width
            end
        end
    end

    self.Columns:SetWide(totalWidth)
end

function PANEL:Paint(w, h)
    if not IsValid(self.player) then return end

    local y = 0

    if self.jobColor then
        surface.SetDrawColor(self.jobColor.r, self.jobColor.g, self.jobColor.b, 32)
        surface.SetMaterial(yufu.mats.generic.GRADIENT_L)
        surface.DrawTexturedRect(0, y, w / 4, h)
    end

    draw.RoundedBox(0, 1, y + 1, w - 2, h - 2, yufu.colors.generic.LIGHTER)
    draw.RoundedBox(0, 2, y + 2, w - 4, h - 4, yufu.colors.generic.DARK)

    local bannerType = self.bannerType
    if bannerType and bannerType ~= "" and bannerType ~= "default" then
        local qw, qh = (w - 4) / 5, h - 4
        local qx, qy = 2, y + 2

        local bannerMat = yufu.mats.getBanner(bannerType)
        if bannerMat then
            surface.SetDrawColor(yufu.colors.scoreboard.BANNER_COLOR)
            surface.SetMaterial(bannerMat)
            surface.DrawTexturedRect(qx, qy, qw, qh)

            surface.SetDrawColor(yufu.colors.generic.DARK)
            surface.SetMaterial(yufu.mats.generic.GRADIENT_L)
            surface.DrawTexturedRect(qx, qy, qw, qh)

            surface.SetDrawColor(yufu.colors.generic.DARK)
            surface.SetMaterial(yufu.mats.generic.GRADIENT_R)
            surface.DrawTexturedRect(qx, qy, qw, qh)
        end
    end

    if self.hoverAlpha > 5 then
        local hoverCol = Color(150, 150, 150, self.hoverAlpha * 0.6)
        local halfW = w / 2
        local hoverW = halfW * self.hoverProgress

        surface.SetDrawColor(hoverCol)
        surface.SetMaterial(yufu.mats.generic.GRADIENT_R)
        surface.DrawTexturedRect(halfW - hoverW, 2, hoverW, 2)
        surface.SetMaterial(yufu.mats.generic.GRADIENT_L)
        surface.DrawTexturedRect(halfW - 1, 2, hoverW, 2)

        surface.SetDrawColor(hoverCol)
        surface.SetMaterial(yufu.mats.generic.GRADIENT_R)
        surface.DrawTexturedRect(halfW - hoverW, h - 4, hoverW, 2)
        surface.SetMaterial(yufu.mats.generic.GRADIENT_L)
        surface.DrawTexturedRect(halfW - 1, h - 4, hoverW, 2)
    end

    draw.RoundedBox(0, 44, y + 4, 1, h - 8, self.teamColor)

    draw.SimpleText(self.playerName, "yufu_scoreboard_headingBold",
        52, y + h - 20, yufu.colors.generic.WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM
    )

    draw.SimpleText(self.jobName, "yufu_scoreboard_body",
        52, y + 22, yufu.colors.generic.WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP
    )
end

function PANEL:Think()
    if self.hoverTween then
        self.hoverTween:update(FrameTime())
    end

    self:RefreshSnapshot()
end

function PANEL:OnCursorEntered()
    self.hoverTween = yufu.tween.new(1, self, {hoverAlpha = 255, hoverProgress = 1}, yufu.tween.easing.outCirc)
end

function PANEL:OnCursorExited()
    self.hoverTween = yufu.tween.new(0.5, self, {hoverAlpha = 0, hoverProgress = 0}, yufu.tween.easing.outCirc)
end

function PANEL:DoClick()
    if yufu.gui.scoreboard and IsValid(yufu.gui.scoreboard.mini) then
        yufu.gui.scoreboard.mini:Remove()
    end

    if IsValid(yufu.gui.scoreboard.panel) then
        local mini = vgui.Create("YufuScoreboardMiniProfile", yufu.gui.scoreboard.panel)
        local mx, my = gui.MouseX(), gui.MouseY()
        mini:SetPlayer(self.player)
        mini:SetPos(math.Clamp(mx + 10, 10, ScrW() - mini:GetWide()), math.Clamp(my + 10, 10, ScrH() - mini:GetTall()))

        yufu.gui.scoreboard.mini = mini
    end
end

vgui.Register("YufuScoreboardPlayer", PANEL, "DButton")