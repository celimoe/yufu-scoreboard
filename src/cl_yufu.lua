yufu = yufu or {}
yufu.gui = yufu.gui or {}
yufu.colors = {
    generic = {
        EMPTY = Color(0, 0, 0, 0),
        DARKEST = Color(12, 12, 12),
        DARK = Color(18, 18, 18),
        LIGHTER = Color(25, 25, 25),
        LIGHTERER = Color(46, 46, 46),
        LIGHTEST = Color(61, 61, 61),
        WHITE = Color(188, 188, 188),
        WHITE_HALFALPHA = Color(188, 188, 188, 125),
        WHITE_PENNYALPHA = Color(188, 188, 188, 75),
        GRAY = Color(150, 150, 150),
        PINK = Color(248, 99, 126),
        MAGENTA = Color(220, 37, 90),
        MAGENTA_HALFALPHA = Color(220, 37, 90, 125),
        MAGENTA_PENNYALPHA = Color(220, 37, 90, 75)
    },
    scoreboard = {
        BACKGROUND = Color(17, 17, 17, 240),
        CATEGORY_BACKGROUND = Color(10, 10, 10, 200),
        BANNER_COLOR = Color(200, 200, 200, 55),
        COLUMN_HEADER_VOICE = Color(100, 200, 255),
        COLUMN_HEADER_PING = Color(200, 255, 200),
        COLUMN_HEADER_KILLS = Color(255, 200, 200),
        COLUMN_HEADER_DEATHS = Color(255, 150, 150),
        COLUMN_HEADER_KD = Color(255, 180, 180),
        COLUMN_HEADER_GROUP = Color(255, 255, 180),
        COLUMN_HEADER_DOTANE = Color(255, 220, 180),
        COMMEND_LIKE = Color(255, 100, 100),
        COMMEND_RP = Color(100, 200, 255),
        COMMEND_PVP = Color(255, 150, 100),
    }
}
yufu.mats = {
    generic = {
        GRADIENT_L = Material("vgui/gradient-l"),
        GRADIENT_R = Material("vgui/gradient-r"),
    },
    icons = { -- https://tabler.io/icons
        -- x64
        MOOD_SAD_64 = Material("../data/yufu/icons/yufu_mood_sad_64.png", "smooth"),
        -- x24
        CHESS_KNIGHT_24 = Material("../data/yufu/icons/yufu_chess_knight_24.png", "smooth"),
        CHEVRON_DOWN_24 = Material("../data/yufu/icons/yufu_chevron_down_24.png", "smooth"),
        INFO_CIRCLE_24 = Material("../data/yufu/icons/yufu_info_circle_24.png", "smooth"),
        CHEVRON_UP_24 = Material("../data/yufu/icons/yufu_chevron_up_24.png", "smooth"),
        MOOD_HAPPY_24 = Material("../data/yufu/icons/yufu_mood_happy_24.png", "smooth"),
        CARET_LEFT_24 = Material("../data/yufu/icons/yufu_caret_left_24.png", "smooth"),
        VOLUME_MAX_24 = Material("../data/yufu/icons/yufu_volume_max_24.png", "smooth"),
        VOLUME_MID_24 = Material("../data/yufu/icons/yufu_volume_mid_24.png", "smooth"),
        VOLUME_OFF_24 = Material("../data/yufu/icons/yufu_volume_off_24.png", "smooth"),
        COIN_YEN_24 = Material("../data/yufu/icons/yufu_coin_yen_24.png", "smooth"),
        SETTINGS_24 = Material("../data/yufu/icons/yufu_settings_24.png", "smooth"),
        DIAMOND_24 = Material("../data/yufu/icons/yufu_diamond_24.png", "smooth"),
        DIPLOMA_24 = Material("../data/yufu/icons/yufu_diploma_24.png", "smooth"),
        EYE_OFF_24 = Material("../data/yufu/icons/yufu_eye_off_24.png", "smooth"),
        CIRCLE_24 = Material("../data/yufu/icons/yufu_circle_24.png", "smooth"),
        COINS_24 = Material("../data/yufu/icons/yufu_coins_24.png", "smooth"),
        CROSS_24 = Material("../data/yufu/icons/yufu_cross_24.png", "smooth"),
        HEART_24 = Material("../data/yufu/icons/yufu_heart_24.png", "smooth"),
        MEDAL_24 = Material("../data/yufu/icons/yufu_medal_24.png", "smooth"),
        MOVIE_24 = Material("../data/yufu/icons/yufu_movie_24.png", "smooth"),
        PHOTO_24 = Material("../data/yufu/icons/yufu_photo_24.png", "smooth"),
        SWORD_24 = Material("../data/yufu/icons/yufu_sword_24.png", "smooth"),
        BOLD_24 = Material("../data/yufu/icons/yufu_bolt_24.png", "smooth"),
        STAR_24 = Material("../data/yufu/icons/yufu_star_24.png", "smooth"),
        USER_24 = Material("../data/yufu/icons/yufu_user_24.png", "smooth"),
    },
    banners = {
        ["tex01"] = { path = "t3dgm/tex01", name = "Текстура 01" },
        ["tex02"] = { path = "t3dgm/tex02", name = "Текстура 02" },
        ["tex03"] = { path = "t3dgm/tex03", name = "Текстура 03" },
        ["tex04"] = { path = "t3dgm/tex04", name = "Текстура 04" },
        ["tex05"] = { path = "t3dgm/tex05", name = "Текстура 05" },
        ["tex06"] = { path = "t3dgm/tex06", name = "Текстура 06" },
        ["tex07"] = { path = "t3dgm/tex07", name = "Текстура 07" },
        ["tex08"] = { path = "t3dgm/tex08", name = "Текстура 08" },
        ["tex56"] = { path = "t3dgm/tex56", name = "Текстура 56" },

        ["texTanj"] = { path = "models/yufu/oldjimmy/demonslayer/canon/tanjiro_kamado/kimono", name = "Танджиро" },
        ["weirdchamp"] = { path = "crowe/weirdchamp", name = "Weird Champ" },
        ["carsoncry"] = { path = "crowe/carsoncry", name = "Carson Cry" },
        ["hatkid"] = { path = "crowe/hatkid", name = "Hat Kid" },

        ["random-marihuana"] = { path = "random-marihuana", name = "Random Marihuana" },
        ["random-lego"] = { path = "random-lego", name = "Random Lego" },
        ["random-supreme"] = { path = "random-supreme", name = "Random Supreme" },
        ["random-error"] = { path = "random-error", name = "Random Error" },
        ["random-mario-2"] = { path = "random-mario-2", name = "Random Mario 2" },

        ["normal-camuflaje-2"] = { path = "normal-camuflaje-2", name = "Normal Camuflaje 2" },

        ["minecraft-diamondore"] = { path = "minecraft-diamondore", name = "Minecraft Diamond Ore" },
        ["minecraft-portal"] = { path = "minecraft-portal", name = "Minecraft Portal" },
        ["minecraft-adoquin"] = { path = "minecraft-adoquin", name = "Minecraft Adoquin" },

        ["crowe-bsod"] = { path = "crowe/bsod", name = "Crowe BSOD" },
        ["crowe-catto"] = { path = "crowe/catto", name = "Crowe Catto" },
        ["crowe-crewmate"] = { path = "crowe/crewmate", name = "Crowe Crewmate" },
        ["crowe-punch"] = { path = "crowe/punch", name = "Crowe Punch" }
    },
    -- an absolute nightmare
    getBanner = function(id)
        local errorMat = Material("vgui/gradient-l")
        if not id or id == "default" then
            return nil
        end

        local banner = yufu.mats.banners[id]
        if not banner or not banner.path or banner.path == "" then
            return nil
        end

        if banner.material then
            return banner.material
        end

        local cacheKey = banner.path .. "_" .. "UnlitGeneric"

        local baseMat = Material(banner.path)
        if not baseMat or baseMat:IsError() then
            return errorMat
        end
        local baseTexture = baseMat:GetTexture("$basetexture")
        if not baseTexture or baseTexture:IsError() then
            return errorMat
        end

        local mat = CreateMaterial(cacheKey, "UnlitGeneric", {
            ["$basetexture"] = baseTexture:GetName(),
            ["$translucent"] = "1",
            ["$vertexcolor"] = "1",
            ["$vertexalpha"] = "1"
        })

        banner.material = mat
        return mat
    end
}
-- 💀
yufu.achievements = {
    like = {
        getData = function(ply)
            local count = ply:GetNWInt("yufu_likes", 0)
            return { title = "Харизматичный игрок", icon = yufu.mats.icons.HEART_24, color = Color(255, 100, 100),
                desc = "Всего получено: " .. tostring(count)
            }
        end
    },
    rp = {
        getData = function(ply)
            local count = ply:GetNWInt("yufu_rp", 0)
            return { title = "Харизматичный ролеплеер", icon = yufu.mats.icons.MOOD_HAPPY_24, color = Color(100, 200, 255),
                desc = "Всего получено: " .. tostring(count)
            }
        end
    },
    pvp = {
        getData = function(ply)
            local count = ply:GetNWInt("yufu_pvp", 0)
            return { title = "Непобедимый механер", icon = yufu.mats.icons.BOLD_24, color = Color(255, 150, 100),
                desc = "Всего получено: " .. tostring(count)
            }
        end
    },
    money = {
        getData = function(ply)
            local money = ply:getDarkRPVar('money') or 0
            return { title = "Финансист", icon = yufu.mats.icons.COIN_YEN_24, color = Color(100, 255, 100),
                desc = "Денег: ¥" .. tostring(money)
            }
        end
    },
    coins = {
        getData = function(ply)
            local count = ply:GetNWInt("yufu_coins", 0)
            return { title = "Донатер", icon = yufu.mats.icons.COINS_24, color = Color(255, 215, 0),
                desc = "Койнов: " .. tostring(count)
            }
        end
    },
    cinema = {
        getData = function(ply)
            local count = ply:GetNWInt("yufu_cinema", 0)
            return { title = "Киноман", icon = yufu.mats.icons.MOVIE_24, color = Color(200, 100, 255),
                desc = "Видео: " .. tostring(count)
            }
        end
    },
    first_join = {
        getData = function(ply)
            local firstJoinTime = tonumber(ply:GetNWInt("yufu_first_join", 1640995200)) or 0

            if firstJoinTime == 0 or firstJoinTime < 1640995200 then
                firstJoinTime = os.time()
            end

            local joinYear = tonumber(os.date("%Y", firstJoinTime))

            local yearData = {
                {max = 2022, title = "Медаль 2022г", icon = yufu.mats.icons.MEDAL_24, color = Color(255, 215, 0)},
                {max = 2023, title = "Звезда 2023г", icon = yufu.mats.icons.STAR_24, color = Color(255, 165, 0)},
                {max = 2024, title = "Рубин 2024г", icon = yufu.mats.icons.DIAMOND_24, color = Color(220, 20, 60)},
                {max = 9999, title = "Грамота 2025г", icon = yufu.mats.icons.DIPLOMA_24, color = Color(50, 205, 50)}
            }

            local result = {icon = yufu.mats.icons.HEART_24, color = Color(150, 255, 150), title = "Ветеран", desc = "На сервере: ?"}

            if firstJoinTime > 0 then
                for _, data in ipairs(yearData) do
                    if joinYear <= data.max then
                        result.title, result.icon, result.color = data.title, data.icon, data.color
                        break
                    end
                end

                local daysOnServer = math.floor((os.time() - firstJoinTime) / 86400)
                if daysOnServer >= 365 then
                    local years = math.floor(daysOnServer / 365)
                    local days = daysOnServer % 365
                    result.desc = string.format("На сервере: %d %s %d %s",
                        years, years == 1 and "год" or (years >= 2 and years <= 4 and "года" or "лет"),
                        days, days == 1 and "день" or (days >= 2 and days <= 4 and "дня" or "дней")
                    )
                else
                    result.desc = string.format("На сервере: %d %s",
                        daysOnServer, daysOnServer == 1 and "день" or (daysOnServer >= 2 and daysOnServer <= 4 and "дня" or "дней")
                    )
                end
            end

            return result
        end
    },
    chess_elo = {
        getData = function(ply)
            local elo = ply:GetChessElo() or 0
            return { title = "Шахматист", icon = yufu.mats.icons.CHESS_KNIGHT_24, color = Color(150, 150, 255),
                desc = "ELO рейтинг: " .. tostring(elo)
            }
        end
    },
    draughts_elo = {
        getData = function(ply)
            local elo = ply:GetDraughtsElo() or 0
            return { title = "Шашист", icon = yufu.mats.icons.CIRCLE_24, color = Color(255, 150, 255),
                desc = "ELO рейтинг: " .. tostring(elo)
            }
        end
    },
    hidden = {
        getData = function(_)
            return { title = "Скрыто", icon = yufu.mats.icons.EYE_OFF_24, color = Color(100, 100, 100),
                desc = "Достижение скрыто"
            }
        end
    }
}

