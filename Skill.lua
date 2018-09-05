---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by apple.
--- DateTime: 2018/8/22 下午11:50
---
require("lib.animation")

Skill = Class("Skill",GameObject)

local function readdata(datafile,object)
    local dataTable = require("assets.data." .. datafile)
    local data = dataTable[object.id]
    for k, v in pairs(data) do
        object[k] = v
    end
    -- return data
end

function Skill:init(x,y,opts)
    GameObject.init(self,x,y,opts)
    readdata("skills",self)
end



function Skill:draw()

end
