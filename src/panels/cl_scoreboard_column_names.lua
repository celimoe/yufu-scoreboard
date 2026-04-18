--- @class YufuScoreboardColumnNames : DPanel
--- @field SetColumns fun(self: YufuScoreboardColumnNames, columns: table)
PANEL = {}

AccessorFunc(PANEL, "columns", "Columns")

function PANEL:Init()
    self:SetBackgroundColor(yufu.colors.generic.EMPTY)
    self.columns = {}
end

function PANEL:SetColumns(columns)
    self.columns = columns
    self:CreateHeaders()
end

function PANEL:CreateHeaders()
    for _, child in ipairs(self:GetChildren()) do
        child:Remove()
    end

    for _, col in ipairs(self.columns) do
        if yufu.gui.scoreboard.columnsEnabled[col.id] then
            local header = self:Add("DLabel")
            header:SetText(col.header)
            header:SetFont("yufu_scoreboard_captionSemiBold")
            header:SetTextColor(col.headerColor or yufu.colors.generic.GRAY)
            header:SetContentAlignment(5)
            header:Dock(RIGHT)
            header:SetWide(col.width)
        end
    end
end

function PANEL:Paint(_, _) end

vgui.Register("YufuScoreboardColumnNames", PANEL, "DPanel")