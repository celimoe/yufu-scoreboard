--- @class YufuScoreboardAnimatedScrollPanel : DScrollPanel
--- @field SetScrollSpeed fun(self: YufuScoreboardAnimatedScrollPanel, speed: number)
--- @field SetScrollEasing fun(self: YufuScoreboardAnimatedScrollPanel, easing: function)
PANEL = {}

AccessorFunc(PANEL, "scrollSpeed", "ScrollSpeed", FORCE_NUMBER)
AccessorFunc(PANEL, "scrollEasing", "ScrollEasing")

function PANEL:Init()
    self.scrollSpeed = 0.4
    self.scrollEasing = yufu.tween.easing.outCirc

    self.targetScroll = 0
    self.currentScroll = 0
    self.scrollTween = nil

    local sbar = self:GetVBar()
    sbar:SetWide(0)
    sbar:SetHideButtons(true)
end

function PANEL:OnMouseWheeled(delta)
    local sbar = self:GetVBar()
    if not sbar then return end

    if not self.scrollTween then
        self.currentScroll = sbar:GetScroll()
    end

    local scrollAmount = delta * 100
    --- @diagnostic disable-next-line: undefined-field !fake!
    local maxScroll = sbar.CanvasSize or 0

    self.targetScroll = math.Clamp(self.currentScroll - scrollAmount, 0, maxScroll)

    self.scrollTween = yufu.tween.new(
        self.scrollSpeed, self,
        {currentScroll = self.targetScroll}, self.scrollEasing
    )

    return true
end

function PANEL:Think()
    local sbar = self:GetVBar()
    if not sbar then return end

    if self.scrollTween then
        local isComplete = self.scrollTween:update(FrameTime())
        sbar:SetScroll(self.currentScroll)

        if isComplete then
            self.scrollTween = nil
        end
    else
        self.currentScroll = sbar:GetScroll()
        self.targetScroll = self.currentScroll
    end
end

vgui.Register("YufuScoreboardAnimatedScrollPanel", PANEL, "DScrollPanel")