--[[
    Implements SNES Mode 7 in Love2D
]]

if arg[#arg] == "-debug" then require("mobdebug").start() end    

-- https://github.com/Ulydev/push
push = require 'push'

-- the "Class" library we're using will allow us to represent anything in
-- our game as code, rather than keeping track of many disparate variables and
-- methods
--
-- https://github.com/vrld/hump/blob/master/class.lua
Class = require 'class'

require 'Matrix'
require 'mode7drawer'
require 'util'

-- physical screen dimensions
WINDOW_WIDTH = 640
WINDOW_HEIGHT = 480

-- virtual resolution dimensions
VIRTUAL_WIDTH = 256
VIRTUAL_HEIGHT = 224

local imageData = love.image.newImageData('F-ZeroMap01MuteCity1.png')

gFont = love.graphics.newFont('font.ttf', 16)
gAngle = 0
gX = 0

function love.load()
  
    love.graphics.setDefaultFilter('linear', 'nearest')
    
    -- initialize our virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    gX = gX + 5
    gPixels = Util.getPixels(imageData, 200 + gX, 550, 200, 100)
end

function love.draw()
    push:start()

    Mode7Drawer.render(gPixels, {x = 0, y = VIRTUAL_HEIGHT / 2 - 50}, 
        {x = 1.75, y = 1.25}, 
        {angle = gAngle}, {x = -0.5, y = 0})
    
    love.graphics.setFont(gFont)
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
    
    push:finish()
end
