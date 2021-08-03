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

gTransformX = -20
gTransformY = VIRTUAL_HEIGHT - 10
gAngle = math.rad(270)
gSkew = 0
currentPixel = 0

function love.load()
  
    love.graphics.setDefaultFilter('nearest', 'nearest')
    
    -- initialize our virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })
    
    gPixels = Util.getPixels(imageData, 2396, 437, 100, 190)
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
      currentPixel = currentPixel + 10
      gPixels = Util.getPixels(imageData, 2100 + currentPixel, 410, 100, 250)
end

function love.draw()
    push:start()
    
    rotationMatrix = Matrix(2,2)
    rotationMatrix.values[1][1] = math.cos(gAngle)
    rotationMatrix.values[1][2] = -math.sin(gAngle)
    rotationMatrix.values[2][1] = math.sin(gAngle)
    rotationMatrix.values[2][2] = math.cos(gAngle)
    
    scaleMatrix = Matrix(2,2)
    scaleMatrix.values[1][1] = 1
    scaleMatrix.values[1][2] = 0
    scaleMatrix.values[2][1] = 0
    scaleMatrix.values[2][2] = 0.5
    
    shearMatrix = Matrix(2,2)
    shearMatrix.values[1][1] = 1
    shearMatrix.values[1][2] = 0
    shearMatrix.values[2][1] = 0.7
    shearMatrix.values[2][2] = 1
    
    transformMatrix = Matrix.Multiply(scaleMatrix, rotationMatrix)
    transformMatrix = Matrix.Multiply(transformMatrix, shearMatrix)
    
    Mode7Drawer.render(gPixels, transformMatrix, gTransformX, gTransformY, true)
    
    love.graphics.setFont(gFont)
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
    
    push:finish()
end
