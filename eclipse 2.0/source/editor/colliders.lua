colliders = {}

colliders.targetClass = nil

colliders.drawing = false
colliders.selectX = 0
colliders.selectY = 0
colliders.selectStartX = 0
colliders.selectStartY = 0
colliders.selectWidth = 0
colliders.selectHeight = 0
colliders.snapToGrid = true

colliders.gridMultiple = 100

local function roundToGrid(num)
    return (math.floor(num / colliders.gridMultiple) * colliders.gridMultiple) / colliders.gridMultiple
end

function colliders:new(x, y, width, height, class)
    local collider = {}
    collider.x = x
    collider.y = y
    collider.width = width
    collider.height = height

    table.insert(map.colliders[class], collider)
end

function colliders:newClass(name)
    map.colliders[name] = {}
    map.colliders[name].color = {1, 1, 1}
end

function colliders:update(dt)
    local mx, my = core:getMousePosition()
    mx, my = cam:getCamPosition(mx, my)

    if colliders.drawing then
        if colliders.snapToGrid then
            local gridX, gridY = roundToGrid(mx), roundToGrid(my)

            local startX = math.min(gridX, roundToGrid(colliders.selectStartX))
            local startY = math.min(gridY, roundToGrid(colliders.selectStartY))
            local endX = math.max(gridX, roundToGrid(colliders.selectStartX))
            local endY = math.max(gridY, roundToGrid(colliders.selectStartY))

            colliders.selectX = startX * colliders.gridMultiple
            colliders.selectY = startY * colliders.gridMultiple
            colliders.selectWidth = ((endX + 1) - startX) * colliders.gridMultiple
            colliders.selectHeight = ((endY + 1) - startY) * colliders.gridMultiple
        else
            colliders.selectX = math.min(colliders.selectStartX, mx)
            colliders.selectY = math.min(colliders.selectStartY, my)
            colliders.selectWidth = math.abs(colliders.selectStartX - mx)
            colliders.selectHeight = math.abs(colliders.selectStartY - my)
        end
    end
end

function colliders:draw()
    for i, class in pairs(map.colliders) do
        if not class.hide then
            love.graphics.setColor(class.color)
            for i, collider in ipairs(class) do
                love.graphics.rectangle("line", collider.x, collider.y, collider.width, collider.height)
            end
        end
    end

    love.graphics.setColor(1, 1, 1, 0.5)
    love.graphics.rectangle("fill", colliders.selectX, colliders.selectY, colliders.selectWidth, colliders.selectHeight)
end

function colliders:mousepressed(x, y, button)
    if editor.tool ~= "collider" or button ~= 1 or colliders.targetClass == nil then
        return
    end

    local mx, my = core:getMousePosition()
    mx, my = cam:getCamPosition(mx, my)

    colliders.drawing = true
    colliders.selectStartX = mx
    colliders.selectStartY = my
end

function colliders:mousereleased(x, y, button)
    if editor.tool ~= "collider" or button ~= 1 or colliders.drawing == false then
        return
    end

    colliders.drawing = false

    colliders:new(colliders.selectX, colliders.selectY, colliders.selectWidth, colliders.selectHeight, colliders.targetClass)

    colliders.selectX = 0
    colliders.selectY = 0
    colliders.selectStartX = 0
    colliders.selectStartY = 0
    colliders.selectWidth = 0
    colliders.selectHeight = 0
end