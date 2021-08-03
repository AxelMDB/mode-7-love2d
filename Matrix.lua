Matrix = Class{}

function Matrix:init(height, width)
    self.values = {}
    
    self.rows = height
    self.columns = width 
    
    for y = 1, height do
        table.insert(self.values, {})
        for x = 1, width do
            table.insert(self.values[y], 0)
        end    
    end
  
end

function Matrix:printAll(xs, ys)
    for y = 1, #self.values do
        for x = 1, #self.values[y] do
            if self.values[y][x] ~= nil then
                love.graphics.setColor(255, 255, 255)
                love.graphics.setFont(gFont)
                love.graphics.print(self.values[y][x], (x - 1) * 32 + xs, (y - 1) * 16 + ys)
            end
        end
    end
end
function Matrix.Add(matrix1, matrix2)
    --assert both matrices have the same number of rows
    if matrix1.rows ~= matrix2.rows or matrix1.columns ~= matrix2.columns then return nil end
    
    local newMatrix = Matrix(matrix1.rows, matrix1.columns)
     
    for y = 1, matrix1.rows do
        for x = 1, matrix1.columns do
            newMatrix.values[y][x] = matrix1.values[y][x] + matrix2.values[y][x]
        end
    end
    return newMatrix
end

function Matrix.Substract(matrix1, matrix2)
    --assert both matrices have the same number of rows
    if matrix1.rows ~= matrix2.rows or matrix1.columns ~= matrix2.columns then return nil end
    
    local newMatrix = Matrix(matrix1.rows, matrix1.columns)
     
    for y = 1, matrix1.rows do
        for x = 1, matrix1.columns do
            newMatrix.values[y][x] = matrix1.values[y][x] - matrix2.values[y][x]
        end
    end
    return newMatrix
end

function Matrix.Multiply(matrix1, matrix2)
    if matrix1.columns ~= matrix2.rows then return nil end
    
    newMatrix = Matrix(matrix1.rows, matrix2.columns)
    
    local row = 1
    local column = 1
    for y = 1, matrix1.rows do
        for x2 = 1, matrix2.columns do
            local sum = 0
            for x = 1, matrix1.columns do
                sum = sum + matrix1.values[y][x] * matrix2.values[x][x2]
            end
            newMatrix.values[row][column] = sum
            column = column + 1
        end
        column = 1
        row = row + 1
    end
    
    return newMatrix
end