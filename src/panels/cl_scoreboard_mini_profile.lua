--- @class YufuScoreboardMiniProfile : DPanel
PANEL = {}

function PANEL:Init()
    self:SetSize(340, 457)
    self:SetZPos(2000)
    self:SetKeyboardInputEnabled(false)
    self:SetMouseInputEnabled(true)

    self.player = nil

    self.isDragging = false
    self.dragOffset = {x = 0, y = 0}
    self.isAdminMode = false
    self.adminPanelHeight = 0

    self:CreateBanner()
    self:CreateAvatar()
    self:CreateCommends()
    self:CreateContent()
end

function PANEL:CreateBanner()
    self.Banner = self:Add("YufuScoreboardMiniProfileBanner")
    self.Banner:Dock(TOP)
    self.Banner:DockMargin(2, 2, 2, 0)
    self.Banner:SetTall(105)
    self.Banner:SetSolidColor(yufu.colors.generic.WHITE)
    self.Banner.OnMousePressed = function(_, key)
        if key == MOUSE_LEFT then
            self.isDragging = true
            local mx, my = gui.MouseX(), gui.MouseY()
            local px, py = self:GetPos()
            self.dragOffset.x = mx - px
            self.dragOffset.y = my - py
        end
    end

    self.Banner.OnMouseReleased = function(_, key)
        if key == MOUSE_LEFT then
            self.isDragging = false
        end
    end

    self.Banner.OnCursorEntered = function(s) s:SetCursor("sizeall") end
    self.Banner.OnCursorExited = function(s) s:SetCursor("arrow") end

    self:CreateBannerButtons()
end

function PANEL:CreateBannerButtons()
    --- @class SBBannerButtons : DPanel
    self.BannerButtons = self.Banner:Add("DPanel")
    self.BannerButtons:Dock(RIGHT)
    self.BannerButtons:SetWide(32)
    self.BannerButtons:SetBackgroundColor(yufu.colors.generic.EMPTY)
    self.BannerButtons:DockMargin(0, 5, 5, 105 - 37)
    self.BannerButtons.Paint = function(_, _, _) end
    self.BannerButtons.buttons = {}

    self:CreateCloseButton()
    self:CreateIPConnectionsButton()
    self:CreateSwapBannerButton()
end

function PANEL:CreateCloseButton()
    local closeButton = self.BannerButtons:Add("YufuScoreboardCircledButton")
    closeButton:SetIcon(yufu.mats.icons.CROSS_24)
    closeButton:SetOutlineColor(yufu.colors.generic.EMPTY)
    closeButton:SetColor(Color(0, 0, 0, 200))
    closeButton:SetSize(32, 32)
    closeButton:SetRadius(16)
    closeButton:Dock(RIGHT)
    closeButton:DockMargin(3, 0, 0, 0)
    closeButton.DoClick = function()
        if IsValid(self) then
            self:Remove()
            yufu.gui.scoreboard.mini = nil
        end
    end
    self.BannerButtons.buttons.closeButton = closeButton
end

function PANEL:CreateIPConnectionsButton()
    local ipConnectionsButton = self.BannerButtons:Add("YufuScoreboardCircledButton")
    ipConnectionsButton:SetVisible(false)
    ipConnectionsButton:SetIcon(yufu.mats.icons.SWORD_24)
    ipConnectionsButton:SetOutlineColor(yufu.colors.generic.EMPTY)
    ipConnectionsButton:SetColor(Color(0, 0, 0, 200))
    ipConnectionsButton:SetSize(32, 32)
    ipConnectionsButton:SetRadius(16)
    ipConnectionsButton:Dock(RIGHT)
    ipConnectionsButton:DockMargin(3, 0, 0, 0)
    ipConnectionsButton.DoClick = function() self:ToggleAdminMode() end
    self.BannerButtons.buttons.ipConnectionsButton = ipConnectionsButton
end

