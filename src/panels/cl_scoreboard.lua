--- @class YufuScoreboard : EditablePanel
local PANEL = {}

PANEL.categories = {
    ["Столпы"] = {order = 1, color = Color(0, 255, 127, 50)},
    ["Бывшие Столпы"] = {order = 2, color = Color(145, 33, 33, 50)},
    ["Цугуко"] = {order = 3, color = Color(0, 127, 255, 50)},
    ["Инструктор Истребителей Демонов"] = {order = 4, color = Color(0, 255, 255, 50)},
    ["Истребители демонов"] = {order = 5, color = Color(255, 255, 0, 50)},
    ["Истребители"] = {order = 6, color = Color(255, 20, 147, 50)},
    ["Чистильщики"] = {order = 7, color = Color(127, 0, 255, 50)},
    ["Ученики"] = {order = 8, color = Color(255, 127, 0, 50)},

    ["Демоны 12 лун"] = {order = 9, color = Color(0, 255, 0, 50)},
    ["Высшая Луна"] = {order = 10, color = Color(255, 0, 127, 50)},
    ["Низшая Луна"] = {order = 11, color = Color(255, 0, 255, 50)},
    ["Семья пауков"] = {order = 12, color = Color(84, 84, 84, 50)},
    ["Демоны"] = {order = 13, color = Color(127, 255, 0, 50)},

    ["Лорные персонажи"] = {order = 14, color = Color(0, 0, 255, 50)},
    ["Donate"] = {order = 15, color = Color(255, 215, 0, 50)},
    ["Начальное"] = {order = 17, color = Color(255, 0, 0, 50)},
    ["Скитальцы"] = {order = 16, color = Color(255, 165, 0, 50)},

    ["Прочие"] = {order = 17, color = Color(255, 255, 255, 50)},
    ["Other"] = {order = 18, color = Color(255, 255, 255, 50)}
}

