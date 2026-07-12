hl.on("hyprland.start", function () 
  hl.exec_cmd("numlockx on") --Start with numlock on
  hl.exec_cmd("systemctl") --user start hyprpolkitagent
  hl.exec_cmd("wl-paste") --watch cliphist store # execute listener for cliphist
  hl.exec_cmd("waybar & hyprpaper") -- Execute waybar, hyprpaper
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
  hl.exec_cmd("systemctl --user start hyprland-session.target")
end)
