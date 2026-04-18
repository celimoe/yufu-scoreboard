--- @class YufuScoreboardVoiceSlider : DButton
--- @field SetPlayer fun(self: YufuScoreboardVoiceSlider, ply: Player)
PANEL = {}

AccessorFunc(PANEL, "player", "Player")

function PANEL:Init()
    self.player = nil
    self.volume = 1
    self.isDragging = false
    self.dragStartY = 0
    self.clickStartY = 0
    self.hasMoved = false

    self:SetSize(24, 24)
    self:SetText("")
end

function PANEL:SetPlayer(ply)
    self.player = ply
    if IsValid(ply) then
        self.volume = ply:GetVoiceVolumeScale() or 1
    end
end

function PANEL:Paint(w, h)
    draw.RoundedBox(4, 0, 0, w, h, yufu.colors.generic.LIGHTER)

    local fillHeight = (h - 4) * self.volume
    local fillY = h - fillHeight - 2

    if self.volume > 0 then
        draw.RoundedBox(4, 2, fillY, w - 4, fillHeight, yufu.colors.generic.LIGHTEST)
    end

    local icon = yufu.mats.icons.VOLUME_MAX_24
    if self.volume == 0 then
        icon = yufu.mats.icons.VOLUME_OFF_24
    elseif self.volume < 0.5 then
        icon = yufu.mats.icons.VOLUME_MID_24
    end

    surface.SetDrawColor(yufu.colors.generic.WHITE)
    surface.SetMaterial(icon)
    surface.DrawTexturedRect((w - 16) / 2, (h - 16) / 2, 16, 16)
end

function PANEL:OnMousePressed(key)
    if key ~= MOUSE_LEFT then return end
    self.isDragging = true
    self.hasMoved = false

    local _, my = self:CursorPos()
    self.dragStartY = my
    self.clickStartY = my

    self:MouseCapture(true)
end

function PANEL:OnMouseReleased(key)
    if key ~= MOUSE_LEFT or not self.isDragging then return end

    self.isDragging = false
    self:MouseCapture(false)

    if not self.hasMoved then
        self.volume = self.volume > 0 and 0 or 1
    end

    if IsValid(self.player) then
        self.player:SetVoiceVolumeScale(self.volume)
    end
end

function PANEL:Think()
    if not self.isDragging then return end

    local _, my = self:CursorPos()
    local delta = my - self.dragStartY

    if math.abs(my - self.clickStartY) > 3 then
        self.hasMoved = true
    end

    if self.hasMoved then
        local volumeDelta = -delta / self:GetTall()
        self.volume = math.Clamp(self.volume + volumeDelta, 0, 1)
        self.dragStartY = my

        if IsValid(self.player) and not self.player:IsBot() then
            self.player:SetVoiceVolumeScale(self.volume)
        end
    end
end

vgui.Register("YufuScoreboardVoiceSlider", PANEL, "DButton")