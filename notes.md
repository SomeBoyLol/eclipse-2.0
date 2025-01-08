### clean up gui code please especially for panels!!!!!!!!!

### CRASHES

    if key == "escape" then
        love.event.quit()
    elseif key == "f11" then
        love.window.setFullscreen(not(love.window:getFullscreen()))
        core:resize()
    elseif key == "f8" then
        print(table.show(map))
    elseif key == "f7" then
        textures.load()
    elseif key == "f6" then
        local ffi = require("ffi")
        ffi.cast("void (*)()", 0)()
    elseif key == "f5" then
        function crash()
            crash()
        end
        crash()
    elseif key == "f4" then
        local invalidImage = love.graphics.newImage("nonexistent_file.png")
    elseif key == "f3" then
        os.exit()

    end






function layers:rah()
    local edited = false

    print(table.show(map.textures, "map.textures"))
    print(table.show(map.layers, "map.layers"))

    for layerIndex = #map.layers, 1, -1 do
        print(layerIndex)
        local element = map.layers[layerIndex]
        local found = false

        if element.class == "texture" then
            if map.textures[element.index] ~= nil then
                found = true
                print("found "..layerIndex.."    at "..element.index)
            end
        end

        if not found then
            print("destroying "..layerIndex)
            table.remove(map.layers, layerIndex)
            edited = true
        end
    end

    for i, texture in ipairs(map.textures) do
        local found = false

        for layerIndex, element in ipairs(map.layers) do
            if element.class == "texture" and element.index == i then
                found = true
                break
            end
        end

        if not found then
            table.insert(map.layers, {
                name = texture.name;
                index = i;
                class = "texture";
            })
            edited = true
        end
    end

    if edited then
        editor.panels:reloadLayers()
        print(table.show(map.layers, "map.layers"))
    end
end