local M = {}
local Transform

---@class Transform
---@field x number
---@field y number
---@field scale number
---@overload fun(tbl: { x:number, y:number, scale:number}): Transform
Transform = setmetatable({}, {
    -- Transform constructor
    __call = function(T, tbl)
        ---@cast Transform Transform
        local transform = setmetatable({},Transform)
        transform.x = tbl.x or 0
        transform.y = tbl.y or 0
        transform.scale = tbl.scale or 1
        return transform
    end
})
Transform.__index = Transform


function Transform:point(point)
    return  {   
                point[1]*self.scale + self.x,
                point[2]*self.scale + self.y
            }
end

function Transform:model(tblModel)
    local res = {}
    for name, point in pairs(tblModel) do
        res[name] = self:point(point)
    end
    return res
end

function Transform:transform(tf)
    local res = Transform(tf)
    res.x = res.x*self.scale + self.x
    res.y = res.y*self.scale + self.y
    res.scale = res.scale*self.scale
    return res
end

M.Transform = Transform

return M