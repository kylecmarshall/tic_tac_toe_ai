
---@class wxDC_Module
---@field metatable wxDC
---@field BRUSHSTYLE_INVALID integer
---@field BRUSHSTYLE_SOLID integer
---@field BRUSHSTYLE_TRANSPARENT integer
---@field BRUSHSTYLE_STIPPLE_MASK_OPAQUE integer
---@field BRUSHSTYLE_STIPPLE_MASK integer
---@field BRUSHSTYLE_STIPPLE integer
---@field BRUSHSTYLE_BDIAGONAL_HATCH integer
---@field BRUSHSTYLE_CROSSDIAG_HATCH integer
---@field BRUSHSTYLE_FDIAGONAL_HATCH integer
---@field BRUSHSTYLE_CROSS_HATCH integer
---@field BRUSHSTYLE_HORIZONTAL_HATCH integer
---@field BRUSHSTYLE_VERTICAL_HATCH integer
---@field BRUSHSTYLE_FIRST_HATCH integer
---@field BRUSHSTYLE_LAST_HATCH integer
local M = {}
local aux, prv = {}, {}

local render_func = nil

local initialize = require "wxDC_prv"
initialize(aux, prv, M);

---@class wxDC
---@field private __lptr userdata
local wxDC = {}
wxDC.__index = wxDC

--allow access to the metatable
M.metatable = wxDC

local floor = math.floor

---@Draw text
---@param strText string
---@param x number
---@param y number
function wxDC:DrawText(strText, x, y)
    prv.DrawText(self.__lptr, strText, floor(x), floor(y))
end

---Draw line
---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
function wxDC:DrawLine(x1, y1, x2, y2)
    prv.DrawLine(self.__lptr, floor(x1), floor(y1), floor(x2), floor(y2))
end

---Draw circle
---@param x number
---@param y number
---@param radius number
function wxDC:DrawCircle(x, y, radius)
    prv.DrawCircle(self.__lptr, floor(x), floor(y), floor(radius))
end

---Draw rectangle
---@param x number
---@param y number
---@param width number
---@param height number
function wxDC:DrawRectangle(x, y, width, height)
    prv.DrawRectangle(self.__lptr, floor(x), floor(y), floor(width), floor(height))
end

function wxDC:SetBrush(tblBrush)
    if tblBrush.rgb and #tblBrush.rgb == 3 then
        tblBrush.red = tblBrush.rgb[1]
        tblBrush.green = tblBrush.rgb[2]
        tblBrush.blue = tblBrush.rgb[3]
    end
    tblBrush.red = tblBrush.red or 0
    tblBrush.green = tblBrush.green or 0
    tblBrush.blue = tblBrush.blue or 0
    tblBrush.alpha = tblBrush.alpha or 255
    tblBrush.style = tblBrush.style or M.BRUSHSTYLE_SOLID
    prv.SetBrush(self.__lptr, tblBrush.red, tblBrush.green, tblBrush.blue, tblBrush.alpha, tblBrush.style)
end

function wxDC:SetPen(tblPen)
    if tblPen.rgb and #tblPen.rgb == 3 then
        tblPen.red = tblPen.rgb[1]
        tblPen.green = tblPen.rgb[2]
        tblPen.blue = tblPen.rgb[3]
    end
    tblPen.red = tblPen.red or 0
    tblPen.green = tblPen.green or 0
    tblPen.blue = tblPen.blue or 0
    tblPen.alpha = tblPen.alpha or 255
    tblPen.width = tblPen.width or 1
    prv.SetPen(self.__lptr, tblPen.red, tblPen.green, tblPen.blue, tblPen.alpha, tblPen.width)
end

function wxDC:GetSize()
    local width, height = prv.GetSize(self.__lptr)
    return width, height
end

local Checkpoint

---Saves the current dc state and restores it
---when the checkpoint goes out of scope
---@class Checkpoint
---@field dc wxDC
---@field brush Brush
---@field pen Pen
---@overload fun(dc: wxDC): Checkpoint
Checkpoint = setmetatable({}, {
    ---Checkpoint constructor
    ---@param _ any
    ---@param dc wxDC
    __call = function(_, dc)
        ---@cast Checkpoint Checkpoint
        local checkpoint = setmetatable({
            --Checkpoint fields
            dc = dc,
            brush = dc:GetBrush(),
            pen = dc:GetPen()
        }, Checkpoint)
        return checkpoint
    end,
}
)

function Checkpoint:__close(err)
    self.dc:SetPen(self.pen)
    self.dc:SetBrush(self.brush)
end

---get checkpoint of current state
---@return Checkpoint
function wxDC:Checkpoint()
    return Checkpoint(self)
end

---@class Color
---@field red integer
---@field green integer
---@field blue integer
---@field rgb integer[]

---@class Brush : Color
---@field style integer

---@class Pen : Color
---@field width integer

---Get current pen
---@return Pen
function wxDC:GetPen()
    local r, g, b, w = prv.GetPen(self.__lptr)
    return { red = r, green = g, blue = b, width = w }
end

---Get current brush
---@return Brush
function wxDC:GetBrush()
    local r, g, b, s = prv.GetBrush(self.__lptr)
    return { red = r, green = g, blue = b, style = s }
end

---changes the color of the current pen
---without changing the width
---@param color integer[]
function wxDC:SetPenColor(color)
    local pen = self:GetPen()
    pen.red, pen.green, pen.blue = table.unpack(color)
    self:SetPen(pen)
end

local function wrap_wxDC_lptr(lptr_wxDC)
    local dc = setmetatable({ __lptr = lptr_wxDC }, wxDC)
    return dc
end

function aux.render(lptr_wxDC)
    local dc = wrap_wxDC_lptr(lptr_wxDC)
    assert(render_func, "render_func is nil")
    render_func(dc)
end 

function M.set_render_func(fn)
    render_func = fn
end

function M.refresh()
    prv.Refresh()
end

return M;