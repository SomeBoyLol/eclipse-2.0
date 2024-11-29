fileManager = {}

function fileManager:create(args)
    map = {}
    map.name = args.name or "map"
    map.directory = args.directory.."/"..map.name..".lua"
    map.colliders = {}
end

function fileManager:open(directory)

    -- checks if file directory ends with .lua and if not it adds that
    if not(string.match(directory, "%.lua$") == ".lua") then
        directory = directory..".lua"
    end

    local success, result = pcall(function()
        local file = io.open(directory, "r")

        if file then
            local mapData = file:read("*all")
            file:close()

            local chunk, errorMessage = load(mapData)

            map = {}
            map = chunk()
        else
            error("Couldn't find directory: "..directory)
        end
    end)

    return success, result
end

function fileManager:save(args)
    local file = io.open(map.directory, "w")

    file:write("local map = {}\n\n")

    file:write('map.name = "'..map.name..'"\n')
    file:write('map.directory = "'..map.directory..'"\n\n')
    file:write("map.colliders = {\n")

    for className, class in pairs(map.colliders) do
        file:write('    ["'..className..'"] = {\n')
        file:write("        color = {"..class.color[1]..", "..class.color[2]..", "..class.color[3].."};\n")
        file:write("        hide = "..tostring(class.hide)..";\n")

        for i, collider in ipairs(class) do
            file:write("        {x = "..collider.x.."; y = "..collider.y.."; width = "..collider.width.."; height = "..collider.height..";};\n")
        end

        file:write("    };\n")
    end

    file:write("}\n\n")
    file:write("return map")
end