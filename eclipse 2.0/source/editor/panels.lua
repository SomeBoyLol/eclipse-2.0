editor.panels = {}

editor.panels.hover = false
editor.panels.editing = false

local colliderPanel = gui:create("frame", {
    text = "";
    color = editorGUI.tertiaryColor;
    alignmentX = "right";
    alignmentY = "center";
    x = -40;
    width = 400;
    height = 700
})

colliderPanel.top = gui:create("frame", {text = "Colliders", font = fonts.medium, textAlignmentX = "left", textMargin = 20, width = 400, height = 75, color = editorGUI.primaryColor})

gui:style({{font = fonts.small, textAlignmentX = "left", color = editorGUI.secondaryColor, hoverColor = {0.3, 0.3, 0.3, 0.5}, editColor = {0.3, 0.3, 0.3, 0.5}}})

colliderPanel.targetClass = gui:create("frame", {text = "Selected: goo goo ga ga", color = {1, 0, 0, 0}, textMargin = 20, y = 75, width = 400, height = 50})
colliderPanel.classColor = gui:create("frame", {text = "Color:", color = {1, 0, 0, 0}, x = 20, y = 125, width = 80, height = 50})

local function classColor(self)
    if colliders.targetClass == nil then
        return
    end

    if self.text ~= tostring(tonumber(self.text)) then
        return
    end

    local textNum = tonumber(self.text)

    if textNum < 0 then
        textNum = 0
    elseif textNum > 255 then
        textNum = 255
    end

    map.colliders[colliders.targetClass].color[self.num] = textNum / 255
end

colliderPanel.classColor1 = gui:create("input", {text = "255", x = 110, y = 130, width = 60, height = 40, textAlignmentX = "center", func = classColor})
colliderPanel.classColor1.num = 1
colliderPanel.classColor2 = gui:create("input", {text = "255", x = 180, y = 130, width = 60, height = 40, textAlignmentX = "center", func = classColor})
colliderPanel.classColor2.num = 2
colliderPanel.classColor3 = gui:create("input", {text = "255", x = 250, y = 130, width = 60, height = 40, textAlignmentX = "center", func = classColor})
colliderPanel.classColor3.num = 3

colliderPanel.newClassInput = gui:create("input", {text = "", textMargin = 10, x = 10, y = 180, width = 330, height = 40})
colliderPanel.newClass = gui:create("button", {text = "+", x = 350, y = 180, width = 40, height = 40, font = 30, textAlignmentX = "center"})

colliderPanel.list = gui:create("frame", {text = "", x = 10, y = 230, width = 380, height = 400, color = {1, 0, 0, 1}})
colliderPanel.pageDisplay = gui:create("frame", {text = "99/99", alignmentX = "center", alignmentY = "bottom", textAlignmentX = "center", y = -10, width = 100, height = 50})
colliderPanel.pageLeft = gui:create("button", {font = fonts.medium, text = "<", x = -85, alignmentX = "center", alignmentY = "bottom", textAlignmentX = "center", y = -10, width = 50, height = 50})
colliderPanel.pageRight = gui:create("button", {font = fonts.medium, text = ">", x = 85, alignmentX = "center", alignmentY = "bottom", textAlignmentX = "center", y = -10, width = 50, height = 50})

function editor.panels:reloadColliders(page)
    colliderPanel.targetClass.text = "Selected: "..tostring(colliders.targetClass)

    if colliders.targetClass ~= nil then
        colliderPanel.classColor1.text = math.round(map.colliders[colliders.targetClass].color[1] * 255)
        colliderPanel.classColor2.text = math.round(map.colliders[colliders.targetClass].color[2] * 255)
        colliderPanel.classColor3.text = math.round(map.colliders[colliders.targetClass].color[3] * 255)
    end

    gui:style({{font = fonts.small, textAlignmentX = "left", color = editorGUI.secondaryColor, hoverColor = {0.3, 0.3, 0.3, 0.5}, editColor = {0.3, 0.3, 0.3, 0.5}}})
    colliderPanel.list = gui:create("frame", {text = "", x = 10, y = 230, width = 380, height = 400, color = {1, 0, 0, 0}})

    local index = 0

    for className, class in pairs(map.colliders) do
        if type(class) == "table" then
            local button = gui:create("button", {text = className, textMargin = 10, x = 0, y = 50 * index, width = 340, height = 40, func = function()
                colliders.targetClass = className
                editor.panels:reloadColliders()
            end})

            if className == colliders.targetClass then
                button.normalColor = {0.3, 0.3, 0.3, 0.5}
            end

            local hideButton = gui:create("button", {text = "", x = 340, y = 50 * index, width = 40, height = 40, func = function(self)
                class.hide = not(class.hide)
                
                if class.hide then
                    self.icon.source = sprites.eyeOpen
                else
                    self.icon.source = sprites.eyeClose
                end
            end})
            if class.hide then
                hideButton.icon = gui:create("image", {source = sprites.eyeOpen, scale = 0.8})
            else
                hideButton.icon = gui:create("image", {source = sprites.eyeClose, scale = 0.8})
            end
            table.insert(colliderPanel.list, hideButton)

            colliderPanel.list["class "..className] = button
            index = index + 1
        end
    end
end


local imagePanel = gui:create("frame", {
    text = "";
    color = editorGUI.secondaryColor;
    alignmentX = "right";
    alignmentY = "center";
    x = -40;
    width = 400;
    height = 700
})

imagePanel.top = gui:create("frame", {text = "Images", font = fonts.medium, textAlignmentX = "left", textMargin = 20, width = 400, height = 75, color = editorGUI.primaryColor})



editor.gui.panel = imagePanel

function editor.panels:update(dt)
    if editor.tool == "collider" then
        editor.gui.panel = colliderPanel
    elseif editor.tool == "image" then
        editor.gui.panel = imagePanel
    end

    local mx, my = core:getMousePosition()

    --check if mouse is on panel
    local panel = editor.gui.panel
    editor.panels.hover = mx > panel.screenX and mx < panel.screenX + panel.width and my > panel.screenY and my < panel.screenY + panel.height

    --checks if your editing any text inputs
    editor.panels.editing = false
    for i, element in ipairs(panel.children) do
        if element.class == "input" and element.edit then
            editor.panels.editing = true
        end
    end
end