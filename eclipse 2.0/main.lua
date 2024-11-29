function love.load()
    require("source/startup/startup")
    startup()

    editor:open()

    --fileManager:create({directory = "C:/Users/inesh/OneDrive/Desktop", name = "wuhan"})

    --fileManager:save()

    success, result = fileManager:open("C:/Users/inesh/OneDrive/Desktop/wuhan.lua")

    if not success then
        print("ERROR", result)
    end

    --colliders:newClass("edp")
    --colliders:newClass("that guy")
    --colliders:new(100, 100, 50, 50, "ground")

    --colliders.targetClass = "ground"

    --core.scale = 0.5
    --core.offsetX = 400
    --core.offsetY = 200

    editor.panels:reloadColliders()
end

function love.update(dt)
    core:update(dt)
end

function love.draw()
    core:draw()
end

function love.keypressed(key)
    core:keypressed(key)

    if key == "escape" then
        love.event.quit()
    elseif key == "f11" then
        love.window.setFullscreen(not(love.window:getFullscreen()))
        core:resize()
    elseif key == "f8" then
        print(table.show(map))
    end
end

function love.mousepressed(x, y, button)
    core:mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
    core:mousereleased(x, y, button)
end

function love.resize()
    core:resize()
end

function love.textinput(t)
    core:textinput(t)
end

function love.wheelmoved(x, y)
    core:wheelmoved(x, y)
end