layers = {}

function layers.load()
    for layerIndex, element in ipairs(map.layers) do
        local found = false

        if element.class == "texture" then
            for i, texture in ipairs(map.textures) do
                if element.index == i then
                    found = true
                    element.pointer = texture
                end
            end
        end

        if not found then
            table.remove(map.layers, layerIndex)
        end
    end
end

function layers:reload()
    local edited = false

    for layerIndex, element in ipairs(map.layers) do
        local found = false

        if element.class == "texture" then
            for i, texture in ipairs(map.textures) do
                if element.pointer == texture then
                    found = true
                    element.index = i
                end
            end
        end

        if not found then
            edited = true

            table.remove(map.layers, layerIndex)
        end
    end

    for i, texture in ipairs(map.textures) do
        local found = false

        for layerIndex, element in ipairs(map.layers) do
            if element.pointer == texture then
                found = true
                break
            end
        end

        if not found then
            edited = true

            table.insert(map.layers, {
                pointer = texture;
                index = i;
                class = "texture";
            })
        end
    end

    if edited then
        editor.panels:reloadLayers()
        print("edited layers")
        --print(table.show(map.layers, "map.layers"))
    end
end

function layers:update(dt)
    layers:reload()
end

function layers:draw()
end