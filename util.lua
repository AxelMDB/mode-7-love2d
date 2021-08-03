Util = Class{}

function Util.getPixels(imageData, xOffset, yOffset, width, height)
    local pixels = Matrix(height, width)
    for y = 1, height do
        for x = 1, width do
            local red, green, blue = imageData:getPixel((x + xOffset), (y + yOffset))
            pixels.values[y][x] = {
                red = red,
                green = green,
                blue = blue
            }
        end
    end
    
    return pixels
end