PANEL.columns = {
    [1] = {
        id = "voice",
        header = "Громкость",
        headerColor = yufu.colors.scoreboard.COLUMN_HEADER_VOICE,
        width = 50,
        panel = function(self, parent, ply)
            local panel = vgui.Create("EditablePanel", parent)
            panel:Dock(RIGHT)
            panel:SetWide(self.width)

            local voiceSlider = panel:Add("YufuScoreboardVoiceSlider")
            voiceSlider:Dock(FILL)
            voiceSlider:DockMargin(9, 6, 8, 6)
            voiceSlider:SetPlayer(ply)

            return panel
        end
    },
    [2] = {
        id = "ping",
        header = "Пинг",
        headerColor = yufu.colors.scoreboard.COLUMN_HEADER_PING,
        width = 50,
        panel = function(self, parent, ply)
            --- @class SBPingColumn : DPanel
            local panel = parent:Add("EditablePanel")
            panel:Dock(RIGHT)
            panel:SetWide(self.width)
            panel.Paint = function(_, w, h)
                if IsValid(ply) then
                    draw.SimpleText(
                        tostring(ply:Ping()),
                        "yufu_scoreboard_body",
                        w / 2, h / 2,
                        self.headerColor,
                        TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER
                    )
                end
            end
            return panel
        end
    },
    [3] = {
        id = "kills",
        header = "Убийства",
        headerColor = yufu.colors.scoreboard.COLUMN_HEADER_KILLS,
        width = 75,
        panel = function(self, parent, ply)
            --- @class SBKillsColumn : DPanel
            local panel = parent:Add("EditablePanel")
            panel:Dock(RIGHT)
            panel:SetWide(self.width)
            panel.Paint = function(_, w, h)
                if IsValid(ply) then
                    draw.SimpleText(
                        tostring(ply:Frags()),
                        "yufu_scoreboard_body",
                        w / 2, h / 2,
                        yufu.colors.generic.WHITE,
                        TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER
                    )
                end
            end
            return panel
        end
    },
    [4] = {
        id = "deaths",
        header = "Смерти",
        headerColor = yufu.colors.scoreboard.COLUMN_HEADER_DEATHS,
        width = 65,
        panel = function(self, parent, ply)
            --- @class SBDeathsColumn : DPanel
            local panel = parent:Add("EditablePanel")
            panel:Dock(RIGHT)
            panel:SetWide(self.width)
            panel.Paint = function(_, w, h)
                if IsValid(ply) then
                    draw.SimpleText(
                        tostring(ply:Deaths()),
                        "yufu_scoreboard_body",
                        w / 2, h / 2,
                        yufu.colors.generic.WHITE,
                        TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER
                    )
                end
            end
            return panel
        end
    },
    [5] = {
        id = "kd",
        header = "K/D",
        headerColor = yufu.colors.scoreboard.COLUMN_HEADER_KD,
        width = 50,
        panel = function(self, parent, ply)
            --- @class SBKDColumn : DPanel
            local panel = parent:Add("EditablePanel")
            panel:Dock(RIGHT)
            panel:SetWide(self.width)
            panel.Paint = function(_, w, h)
                if IsValid(ply) then
                    local kdRatio = ply:Frags() / math.max(1, ply:Deaths())
                    local kdText
                    if kdRatio % 1 == 0 then
                        kdText = tostring(math.floor(kdRatio))
                    else
                        kdText = string.format("%.1f", kdRatio)
                    end
                    draw.SimpleText(
                        kdText,
                        "yufu_scoreboard_body",
                        w / 2, h / 2,
                        yufu.colors.generic.WHITE,
                        TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER
                    )
                end
            end
            return panel
        end
    },
    [6] = {
        id = "group",
        header = "Группа",
        headerColor = yufu.colors.scoreboard.COLUMN_HEADER_GROUP,
        width = 120,
        panel = function(self, parent, ply)
            --- @class SBGroupColumn : DPanel
            local panel = parent:Add("EditablePanel")
            panel:Dock(RIGHT)
            panel:SetWide(self.width)
            panel.Paint = function(_, w, h)
                if IsValid(ply) then
                    draw.SimpleText(
                        ply:GetUserGroup(),
                        "yufu_scoreboard_body",
                        w / 2, h / 2,
                        yufu.colors.scoreboard.COLUMN_HEADER_GROUP,
                        TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER
                    )
                end
            end
            return panel
        end
    },
    [7] = {
        id = "dotane",
        header = "Донат",
        headerColor = yufu.colors.scoreboard.COLUMN_HEADER_DOTANE,
        width = 100,
        panel = function(self, parent, ply)
            --- @class SBDonateColumn : DPanel
            local panel = parent:Add("EditablePanel")
            panel:Dock(RIGHT)
            panel:SetWide(self.width)
            panel.Paint = function(_, w, h)
                if IsValid(ply) then
                    local staffMember = ply:GetStaffMember()
                    if staffMember == "nil" then staffMember = "Basic" end
                    draw.SimpleText(
                        staffMember,
                        "yufu_scoreboard_body",
                        w / 2, h / 2,
                        yufu.colors.scoreboard.COLUMN_HEADER_DOTANE,
                        TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER
                    )
                end
            end
            return panel
        end
    }
}

function PANEL:Init()
    self:SetSize(ScrW(), ScrH())
    self:MakePopup()
    self:Center()

    self.lastUpdate = 0
    self.playerJobs = {}

    self.searchVisible = false
    self.searchAlpha = 0
    self.searchHideTime = 0
    self.searchTween = nil

    self:CreateHeader()
    self:CreateContent()
end

function PANEL:Paint(w, h)
    surface.SetDrawColor(yufu.colors.scoreboard.BACKGROUND)
    surface.DrawRect(0, 0, w, h)

    if yuui and yuui.mats and yuui.mats.ms_overlay3 then
        surface.SetDrawColor(255, 255, 255, 45)
        surface.SetMaterial(yuui.mats.ms_overlay3)
        surface.DrawTexturedRect(0, 5, w, h)
    end
end

