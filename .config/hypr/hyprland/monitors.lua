--################
--### MONITORS ###
--################

hl.monitor({
    output = "HDMI-A-2",
    mode = "1920x1080@60",
    position = "1920x0",
    scale = 1.33 ,
})
hl.monitor({
    output = "DP-0",
    mode = "1920x1080@60",
    position = "1920x0",
    scale = 1.33 ,
})

-- Workspaces
hl.workspace_rule({
  workspace = "1",
  monitor = "HDMI-A-2",
})
hl.workspace_rule({
  workspace = "2",
  monitor = "DP-0",
})
hl.workspace_rule({
  workspace = "3",
  monitor = "HDMI-A-2",
})
hl.workspace_rule({
  workspace = "4",
  monitor = "DP-0",
})
hl.workspace_rule({
  workspace = "5",
  monitor = "HDMI-A-2",
})
hl.workspace_rule({
  workspace = "6",
  monitor = "DP-0",
})
hl.workspace_rule({
  workspace = "7",
  monitor = "HDMI-A-2",
})
hl.workspace_rule({
  workspace = "8",
  monitor = "DP-0",
})
hl.workspace_rule({
  workspace = "9",
  monitor = "HDMI-A-2",
})
