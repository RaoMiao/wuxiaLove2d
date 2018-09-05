---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by apple.
--- DateTime: 18/3/26 下午8:39
---
local Screen = require("lib/Screen")
local ScreenManager = require("lib/ScreenManager")
local assets = require("lib.cargo").init("assets")
local actorData = assets.data.actorDataNew
local NewScreen = {}
local bg = love.graphics.newImage("bg.jpeg")
--local font = love.graphics.newFont("assets/font/myfont.ttf", 24)
local font = assets.font.myfont(24)
local titlefont = assets.font.myfont(48)
--local titlefont = love.graphics.newFont("assets/font/myfont.ttf", 48)
local index = 1
local indexY = 1
local newActor = {}
newActor["gui"] = assets.gui.newGameGUI
local face
local moveImg
local fname,lname
function NewScreen.new()
    love.graphics.setFont(font)
    local self = Screen.new()
    local title = love.graphics.newText(titlefont, { { 0, 0, 0 }, "前世身份" })
    local t = love.graphics.newText(font)
    function self:draw()
        love.graphics.draw(bg, 0, 0, 0)
        love.graphics.setColor(0, 0, 0, 0.1)
        love.graphics.rectangle("fill", 90, 90, 400, 600, 8)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.rectangle("line", 90, 90, 400, 600, 8)

        for i, v in pairs(newActor.gui) do
            if v.prop and  v.prop == "faceImg" then
                face = assets.graphics.Faces[v.contant]
            end
            if v.prop and v.prop == "actorImg" then
                moveImg = assets.graphics.Characters[v.contant]
            end
            if i == index then
                v.color = { 1, 0, 0 }
            else
                v.color = { 1, 1, 1 }
            end
            t:set({ v.color, v.name .. "  " .. v.contant })
            love.graphics.draw(t, v.x,v.y)
            end
        --face = assets.graphics.Faces[1]
        if face ~= nil then
            --print(face)
            love.graphics.draw(face,380,120)
        end
        if moveImg ~= nil then
            love.graphics.draw(moveImg,260,240)
        end

        love.graphics.draw(title, 300, 40)
        love.graphics.setColor(1, 1, 1, 1)
    end

    function self:update(dt)

    end

    function self:keypressed(key)
        if key == "e" and index > 1 then
            index = index - 1
        elseif key == "d" and index < #newActor.gui then
            index = index + 1
        elseif key == "f" then
            local v = newActor.gui[index]
            if v.select then
                v.contant = v.select[math.random(#v.select)]
            end
        elseif key == "j" and newActor.gui[#newActor.gui].contant == "是" then
            player = Actor:new(actorData["XuZhu"])
            for i, v in pairs(newActor.gui) do
                if player[v.prop] then
                    if v.type == "int" then
                        player[v.prop] = tonumber(v.contant)
                    else
                        player[v.prop] = v.contant
                    end
                end

                if v.prop == "fname" then
                    fname = v.contant
                end
                if v.prop == "lname" then
                    lname = v.contant
                end

            end

            player["name"] = fname .. lname
            player:getAnims(player["actorImg"])
            ScreenManager.switch("game")
        end
    end
    return self
end
return NewScreen