function PANEL:PaintOver(w, h)
    if self.searchAlpha > 5 then
        local alpha = math.floor(self.searchAlpha)

        local bgColor = Color(yufu.colors.generic.DARK.r - 10, yufu.colors.generic.DARK.g - 10, yufu.colors.generic.DARK.b - 10, alpha * 0.9)
        draw.RoundedBox(6, 0, 0, w, h, bgColor)

        local textColor = Color(yufu.colors.generic.WHITE.r, yufu.colors.generic.WHITE.g, yufu.colors.generic.WHITE.b, alpha)
        local displayText = (#self.SearchEntry:GetText() > 0) and self.SearchEntry:GetText() or "нажмите клавишу для поиска..."

        draw.SimpleText(displayText, "yufu_scoreboard_displayBold",
            w / 2, h / 2 - 2, textColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER
        )

        surface.SetDrawColor(textColor)
        surface.SetMaterial(yufu.mats.icons.INFO_CIRCLE_24)
        surface.DrawTexturedRect(50, h - 50 - 24 / 2, 24, 24)

        local tip = self.SearchEntry.tips[self.SearchEntry.currentTip] or ""
        draw.SimpleText(tip, "yufu_scoreboard_body",
            50 + 24 + 8, h - 50, textColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER
        )
    end
end

function PANEL:Think()
    if self.lastUpdate and CurTime() >= self.lastUpdate then
        self.lastUpdate = CurTime() + 0.5
        self:CheckPlayers()
    end

    if self.searchTween then
        local isComplete = self.searchTween:update(FrameTime())
        if isComplete then
            self.searchTween = nil
        end
    end

    local targetAlpha = self.searchVisible and 255 or 0

    if not self.searchTween and math.abs(self.searchAlpha - targetAlpha) > 1 then
        self.searchTween = yufu.tween.new(0.3, self, { searchAlpha = targetAlpha }, yufu.tween.easing.outQuint)
    end

    if self.searchVisible and CurTime() > self.searchHideTime then
        self.searchVisible = false
        timer.Simple(0.3, function()
            if not IsValid(self) then return end
            self.SearchEntry.currentTip = math.random(1, #self.SearchEntry.tips)
        end)
    end
end

function PANEL:CreateHeader()
    --- @class SBHeader : DPanel
    self.Header = self:Add("DPanel")
    self.Header:Dock(TOP)
    self.Header:SetTall(65)
    self.Header:DockMargin(25, 10, 25, 0)

    self.Header.Paint = function(_, w, h)
        surface.SetDrawColor(yufu.colors.generic.WHITE)
        surface.SetMaterial(yufu.mats.icons.USER_24)
        surface.DrawTexturedRect(0, h / 2 - 12 + 7, 24, 24)
        draw.SimpleText(#player.GetAll() .. "/" .. game.MaxPlayers(), "yufu_scoreboard_heading",
            28, h / 2 + 1 + 7, yufu.colors.generic.WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER
        )

        draw.SimpleText(GetHostName(), "yufu_scoreboard_displayBlack",
            w / 2, h / 2 + 7, yufu.colors.generic.WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER
        )
    end

    self.Header.CloseButton = self.Header:Add("YufuScoreboardCircledButton")
    self.Header.CloseButton:SetIcon(yufu.mats.icons.CROSS_24)
    self.Header.CloseButton:SetContentAlignment(5)
    self.Header.CloseButton:SetRadius(20)
    self.Header.CloseButton:SetWide(40)
    self.Header.CloseButton:Dock(RIGHT)
    self.Header.CloseButton:DockMargin(0, 7, 0, 0)
    self.Header.CloseButton.DoClick = function()
        self:Remove()
        yufu.gui.scoreboard.panel = nil
    end

    self.Header.SettingsButton = self.Header:Add("YufuScoreboardCircledButton")
    self.Header.SettingsButton:SetIcon(yufu.mats.icons.SETTINGS_24)
    self.Header.SettingsButton:SetContentAlignment(5)
    self.Header.SettingsButton:DockMargin(0, 7, 5, 0)
    self.Header.SettingsButton:SetRadius(20)
    self.Header.SettingsButton:SetWide(40)
    self.Header.SettingsButton:Dock(RIGHT)
    self.Header.SettingsButton.DoClick = function()
        local menu = DermaMenu()

        for _, col in ipairs(self.columns) do
            local option = menu:AddOption("Показывать " .. col.header, function()
                yufu.gui.scoreboard.columnsEnabled[col.id] = not yufu.gui.scoreboard.columnsEnabled[col.id]
                self:RefreshScoreboard(true)
            end)

            if yufu.gui.scoreboard.columnsEnabled[col.id] then
                option:SetIcon("icon16/tick.png")
            else
                option:SetIcon("icon16/cross.png")
            end
        end

        menu:AddSpacer()
        local altSortingOption = menu:AddOption("Альтернативная сортировка (по фракции)", function()
            yufu.gui.scoreboard.altSortingEnabled = not yufu.gui.scoreboard.altSortingEnabled
            self:RefreshScoreboard(false)
        end)

        if yufu.gui.scoreboard.altSortingEnabled then
            altSortingOption:SetIcon("icon16/tick.png")
        else
            altSortingOption:SetIcon("icon16/cross.png")
        end

        menu:Open()
    end

    self:CreateSearch()
end

function PANEL:CreateSearch()
    --- funniest solution ever
    --- i couldn't come up with anything better-i'm just dumb
    --- @class SBSearchEntry : DTextEntry
    self.SearchEntry = self:Add("DTextEntry")
    self.SearchEntry:SetSize(0, 0)

    self.SearchEntry.OnTextChanged = function()
        if not IsValid(self) then return end

        self.searchVisible = true
        self.searchHideTime = CurTime() + 1.5

        self:FilterPlayers()
    end

    self.SearchEntry.OnGetFocus = function()
        if not IsValid(self) then return end

        self.searchVisible = true
        self.searchHideTime = CurTime() + 1.5
    end

    self.SearchEntry.tips = {
        "Поиск по имени, SteamID, группе и должности.",
        "Нажмите на шестеренку, чтобы настроить таблицу игроков под себя!",
        "Кликните по аватарке игрока, чтобы открыть его профиль.",
        "Категории можно сворачивать и разворачивать — кликай по ним!",
        "Используй колесико мыши для прокрутки списка.",
        "Знаешь ли ты, что можно искать и по SteamID64? Да-да, серьезно!",
        "Громкость игрока — это не только кнопка, но и слайдер: тяни вверх-вниз!"
    }
    self.SearchEntry.currentTip = math.random(1, #self.SearchEntry.tips)
end

function PANEL:OnKeyCodePressed(keyCode)
    if (keyCode >= KEY_A and keyCode <= KEY_Z) then
        if IsValid(self.SearchEntry) then
            self.SearchEntry:RequestFocus()
        end
        return true
    end

    if (keyCode == KEY_LBRACKET or keyCode == KEY_RBRACKET or keyCode == KEY_SEMICOLON or
    keyCode == KEY_APOSTROPHE or keyCode == KEY_COMMA or keyCode == KEY_PERIOD) then
        if IsValid(self.SearchEntry) then
            self.SearchEntry:RequestFocus()
        end
        return true
    end

    if keyCode == KEY_SPACE or keyCode == KEY_BACKSPACE then
        if IsValid(self.SearchEntry) then
            self.SearchEntry:RequestFocus()
        end
        return true
    end

    return false
end

function PANEL:FilterPlayers()
    if not IsValid(self.Content) or not IsValid(self.Content.PlayersList) then return end

    local query = utf8.lower(self.SearchEntry:GetText())
    local canvas = self.Content.PlayersList:GetCanvas()

    if not IsValid(canvas) then return end

    local totalVisible = 0

    for _, category in ipairs(canvas:GetChildren()) do
        if not IsValid(category) or not category.PlayersContainer then continue end

        local visibleCount = 0

        for _, playerPanel in ipairs(category.PlayersContainer:GetChildren()) do
            if not IsValid(playerPanel) or not IsValid(playerPanel.player) then continue end

            local ply = playerPanel.player
            local shouldShow = false

            if query == "" then
                shouldShow = true
            else
                -- player name
                local playerName = utf8.lower(ply:Nick())
                if string.find(playerName, query, 1, true) then
                    shouldShow = true
                end

                -- steamID
                if not shouldShow then
                    local steamID = utf8.lower(ply:SteamID() or "")
                    local steamID64 = utf8.lower(ply:SteamID64() or "")
                    if string.find(steamID, query, 1, true) or string.find(steamID64, query, 1, true) then
                        shouldShow = true
                    end
                end

                -- job name
                if not shouldShow and ply.getJobTable then
                    local jobTable = ply:getJobTable()
                    if jobTable and jobTable.name then
                        local jobName = utf8.lower(jobTable.name)
                        if string.find(jobName, query, 1, true) then
                            shouldShow = true
                        end
                    end
                end

                -- group name
                if not shouldShow then
                    local userGroup = utf8.lower(ply:GetUserGroup())
                    if string.find(userGroup, query, 1, true) then
                        shouldShow = true
                    end
                end
            end

            playerPanel:SetVisible(shouldShow)
            if shouldShow then
                visibleCount = visibleCount + 1
                totalVisible = totalVisible + 1
            end
        end

        category:SetVisible(visibleCount > 0)
        category:UpdateSize()

        if IsValid(category.PlayersContainer) then
            category.PlayersContainer:InvalidateLayout(true)
        end
        category:InvalidateLayout(true)
    end

    canvas:InvalidateLayout(true)
    canvas:SizeToChildren(false, true)
    self.Content.PlayersList:InvalidateLayout(true)
    self.Content.PlayersList:InvalidateParent(true)
    self.Content:InvalidateLayout(true)

    if query ~= "" and totalVisible == 0 then
        self.Content.ColumnNames:SetVisible(false)
        self.Content.Divider:SetVisible(false)
        self.Content.Paint = function(_, w, h)
            surface.SetDrawColor(yufu.colors.generic.WHITE)
            if yufu.mats.icons.MOOD_SAD_64 then
                surface.SetMaterial(yufu.mats.icons.MOOD_SAD_64)
                surface.DrawTexturedRect(w / 2 - 32, h / 2 - 80, 64, 64)
            end

            draw.SimpleText("Ничего не найдено", "yufu_scoreboard_displayBold",
                w / 2, h / 2, yufu.colors.generic.WHITE_HALFALPHA, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER
            )

            draw.SimpleText("Попробуйте изменить поисковый запрос", "yufu_scoreboard_body",
                w / 2, h / 2 + 30, yufu.colors.generic.WHITE_PENNYALPHA, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER
            )
        end
    else
        self.Content.ColumnNames:SetVisible(true)
        self.Content.Divider:SetVisible(true)
        self.Content.Paint = function (_, _, _) end
    end
end

function PANEL:CreateContent()
    --- @class SBContent : DPanel
    self.Content = self:Add("DPanel")
    self.Content:SetBackgroundColor(yufu.colors.generic.EMPTY)
    self.Content:DockMargin(50, 10, 50, 50)
    self.Content:Dock(FILL)
    self.Content.Paint = function (_, _, _) end

    self.Content.ColumnNames = self.Content:Add("YufuScoreboardColumnNames")
    self.Content.ColumnNames:SetColumns(self.columns)
    self.Content.ColumnNames:SetTall(20)
    self.Content.ColumnNames:Dock(TOP)
    self.Content.ColumnNames:DockMargin(5, 0, 5, 0)

    --- @class SBDivider : DPanel
    self.Content.Divider = self.Content:Add("DPanel")
    self.Content.Divider:Dock(TOP)
    self.Content.Divider:DockMargin(0, 0, 0, 2)
    self.Content.Divider:SetTall(3)
    self.Content.Divider.Paint = function (_, w, h)
        local centerY = h / 2
        surface.SetDrawColor(yufu.colors.generic.MAGENTA_HALFALPHA)
        surface.SetMaterial(yufu.mats.generic.GRADIENT_R)
        surface.DrawTexturedRect(13, centerY, w / 2, 1)
        surface.SetMaterial(yufu.mats.generic.GRADIENT_L)
        surface.DrawTexturedRect(w / 2 + 13, centerY, w / 2, 1)
    end

    self.Content.PlayersList = self.Content:Add("YufuScoreboardAnimatedScrollPanel")
    self.Content.PlayersList:SetBackgroundColor(yufu.colors.generic.EMPTY)
    self.Content.PlayersList:SetScrollEasing(yufu.tween.easing.outQuint)
    self.Content.PlayersList:Dock(FILL)
    self.Content.PlayersList.Paint = function (_, _, _) end

    self:PopulateScoreboard()
end

function PANEL:CheckPlayers()
    local currentPlayers = player.GetAll()
    local needsRefresh = false

    if #currentPlayers ~= (self.lastPlayerCount or 0) then
        needsRefresh = true
    else
        for _, ply in ipairs(currentPlayers) do
            ---@diagnostic disable-next-line: undefined-field
            local oldJob = self.playerJobs[ply] or ""
            local newJob = self:GetPlayerCategory(ply)

            if oldJob ~= newJob then
                needsRefresh = true
                break
            end
        end
    end

    if needsRefresh then
        self.lastPlayerCount = #currentPlayers
        self:RefreshScoreboard(false)
    end
end

function PANEL:RefreshScoreboard(force)
    if IsValid(self.Content.ColumnNames) and force then
        self.Content.ColumnNames:CreateHeaders()
    end

    if IsValid(self.SearchEntry) and force then
        self.SearchEntry:SetText("")
    end

    if IsValid(self.Content.PlayersList) then
        local canvas = self.Content.PlayersList:GetCanvas()
        if IsValid(canvas) then
            canvas:Clear()
        end

        self:PopulateScoreboard()
    end

    if IsValid(self.SearchEntry) and not force and self.SearchEntry:GetText() ~= "" then
        self:FilterPlayers()
    end
end

function PANEL:GetPlayerCategory(ply)
    if yufu.gui.scoreboard.altSortingEnabled then
        if ply:IsSlayer() then
            return "Истребители"
        elseif ply:IsDemon() then
            return "Демоны"
        end
        return "Скитальцы"
    else
        local jobTable = ply.getJobTable and ply:getJobTable() or nil
        if jobTable and jobTable.category then
            return jobTable.category
        end
        return "Прочие"
    end
end

function PANEL:PopulateScoreboard()
    self.playerJobs = {}

    local categoryGroups = {}
    for _, ply in ipairs(player.GetAll()) do
        local categoryName = self:GetPlayerCategory(ply)
        self.playerJobs[ply] = categoryName
        categoryGroups[categoryName] = categoryGroups[categoryName] or {}
        table.insert(categoryGroups[categoryName], ply)
    end

    for _, players in pairs(categoryGroups) do
        table.sort(players, function(a, b)
            return utf8.lower(a:Nick()) < utf8.lower(b:Nick())
        end)
    end

    local orderedCategories = {}
    for categoryName, players in pairs(categoryGroups) do
        table.insert(orderedCategories, {name = categoryName, players = players})
    end

    table.sort(orderedCategories, function(a, b)
        local orderA = (self.categories[a.name] and self.categories[a.name].order) or 100
        local orderB = (self.categories[b.name] and self.categories[b.name].order) or 100
        if orderA == orderB then
            return a.name < b.name
        end
        return orderA < orderB
    end)

    for _, data in ipairs(orderedCategories) do
        local category = self.Content.PlayersList:Add("YufuScoreboardCategory")
        category:SetCategoryName(data.name)
        category:SetCategoryColor((self.categories[data.name] and self.categories[data.name].color) or Color(100, 100, 100, 50))
        category:SetPlayerCount(#data.players)
        category:SetColumns(self.columns)
        category:Dock(TOP)
        category:DockMargin(0, 0, 0, 8)

        local isExpanded = yufu.gui.scoreboard.categoriesEnabled[data.name]
        if isExpanded ~= nil then
            category:ToggleExpanded(isExpanded)

            if not category.expanded then
                category.animProgress = 0
                category.PlayersContainer:SetVisible(false)
            end
        end

        for _, ply in ipairs(data.players) do
            category:AddPlayer(ply)
        end
    end
end

vgui.Register("YufuScoreboard", PANEL, "EditablePanel")