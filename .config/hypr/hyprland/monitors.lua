--################
--### MONITORS ###
--################

hl.monitor({
    output = "HDMI-A-2",
    mode = "1920x1080@60",
    position = "-1280x0",
    scale = 1.5 ,
})
hl.monitor({
    output = "eDP-1",
    mode = "1920x1080@60.05",
    position = "0x0",
    scale = 1.2,
})

-- Workspaces
hl.workspace_rule({
  workspace = "1",
  monitor = "HDMI-A-2",
  persistent = true
})
hl.workspace_rule({
  workspace = "2",
  monitor = "eDP-1",
  persistent = true
})
hl.workspace_rule({
  workspace = "3",
  monitor = "HDMI-A-2",
  persistent = true
})
hl.workspace_rule({
  workspace = "4",
  monitor = "eDP-1",
  persistent = true
})
hl.workspace_rule({
  workspace = "5",
  monitor = "HDMI-A-2",
  persistent = true
})
hl.workspace_rule({
  workspace = "6",
  monitor = "eDP-1",
  persistent = true
})
hl.workspace_rule({
  workspace = "7",
  monitor = "HDMI-A-2",
  persistent = true
})
hl.workspace_rule({
  workspace = "8",
  monitor = "eDP-1",
  persistent = true
})
hl.workspace_rule({
  workspace = "9",
  monitor = "HDMI-A-2",
  persistent = true
})
