--- @class YufuScoreboardCircledButton : DButton
--- @field SetIcon fun(self:YufuScoreboardCircledButton, icon:IMaterial)
--- @field SetRadius fun(self:YufuScoreboardCircledButton, radius:number)
--- @field SetColor fun(self:YufuScoreboardCircledButton, color:Color)
--- @field SetHoverColor fun(self:YufuScoreboardCircledButton, hoverColor:Color)
--- @field SetOutlineColor fun(self:YufuScoreboardCircledButton, outlineColor:Color)
--- @field DoClick fun(self:YufuScoreboardCircledButton)
PANEL = {}

AccessorFunc(PANEL, "icon", "Icon")
AccessorFunc(PANEL, "radius", "Radius", FORCE_NUMBER)
AccessorFunc(PANEL, "color", "Color", FORCE_COLOR)
AccessorFunc(PANEL, "hoverColor", "HoverColor", FORCE_COLOR)
AccessorFunc(PANEL, "outlineColor", "OutlineColor", FORCE_COLOR)

function PANEL:Init()
    self:SetText("")

    self.radius = 20
    self.segments = 32
    self.icon = yufu.mats.icons.CROSS_24

    self.color = yufu.colors.generic.LIGHTER
    self.hoverColor = yufu.colors.generic.MAGENTA
    self.outlineColor = yufu.colors.generic.LIGHTERER

    self.currentColor = Color(self.color.r, self.color.g, self.color.b, self.color.a)
    self.currentOutlineColor = Color(self.outlineColor.r, self.outlineColor.g, self.outlineColor.b, self.outlineColor.a)

    self.hoverTween = nil

    self:GenerateCircleVertices()
end

function PANEL:SetColor(color)
    self.color = color
    self.currentColor = Color(color.r, color.g, color.b, color.a)
end

function PANEL:SetOutlineColor(outlineColor)
    self.outlineColor = outlineColor
    self.currentOutlineColor = Color(outlineColor.r, outlineColor.g, outlineColor.b, outlineColor.a)
end

function PANEL:GenerateCircleVertices()
    self.circleVertices = {}
    table.insert(self.circleVertices, { x = 0, y = 0, u = 0.5, v = 0.5 })

    for i = 0, self.segments do
        local a = math.rad((i / self.segments) * -360)
        table.insert(self.circleVertices, {
            x = math.sin(a) * self.radius,
            y = math.cos(a) * self.radius,
            u = math.sin(a) / 2 + 0.5,
            v = math.cos(a) / 2 + 0.5
        })
    end

    local a = math.rad(0)
    table.insert(self.circleVertices, {
        x = math.sin(a) * self.radius,
        y = math.cos(a) * self.radius,
        u = math.sin(a) / 2 + 0.5,
        v = math.cos(a) / 2 + 0.5
    })
end

function PANEL:SetRadius(radius)
    self.radius = radius
    self:GenerateCircleVertices()
end

function PANEL:DrawCircle(x, y)
    local transformedCir = {}
    for i, v in ipairs(self.circleVertices) do
        transformedCir[i] = {
            x = x + v.x,
            y = y + v.y,
            u = v.u,
            v = v.v
        }
    end

    surface.DrawPoly(transformedCir)
end

function PANEL:Paint(w, h)
    draw.NoTexture()
    surface.SetDrawColor(self.currentColor)
    self:DrawCircle(w / 2, h / 2)
    surface.DrawCircle(w / 2, h / 2, self.radius, self.currentOutlineColor)

    local iconSize = self.radius
    local centerX = w / 2
    local centerY = h / 2

    surface.SetDrawColor(Color(255, 255, 255, 255))
    surface.SetMaterial(self.icon)
    surface.DrawTexturedRect(centerX - iconSize / 2, centerY - iconSize / 2, iconSize, iconSize)
end

function PANEL:Think()
    if self.hoverTween then
        local isComplete = self.hoverTween:update(FrameTime())
        if isComplete then
            self.hoverTween = nil
        end
    end
end

function PANEL:OnCursorEntered()
    self.hoverTween = yufu.tween.new(0.2, self, { currentColor = self.hoverColor, currentOutlineColor = self.hoverColor }, yufu.tween.easing.outQuad)
end

function PANEL:OnCursorExited()
    self.hoverTween = yufu.tween.new(0.2, self, { currentColor = self.color, currentOutlineColor = self.outlineColor }, yufu.tween.easing.outQuad)
end

function PANEL:DoClick() end

vgui.Register("YufuScoreboardCircledButton", PANEL, "DButton")