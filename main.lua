function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")

    require("source/startup/startup")
    startup()

    
    local success, result = fileManager:open("C:/Users/inesh/OneDrive/Desktop/wuhan.lua")
    print(success)
    editor:open()

    --editor.tool = "colliders"
    --editor.panels:reloadColliders()

    --core.scale = 0.5
    --core.offsetX = 400
    --core.offsetY = 200

    --print(table.show(map))

    --editor.panels:reloadTextures()

    --editor.panels:texturePanelOpen(1)

    --colliders.targetIndex = 1

    --editor.panels:colliderPanelOpen(1)

    editor.tool = "layers"

    editor.panels:reloadLayers()
end

function love.update(dt)
    core:update(dt)

    inspector:update(dt)
end

function love.draw()
    core:draw()
end

function love.keypressed(key)
    core:keypressed(key)

    if key == "escape" then
        love.event.quit()
    elseif key == "f1" then
        print(table.show(map, "map"))
    elseif key == "f2" then
        print(table.show(map.layers, "map.layers"))
    elseif key == "space" then
        layers:reload()
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