hook.Remove("ScoreboardShow", "FAdmin_scoreboard")
hook.Remove("ScoreboardHide", "FAdmin_scoreboard")

if GAMEMODE then
    function GAMEMODE:ScoreboardShow() end
    function GAMEMODE:ScoreboardHide() end
end

hook.Remove("ScoreboardShow", "yufu_scoreboard_show")
hook.Remove("ScoreboardHide", "yufu_scoreboard_hide")

yufu.gui.scoreboard = yufu.gui.scoreboard or {}

yufu.gui.scoreboard.columnsEnabled = yufu.gui.scoreboard.columnsEnabled or {
    voice = true, ping = true, kills = true, deaths = true, kd = true, group = true, dotane = true
}
yufu.gui.scoreboard.altSortingEnabled = yufu.gui.scoreboard.altSortingEnabled or false
yufu.gui.scoreboard.categoriesEnabled = yufu.gui.scoreboard.categoriesEnabled or {}

yufu.gui.scoreboard.panel = yufu.gui.scoreboard.panel or nil
yufu.gui.scoreboard.mini = nil

hook.Add("ScoreboardShow", "yufu.scoreboard.show", function()
    if IsValid(yufu.gui.scoreboard.panel) then
        yufu.gui.scoreboard.panel:Remove()
        yufu.gui.scoreboard.panel = nil
    end

    yufu.gui.scoreboard.panel = vgui.Create("YufuScoreboard")
end)
hook.Add("ScoreboardHide", "yufu.scoreboard.hide", function()
    if yufu.gui.scoreboard then
        if IsValid(yufu.gui.scoreboard.panel) then
            yufu.gui.scoreboard.panel:Remove()
            yufu.gui.scoreboard.panel = nil
        end

        if IsValid(yufu.gui.scoreboard.mini) then
            yufu.gui.scoreboard.mini:Remove()
            yufu.gui.scoreboard.mini = nil
        end
    end
end)