function PANEL:CreateSwapBannerButton()
    local swapBannerButton = self.BannerButtons:Add("YufuScoreboardCircledButton")
    swapBannerButton:SetVisible(false)
    swapBannerButton:SetIcon(yufu.mats.icons.PHOTO_24)
    swapBannerButton:SetOutlineColor(yufu.colors.generic.EMPTY)
    swapBannerButton:SetColor(Color(0, 0, 0, 200))
    swapBannerButton:SetSize(32, 32)
    swapBannerButton:SetRadius(16)
    swapBannerButton:Dock(RIGHT)
    swapBannerButton.DoClick = function()
        if not IsValid(self.player) then return end

        local menu = DermaMenu()

        local defaultOption = menu:AddOption("По умолчанию", function()
            self:ChangeBanner("default")
        end)

        if self.player:GetNWString("yufu_bg_type", "default") == "default" then
            defaultOption:SetChecked(true)
        end

        menu:AddSpacer()

        for bgType, matData in pairs(yufu.mats.banners) do
            local option = menu:AddOption(matData.name, function()
                self:ChangeBanner(bgType)
            end)

            if self.player:GetNWString("yufu_bg_type", "default") == bgType then
                option:SetChecked(true)
            end
        end

        menu:Open()
    end
    self.BannerButtons.buttons.swapBannerButton = swapBannerButton
end

function PANEL:ChangeBanner(bannerType)
    if not IsValid(self.player) then return end

    local isSelf = self.player == LocalPlayer()
    if isSelf then
        RunConsoleCommand("yufu_set_bg", bannerType)
    else
        RunConsoleCommand("yufu_admin_set_bg", self.player:SteamID(), bannerType)
    end

    timer.Simple(0.5, function()
        if not IsValid(self) then return end
        self:UpdateBanner()
    end)
end

function PANEL:CreateAvatar()
    self.Avatar = self:Add("YufuScoreboardMiniProfileCircledAvatar")
    self.Avatar:SetPos(20, 105 - 45)
    self.Avatar:SetSize(90, 90)
    self.Avatar:SetZPos(3000)

    --- @class SBAvatarBtn : DButton
    local avatarBtn = self.Avatar:Add("DButton")
    avatarBtn:SetSize(90, 90)
    avatarBtn:SetPos(0, 0)
    avatarBtn:SetText("")
    avatarBtn.Paint = function() end
    avatarBtn.DoClick = function()
        if IsValid(self.player) then
            self.player:ShowProfile()
        end
    end
end

