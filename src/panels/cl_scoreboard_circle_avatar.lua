--- @class YufuScoreboardMiniProfileCircledAvatar : AvatarImage
--- @field SetPlayer fun(self: YufuScoreboardMiniProfileCircledAvatar, pl: Player, size: number)
PANEL = {}

function PANEL:Init()
    self.base = vgui.Create("AvatarImage", self)
    self.base:Dock(FILL)
    self.base:SetPaintedManually(true)

    self.poly = nil
end

function PANEL:GetBase()
    return self.base
end

function PANEL:PushMask(mask)
    render.ClearStencil()
    render.SetStencilEnable(true)

    render.SetStencilWriteMask(1)
    render.SetStencilTestMask(1)

    render.SetStencilFailOperation(STENCILOPERATION_REPLACE)
    render.SetStencilPassOperation(STENCILOPERATION_ZERO)
    render.SetStencilZFailOperation(STENCILOPERATION_ZERO)
    render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_NEVER)
    render.SetStencilReferenceValue(1)

    mask()

    render.SetStencilFailOperation(STENCILOPERATION_ZERO)
    render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
    render.SetStencilZFailOperation(STENCILOPERATION_ZERO)
    render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
    render.SetStencilReferenceValue(1)
end

function PANEL:PopMask()
    render.SetStencilEnable(false)
    render.ClearStencil()
end

function PANEL:DrawCirclePoly(w, h)
    local poly = {}

    local x, y = w / 2, h / 2
    for angle = 1, 360 do
        local radAngle = math.rad(angle)

        local cosVal = math.cos(radAngle) * y
        local sinVal = math.sin(radAngle) * y

        poly[#poly + 1] = {
            x = x + cosVal,
            y = y + sinVal
        }
    end

    return poly
end

function PANEL:OnSizeChanged(w, h)
    self.poly = self:DrawCirclePoly(w, h)
end

function PANEL:Paint(w, h)
    self:PushMask(function()
        draw.NoTexture()
        surface.SetDrawColor(255, 255, 255)
        surface.DrawPoly(self.poly)
    end)

    self.base:PaintManual()

    self:PopMask()
end

function PANEL:SetPlayer(pl, size)
    self.base:SetPlayer(pl, size)
end

vgui.Register("YufuScoreboardMiniProfileCircledAvatar", PANEL) -- https://gist.github.com/chmilhane/ddd3e9adaa3e837db1d7fb71bd8768eb