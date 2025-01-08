local spritePanel = gui:create("frame", {
    text = "";
    color = editorGUI.secondaryColor;
    alignmentX = "right";
    alignmentY = "center";
    x = -40;
    width = 400;
    height = 700;
})

spritePanel.top = gui:create("frame", {text = "Sprites", font = fonts.medium, textAlignmentX = "left", textMargin = 20, width = 400, height = 75, color = editorGUI.primaryColor})

gui:style({{font = fonts.small, textAlignmentX = "left", color = editorGUI.secondaryColor, hoverColor = {0.3, 0.3, 0.3, 0.5}, editColor = {0.3, 0.3, 0.3, 0.5}}})

spritePanel.library = gui:create("button", {text = "", x = -10, y = 90, width = 50, height = 50, alignmentX = "right", func = function()
    imagesPanelOpen()
end})
spritePanel.library.icon = gui:create("image", {source = sprites.images, alignmentX = "center", alignmentY = "center"})

return spritePanel