function PANEL:CreateCommends()
    --- @class SBCommends : DPanel
    self.Commends = self:Add("DPanel")
    self.Commends:Dock(TOP)
    self.Commends:SetTall(45)
    self.Commends:DockMargin(120, 0, 20, 0)
    self.Commends:DockPadding(0, 4, 0, 0)
    self.Commends.Paint = function(_, _, _) end

    local buttons = {
        {icon = yufu.mats.icons.HEART_24, color = yufu.colors.scoreboard.COMMEND_LIKE, key = "yufu_likes", action = function(ply)
            RunConsoleCommand('yufu_rate_player', ply:SteamID(), 'like', 'add')
        end},
        {icon = yufu.mats.icons.MOOD_HAPPY_24, color = yufu.colors.scoreboard.COMMEND_RP, key = "yufu_rp", action = function(ply)
            RunConsoleCommand('yufu_rate_player', ply:SteamID(), 'rp', 'add')
        end},
        {icon = yufu.mats.icons.BOLD_24, color = yufu.colors.scoreboard.COMMEND_PVP, key = "yufu_pvp", action = function(ply)
            RunConsoleCommand('yufu_rate_player', ply:SteamID(), 'pvp', 'add')
        end}
    }

    for i, data in ipairs(buttons) do
        local btn = self.Commends:Add("YufuScoreboardRippleButton")
        btn:SetIcon(data.icon)
        btn:SetIconColor(data.color)
        btn:Dock(i < #buttons and LEFT or FILL)
        btn:SetValue(function()
            if not IsValid(self.player) then return 0 end
            return self.player:GetNWInt(data.key, 0)
        end)
        btn.DoClick = function(s)
            if IsValid(self.player) then
                data.action(self.player)
            end
        end
        if i < #buttons then
            btn:DockMargin(0, 0, 4, 0)
        end
    end

    self.Commends.PerformLayout = function(s, w, _)
        local buttonWidth = (w - 4) / #buttons
        for _, child in ipairs(s:GetChildren()) do
            if child:GetDock() == LEFT then
                child:SetWide(buttonWidth)
            end
        end
    end
end

function PANEL:CreateContent()
    self.Info = self:Add("DPanel")
    self.Info:Dock(FILL)
    self.Info:DockMargin(20, 10, 20, 20)
    self.Info:SetBackgroundColor(yufu.colors.generic.EMPTY)
    --- @diagnostic disable-next-line: inject-field
    self.Info.Paint = function(_, _, _) end

    self:CreatePlayerInfo()
    self:CreateOnlineInfo()
    self:CreateAchievements()
    self:CreateAdminButtons()
end

function PANEL:CreatePlayerInfo()
    self.PlayerName = self.Info:Add("DLabel")
    self.PlayerName:SetFont("yufu_scoreboard_title")
    self.PlayerName:SetTextColor(yufu.colors.generic.WHITE)
    self.PlayerName:SetText("Name")
    self.PlayerName:SizeToContents()
    self.PlayerName:Dock(TOP)

    --- @class SBSteamID : DLabel
    self.SteamID = self.Info:Add("DLabel")
    self.SteamID:SetFont("yufu_scoreboard_caption")
    self.SteamID:SetTextColor(yufu.colors.generic.WHITE)
    self.SteamID:SetText("STEAM_0:0:000000")
    self.SteamID:SizeToContents()
    self.SteamID:SetMouseInputEnabled(true)
    self.SteamID:Dock(TOP)
    self.SteamID:DockMargin(0, -1, 0, 0)
    self.SteamID.DoClick = function()
        if IsValid(self.player) then
            SetClipboardText(self.player:SteamID())
        end
    end
    self.SteamID.OnCursorEntered = function(s)
        s:SetCursor("hand")
        s:SetTextColor(yufu.colors.generic.MAGENTA)
    end
    self.SteamID.OnCursorExited = function(s)
        s:SetCursor("arrow")
        s:SetTextColor(yufu.colors.generic.WHITE)
    end

    self.JobName = self.Info:Add("DLabel")
    self.JobName:SetFont("yufu_scoreboard_caption")
    self.JobName:SetTextColor(yufu.colors.generic.WHITE)
    self.JobName:SetText("Неизвестно")
    self.JobName:SizeToContents()
    self.JobName:Dock(TOP)
end

function PANEL:CreateOnlineInfo()
    --- @class SBOnline : DLabel
    self.Online = self.Info:Add("DLabel")
    self.Online:SetFont("yufu_scoreboard_body")
    self.Online:SetTextColor(yufu.colors.generic.WHITE)
    self.Online:SetText("Онлайн: 0 ч 0 мин")
    self.Online:SizeToContents()
    self.Online:Dock(TOP)
    self.Online:DockMargin(0, 10, 0, 0)

    self.Online.lastUpdate = 0
    self.Online.Think = function(s)
        if CurTime() - (s.lastUpdate or 0) < 1 then return end
        s.lastUpdate = CurTime()

        if IsValid(self.player) then
            --- @diagnostic disable-next-line: undefined-field
            local sessionTime = self.player:GetUTimeSessionTime()
            --- @diagnostic disable-next-line: undefined-field
            local totalTime = self.player:GetUTime()

            local function formatTime(seconds)
                local hours = math.floor(seconds / 3600)
                local minutes = math.floor((seconds % 3600) / 60)
                local secs = math.floor(seconds % 60)

                if hours > 0 then
                    return string.format("%dч %dм %dс", hours, minutes, secs)
                elseif minutes > 0 then
                    return string.format("%dм %dс", minutes, secs)
                else
                    return string.format("%dс", secs)
                end
            end

            local currentFormatted = formatTime(sessionTime)
            local totalHours = math.floor(totalTime / 3600)
            local online = string.format("Онлайн: %s / %dч", currentFormatted, totalHours)

            s:SetText(online)
            s:SizeToContents()
        end
    end
end

function PANEL:CreateAchievements()
    self.Achievements = self.Info:Add("YufuScoreboardAchievements")
    self.Achievements:Dock(TOP)
    self.Achievements:DockMargin(0, 15, 0, 0)
    self.Achievements.OnExpandToggled = function(_, delta)
        self:SetTall(self:GetTall() + delta)
    end
end

function PANEL:CreateAdminButtons()
    --- @class SBAdminButtonsContainer: DPanel
    self.AdminButtonsContainer = self.Info:Add("DPanel")
    self.AdminButtonsContainer:Dock(TOP)
    self.AdminButtonsContainer:DockMargin(0, 12, 0, 0)
    self.AdminButtonsContainer:SetVisible(false)
    self.AdminButtonsContainer.Paint = function(_, w, h)
        draw.RoundedBox(6, 0, 0, w, h, yufu.colors.generic.LIGHTER)
    end

    local layout = self.AdminButtonsContainer:Add("DIconLayout")
    layout:Dock(FILL)
    layout:DockMargin(8, 8, 8, 8)
    layout:SetSpaceY(8)
    layout:SetSpaceX(8)

    local buttons = {
        -- 284 - ( 8 * 2 ) = 268 / 3 = 89.33
        {text = "Bring", width = 89, action = function(ply)
            RunConsoleCommand("sam", "bring", ply:SteamID())
        end},
        {text = "Goto", width = 89, action = function(ply)
            RunConsoleCommand("sam", "goto", ply:SteamID())
        end},
        {text = "Strip", width = 89, action = function(ply)
            RunConsoleCommand("sam", "strip", ply:SteamID())
        end},
        {text = "Freeze", width = 89, action = function(ply)
            RunConsoleCommand("sam", "freeze", ply:SteamID())
        end},
        {text = "UnFreeze", width = 89, action = function(ply)
            RunConsoleCommand("sam", "unfreeze", ply:SteamID())
        end},
        {text = "Respawn", width = 89, action = function(ply)
            RunConsoleCommand("sam", "respawn", ply:SteamID())
        end},
        {text = "Spectate", width = 284, action = function(ply)
            RunConsoleCommand("say", "/spectate ", ply:SteamID())
        end}
    }

    for _, btnData in ipairs(buttons) do
        --- @class SBAdminButton : DButton
        local btn = layout:Add("DButton")
        btn:SetText("")
        btn:SetSize(btnData.width, 35)
        btn.Paint = function(s, w, h)
            local col = s:IsHovered() and yufu.colors.generic.MAGENTA_HALFALPHA or yufu.colors.generic.LIGHTERER
            draw.RoundedBox(6, 0, 0, w, h, col)
            draw.SimpleText(btnData.text, "yufu_scoreboard_body",
                w / 2, h / 2, yufu.colors.generic.WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER
            )
        end
        btn.DoClick = function()
            if IsValid(self.player) then
                btnData.action(self.player)
            end
        end
    end
end

function PANEL:SetPlayer(ply)
    if not IsValid(ply) then return end
    self.player = ply

    self:UpdateAvatar()
    self:UpdatePlayerInfo()
    self:UpdateBanner()
    self:UpdateAchievements()
    self:UpdateButtonsVisibility()
    self:RecalculateSize()
end

function PANEL:UpdateAvatar()
    if IsValid(self.Avatar) and IsValid(self.player) then
        self.Avatar:SetPlayer(self.player, 90)
    end
end

function PANEL:UpdatePlayerInfo()
    if IsValid(self.Avatar) then
        self.Avatar:SetPlayer(self.player, 90)
    end

    if IsValid(self.PlayerName) then
        self.PlayerName:SetText(self.player:Nick())
        self.PlayerName:SizeToContents()
    end

    if IsValid(self.SteamID) then
        self.SteamID:SetText(self.player:SteamID())
        self.SteamID:SizeToContents()
    end

    if IsValid(self.JobName) then
        ---@diagnostic disable-next-line: undefined-field
        local jobTable = self.player.getJobTable and self.player:getJobTable() or {}
        local color = jobTable.color or yufu.colors.generic.WHITE
        local newColor = Color(color.r, color.g, color.b) -- please push COLOR:Copy() to main branch 😭 
        newColor:SetLightness(0.8)
        self.JobName:SetText(jobTable.name or "Неизвестно")
        self.JobName:SetTextColor(newColor or yufu.colors.generic.WHITE)
        self.JobName:SizeToContents()
    end
end

function PANEL:UpdateBanner()
    if IsValid(self.Banner) then
        local color = team.GetColor(self.player:Team())
        self.Banner:SetSolidColor(color)
        local bannerId = self.player:GetNWString("yufu_bg_type", "default")
        self.Banner:SetMaterial(yufu.mats.getBanner(bannerId))
    end
end

function PANEL:UpdateAchievements()
    if IsValid(self.Achievements) then
        self.Achievements:SetPlayer(self.player)
    end
end

function PANEL:UpdateButtonsVisibility()
    if not IsValid(self.BannerButtons) then return end

    if self:ShouldShowIPButton() then
        self.BannerButtons.buttons.ipConnectionsButton:SetVisible(true)
        self.BannerButtons:SetWide(self.BannerButtons:GetWide() + 35)
    end

    if self:ShouldShowBannerButton() then
        self.BannerButtons.buttons.swapBannerButton:SetVisible(true)
        self.BannerButtons:SetWide(self.BannerButtons:GetWide() + 35)
    end
end

function PANEL:RecalculateSize()
    local isAdmin = self:ShouldShowAdminControls()
    if isAdmin then
        self:SetTall(self:GetTall() + 36)

        local height = (35 * 3) + (8 * 4)
        self.adminPanelHeight = height

        self.AdminButtonsContainer:SetVisible(true)
        self.AdminButtonsContainer:SetTall(height)
        self:SetTall(self:GetTall() + height + 4)
    end
end

function PANEL:CalculateSize()
    if self.isAdminMode then
        return 1000, 800
    end

    local isAdmin = self:ShouldShowAdminControls()
    local achievementsHeight = isAdmin and 36 or 0
    local adminHeight = isAdmin and (self.adminPanelHeight + 4) or 0

    return 340, 457 + achievementsHeight + adminHeight
end

function PANEL:ToggleAdminMode()
    self.isAdminMode = not self.isAdminMode

    local newWidth, newHeight = self:CalculateSize()
    self:SetTall(newHeight)
    self:SetWide(newWidth)

    if IsValid(self.Info) then
        self.Info:SetVisible(not self.isAdminMode)
    end
    if IsValid(self.Commends) then
        self.Commends:SetVisible(not self.isAdminMode)
    end
    if IsValid(self.Achievements) then
        if self.Achievements.isExpanded then
            self.Achievements:ToggleExpand(true)
        end
    end

    if self.isAdminMode then
        self.IpPanel = self:Add("Label")
        self.IpPanel:Dock(FILL)
        self.IpPanel:DockMargin(2, 0, 2, 2)
        self.IpPanel:SetText("not today")

        if IsValid(self.BannerButtons.buttons.ipConnectionsButton) then
            self.BannerButtons.buttons.ipConnectionsButton:SetIcon(yufu.mats.icons.CARET_LEFT_24)
        end
    else
        if IsValid(self.IpPanel) then
            self.IpPanel:Remove()
            self.IpPanel = nil
        end
        if IsValid(self.BannerButtons.buttons.ipConnectionsButton) then
            self.BannerButtons.buttons.ipConnectionsButton:SetIcon(yufu.mats.icons.SWORD_24)
        end
    end
end

function PANEL:ShouldShowAdminControls()
    local lp = LocalPlayer()
    if not IsValid(lp) then return false end
    return lp:GetUserGroup() ~= "user"
end

function PANEL:ShouldShowIPButton()
    local lp = LocalPlayer()
    if not IsValid(lp) then return false end

    local userGroup = lp:GetUserGroup()
    return lp:IsSuperAdmin() or userGroup == "curator" or userGroup == "depcurator" or userGroup == "seniorstaff"
end

function PANEL:ShouldShowBannerButton()
    local lp = LocalPlayer()
    return IsValid(lp) and lp:IsSuperAdmin()
end

function PANEL:Paint(w, h)
    draw.RoundedBox(8, 0, 0, w, h, yufu.colors.generic.DARK)
    draw.RoundedBox(8, 1, 1, w - 2, h - 2, yufu.colors.generic.LIGHTER)
    draw.RoundedBox(8, 2, 2, w - 4, h - 4, yufu.colors.generic.DARK)
end

function PANEL:Think()
    if self.isDragging then
        local mx, my = gui.MouseX(), gui.MouseY()
        local newX = mx - self.dragOffset.x
        local newY = my - self.dragOffset.y

        self:SetPos(newX, newY)
    end
end

vgui.Register("YufuScoreboardMiniProfile", PANEL, "DPanel")