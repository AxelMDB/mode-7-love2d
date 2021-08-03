Mode7Drawer = Class{}

function Mode7Drawer.render(pixels, transformMatrix, translateX, translateY)
    
    for y = 1, #pixels.values do
        local matrix = transformMatrix
        for x = 1, #pixels.values[y] do
            local r = Matrix(2, 1)
            r.values[1][1] = x 
            r.values[2][1] = y
            local r1 = Matrix.Multiply(matrix, r)
            love.graphics.setColor(pixels.values[y][x].red, pixels.values[y][x].blue, pixels.values[y][x].green)
            love.graphics.points(r1.values[1][1] + translateX, r1.values[2][1] + translateY)
        end
    end
end