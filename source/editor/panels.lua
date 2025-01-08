editor.panels = {}

editor.panels.hover = false
editor.panels.editing = false

local collidersPanel = require("source/editor/colliders/collidersPanel")
local colliderPanel = require("source/editor/colliders/colliderPanel")
local texturesPanel = require("source/editor/textures/texturesPanel")
local texturePanel = require("source/editor/textures/texturePanel")
local spritePanel = require("source/editor/sprites/spritePanel")
local imagesPanel = require("source/editor/images/imagesPanel")
local imagePanel = require("source/editor/images/imagePanel")
local newImagePanel = require("source/editor/images/newImagePanel")
local layersPanel = require("source/editor/layers/layersPanel")

editor.gui.panel = texturePanel

function editor.panels:update(dt)
    if editor.tool == "colliders" then
        editor.gui.panel = collidersPanel
    elseif editor.tool == "collider" then
        editor.gui.panel = colliderPanel
    elseif editor.tool == "textures" then
        editor.gui.panel = texturesPanel
    elseif editor.tool == "texture" then
        editor.gui.panel = texturePanel
    elseif editor.tool == "sprite" then
        editor.gui.panel = spritePanel
    elseif editor.tool == "images" then
        editor.gui.panel = imagesPanel
    elseif editor.tool == "image" then
        editor.gui.panel = imagePanel
    elseif editor.tool == "newImage" then
        editor.gui.panel = newImagePanel
    elseif editor.tool == "layers" then
        editor.gui.panel = layersPanel
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

function editor.panels:wheelmoved(x, y)
    if editor.tool == "layers" then
        layersPanel:wheelmoved(x, y)
    end
end