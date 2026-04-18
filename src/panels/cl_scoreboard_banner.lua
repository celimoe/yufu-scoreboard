--- @class YufuScoreboardMiniProfileBanner : DPanel
--- @field SetCornerRadius fun(self: YufuScoreboardMiniProfileBanner, radius: number)
--- @field SetMaterial fun(self: YufuScoreboardMiniProfileBanner, mat: IMaterial?)
--- @field SetSolidColor fun(self: YufuScoreboardMiniProfileBanner, color: Color)
PANEL = {}

AccessorFunc(PANEL, "cornerRadius", "CornerRadius", FORCE_NUMBER)
AccessorFunc(PANEL, "material", "Material")
AccessorFunc(PANEL, "solidColor", "SolidColor")

function PANEL:Init()
    self.material = nil
    self.solidColor = Color(255, 255, 255)
    self.cornerRadius = 8

    self.poly = nil
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

function PANEL:DrawRounded(w, h)
    local poly = {}
    local radius = self.cornerRadius
    local segments = 16

    for i = 0, segments do
        local angle = math.rad(180 + (i / segments) * 90)
        poly[#poly + 1] = {
            x = radius + math.cos(angle) * radius,
            y = radius + math.sin(angle) * radius
        }
    end

    for i = 0, segments do
        local angle = math.rad(270 + (i / segments) * 90)
        poly[#poly + 1] = {
            x = w - radius + math.cos(angle) * radius,
            y = radius + math.sin(angle) * radius
        }
    end

    poly[#poly + 1] = {x = w, y = h}

    poly[#poly + 1] = {x = 0, y = h}

    return poly
end

function PANEL:OnSizeChanged(w, h)
    self.poly = self:DrawRounded(w, h)
end

function PANEL:Paint(w, h)
    if not self.poly then
        self.poly = self:DrawRounded(w, h)
    end

    self:PushMask(function()
        draw.NoTexture()
        surface.SetDrawColor(255, 255, 255)
        surface.DrawPoly(self.poly)
    end)

    if self.material then
        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(self.material)
        surface.DrawTexturedRect(0, 0, w, h)
    else
        surface.SetDrawColor(self.solidColor)
        surface.DrawRect(0, 0, w, h)
    end

    self:PopMask()
end

vgui.Register("YufuScoreboardMiniProfileBanner", PANEL, "DPanel")