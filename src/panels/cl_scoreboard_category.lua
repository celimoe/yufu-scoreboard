--- @class YufuScoreboardCategory : DPanel
--- @field SetCategoryName fun(self: YufuScoreboardCategory, name: string)
--- @field SetCategoryColor fun(self: YufuScoreboardCategory, color: Color)
--- @field SetPlayerCount fun(self: YufuScoreboardCategory, count: number)
--- @field SetColumns fun(self: YufuScoreboardCategory, columns: table)
--- @field AddPlayer fun(self: YufuScoreboardCategory, ply: Player): YufuScoreboardPlayer
--- @field ToggleExpanded fun(self: YufuScoreboardCategory, state: boolean)
PANEL = {}

AccessorFunc(PANEL, "categoryName", "CategoryName", FORCE_STRING)
AccessorFunc(PANEL, "categoryColor", "CategoryColor", FORCE_COLOR)
AccessorFunc(PANEL, "playerCount", "PlayerCount", FORCE_NUMBER)
AccessorFunc(PANEL, "columns", "Columns")

function PANEL:Init()
    self.categoryName = "Категория"
    self.categoryColor = Color(100, 100, 100, 50)
    self.playerCount = 0
    self.expanded = true
    self.columns = {}

    self.animProgress = 1
    self.animTween = nil

    self:SetTall(40)
    self:SetBackgroundColor(yufu.colors.generic.DARK)

    --- @class SBHeader : DButton
    self.Header = self:Add("DButton")
    self.Header:Dock(TOP)
    self.Header:SetTall(40)
    self.Header:SetText("")
    self.Header.Paint = function() end
    self.Header.DoClick = function()
        self:ToggleExpanded(not self.expanded)
    end

    self.PlayersContainer = self:Add("DPanel")
    self.PlayersContainer:SetBackgroundColor(yufu.colors.generic.EMPTY)
    self.PlayersContainer:Dock(TOP)
    self.PlayersContainer:DockMargin(5, 5, 5, 0)
    --- @diagnostic disable-next-line: inject-field
    self.PlayersContainer.Paint = function (_, _, _) end
end

function PANEL:Paint(w, h)
    surface.SetDrawColor(yufu.colors.scoreboard.CATEGORY_BACKGROUND)

    local containerHeight = self.PlayersContainer:GetTall() * self.animProgress
    surface.DrawRect(4, 40, w - 9, containerHeight + 2)

    draw.RoundedBox(0, 0, 0, w, 40, self.categoryColor)

    local halfW = w / 2
    surface.SetDrawColor(220, 37, 90, 220)
    surface.SetMaterial(yufu.mats.generic.GRADIENT_R)
    surface.DrawTexturedRect(1, 1, halfW, 38)
    surface.SetMaterial(yufu.mats.generic.GRADIENT_L)
    surface.DrawTexturedRect(halfW, 1, halfW, 38)

    draw.RoundedBox(0, 2, 2, w - 4, 36, yufu.colors.generic.DARK)

    draw.SimpleText(self.categoryName, "yufu_scoreboard_headingBold",
        halfW, 19, yufu.colors.generic.WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER
    )

    local arrowX = w - 22
    local arrowY = 20

    local arrowRotation = self.animProgress * -180
    surface.SetDrawColor(255, 255, 255, 220)

    local rad = math.rad(arrowRotation)
    local _cos = math.cos(rad)
    local _sin = math.sin(rad)

    local points = {
        {x = -6, y = -3},
        {x = 0, y = 3},
        {x = 6, y = -3}
    }

    for i = 1, 2 do
        local p1 = points[i]
        local p2 = points[i + 1]

        local x1 = p1.x * _cos - p1.y * _sin + arrowX
        local y1 = p1.x * _sin + p1.y * _cos + arrowY
        local x2 = p2.x * _cos - p2.y * _sin + arrowX
        local y2 = p2.x * _sin + p2.y * _cos + arrowY

        surface.DrawLine(x1, y1, x2, y2)
    end
end

function PANEL:ToggleExpanded(state)
    self.expanded = state
    yufu.gui.scoreboard.categoriesEnabled[self.categoryName] = state

    local targetProgress = self.expanded and 1 or 0

    self.animTween = yufu.tween.new(0.3, self, {animProgress = targetProgress}, yufu.tween.easing.outCirc)

    if self.expanded then
        self.PlayersContainer:SetVisible(true)
    end
end

function PANEL:Think()
    if self.animTween then
        local complete = self.animTween:update(FrameTime())

        self:UpdateSize()

        if complete then
            self.animTween = nil

            if not self.expanded then
                self.PlayersContainer:SetVisible(false)
            end
        end
    end
end

function PANEL:AddPlayer(ply)
    local playerPanel = self.PlayersContainer:Add("YufuScoreboardPlayer")
    playerPanel:SetPlayer(ply)
    playerPanel:SetColumns(self.columns)
    playerPanel:Dock(TOP)
    playerPanel:DockMargin(0, 0, 0, 2)

    self:UpdateSize()

    return playerPanel
end

function PANEL:UpdateSize()
    local visibleCount = 0
    for _, playerPanel in ipairs(self.PlayersContainer:GetChildren()) do
        if IsValid(playerPanel) and playerPanel:IsVisible() then
            visibleCount = visibleCount + 1
        end
    end

    local totalHeight = visibleCount * 46
    self.PlayersContainer:SetTall(totalHeight)

    local animatedHeight = totalHeight * self.animProgress
    self:SetTall(44 + animatedHeight)
end

vgui.Register("YufuScoreboardCategory", PANEL, "DPanel")