--- @class YufuScoreboardRippleButton : DPanel
--- @field SetIcon fun(self: YufuScoreboardRippleButton, icon: IMaterial)
--- @field SetIconColor fun(self: YufuScoreboardRippleButton, color: Color)
--- @field SetValue fun(self: YufuScoreboardRippleButton, value: function)
PANEL = {}

AccessorFunc(PANEL, "icon", "Icon")
AccessorFunc(PANEL, "value", "Value")

function PANEL:Init()
    self:SetText("")
    self.icon = yufu.mats.icons.HEART_24
    self.iconColor = yufu.colors.generic.PINK
    self.valueColor = yufu.colors.generic.WHITE
    self.value = nil

    self.ripples = {}
    self.hoverTween = nil
end

function PANEL:SetIconColor(color)
    self.iconColor = Color(color.r, color.g, color.b, 0)
    self.valueColor = color
end

function PANEL:Paint(w, h)
    if self.iconColor.a > 0 then
        draw.RoundedBox(6, 0, 0, w, h, self.iconColor)
    end

    for i = #self.ripples, 1, -1 do
        local ripple = self.ripples[i]
        if ripple.progress >= 1 then
            table.remove(self.ripples, i)
        else
            local size = ripple.maxSize * ripple.progress
            local alpha = 255 * (1 - ripple.progress) * 0.3

            local rippleX = math.max(0, math.min(ripple.x - size / 2, w))
            local rippleY = math.max(0, math.min(ripple.y - size / 2, h))
            local rippleW = math.min(size, w - rippleX)
            local rippleH = math.min(size, h - rippleY)

            if rippleW > 0 and rippleH > 0 then
                draw.RoundedBox(
                    6,
                    rippleX,
                    rippleY,
                    rippleW,
                    rippleH,
                    Color(self.iconColor.r, self.iconColor.g, self.iconColor.b, alpha)
                )
            end
        end
    end

    local col = self:IsHovered() and self.valueColor or yufu.colors.generic.WHITE
    surface.SetMaterial(self.icon)
    surface.SetDrawColor(col)
    surface.DrawTexturedRect(8, (h - 20) / 2, 20, 20)

    local value = self.value and self.value() or 0
    draw.SimpleText(tostring(value), "yufu_scoreboard_body",
        (w + 26) / 2, h / 2, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER
    )
end

function PANEL:Think()
    if self.hoverTween then
        local isComplete = self.hoverTween:update(FrameTime())
        if isComplete then
            self.hoverTween = nil
        end
    end

    for _, ripple in ipairs(self.ripples) do
        if ripple.tween then
            ripple.tween:update(FrameTime())
        end
    end
end

function PANEL:OnCursorEntered()
    self.hoverTween = yufu.tween.new(0.5, self, {iconColor = Color(self.iconColor.r, self.iconColor.g, self.iconColor.b, 20)}, yufu.tween.easing.outExpo)
end

function PANEL:OnCursorExited()
    self.hoverTween = yufu.tween.new(0.5, self, {iconColor = Color(self.iconColor.r, self.iconColor.g, self.iconColor.b, 0)}, yufu.tween.easing.outExpo)
end

function PANEL:CreateRipple()
    local w, h = self:GetSize()
    local mouseX, mouseY = self:CursorPos()

    local ripple = {
        x = mouseX or w / 2,
        y = mouseY or h / 2,
        progress = 0,
        maxSize = math.max(w, h) * 1.5
    }
    ripple.tween = yufu.tween.new(1, ripple, {progress = 1}, yufu.tween.easing.outCirc)

    table.insert(self.ripples, ripple)
end

function PANEL:OnMousePressed(keyCode)
    if keyCode == MOUSE_LEFT then
        self:CreateRipple()
        self:DoClick()
    end
end

function PANEL:DoClick() end

vgui.Register("YufuScoreboardRippleButton", PANEL, "DPanel")