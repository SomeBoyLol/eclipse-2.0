recents = gui:create("window", {color = {36/255, 36/255, 36/255}})


recents.title = gui:create("frame", {text = "recents", font = fonts.bigtitle, color = {1, 0, 0, 0}, width = 1500, height = 200, textAlignmentX = "left", textMargin = 0, x = 100})




gui:style({backButton})

recents.back = gui:create("button", {})

gui:style({button1})