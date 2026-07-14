hl.on("hyprland.start", function () 
  hl.exec_cmd("numlockx on") --Start with numlock on
  hl.exec_cmd("hyprlock") -- Start Hyprlock
  hl.exec_cmd("systemctl") --user start hyprpolkitagent
  hl.exec_cmd("wl-paste --type text --watch cliphist store") -- execute listener for cliphist text
  hl.exec_cmd("wl-paste --type image --watch cliphist store") --execute listener for cliphist
  hl.exec_cmd("waybar & hyprpaper") -- Execute waybar, hyprpaper
	hl.exec_cmd("systemctl --user start hyprpolkitagent") -- Start hyprland utils
  hl.exec_cmd("systemctl --user start hyprland-session.target") -- Start hyprland-session.target (uwsm was not starting it auto)
end)
