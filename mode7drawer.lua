Mode7Drawer = Class{}

function Mode7Drawer.render(pixels, translation, scale, rotation, shear)
    
    local t1 = { 
        a = scale.x * math.cos(math.rad(rotation.angle)),
        b = scale.x * math.sin(math.rad(rotation.angle)),
        c = scale.y * -math.sin(math.rad(rotation.angle)),
        d = scale.y * math.cos(math.rad(rotation.angle))
    }
    
    local t2 = {
        a = t1.a + t1.b * shear.y,
        b = t1.a * shear.x + t1.b,
        c = t1.c + t1.d * shear.y,
        d = t1.c * shear.x + t1.d
    }
    
    for y = 1, #pixels.values do
          for x = 1, #pixels.values[y] do
              local r1 = {
                  x = (t2.a * x + t2.b * y) + translation.x,
                  y = (t2.c * x + t2.d * y) + translation.y
              }
              love.graphics.setColor(pixels.values[y][x].red, pixels.values[y][x].blue, pixels.values[y][x].green)
              love.graphics.rectangle('fill', r1.x, r1.y, 1 * scale.x, 1 * scale.y)
          end
      end
end