--###################
--### KEYBINDINGS ###
--###################

-- Source Local Variables
local vars = require("hyprland.local")

-- Variables 
local browser = "qutebrowser"
local terminal = "kitty"
local mainMod = "SUPER"

hl.env("HYPRESHOT_DIR", vars.screenshots)

-- Rofi Menus
hl.bind(mainMod.." + R", hl.dsp.exec_cmd("rofi -show drun -display-drun '  App Laucher' -show-icons")) -- App Launcher
hl.bind(mainMod.." + N", hl.dsp.exec_cmd(vars.scripts.."new-file/new-file-rofi.sh")) -- New File menu
hl.bind(mainMod.." + SHIFT + V", hl.dsp.exec_cmd(vars.scripts.."cp-menu/paste-menu-clipboard.sh")) -- Paste to Clipboard Menu
hl.bind(mainMod.." + V", hl.dsp.exec_cmd(vars.scripts.."cp-menu/paste-menu-insert.sh")) -- Insert Clipboard Menu
hl.bind(mainMod.." + S", hl.dsp.exec_cmd(vars.scripts.."google-drive/rofi-sync-menu.sh")) -- Google-Drive Menu
hl.bind(mainMod.." + P", hl.dsp.exec_cmd(vars.scripts.."bw/bw.sh")) -- BitwardenVault Menu

-- App Binds
hl.bind(mainMod.." + B", hl.dsp.exec_cmd(browser)) -- Open Browser
hl.bind(mainMod.." + RETURN", hl.dsp.exec_cmd(terminal)) -- Open Kitty

-- Control Binds
hl.bind(mainMod.." + BACKSPACE", hl.dsp.window.close())
hl.bind(mainMod.." + DELETE", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"))
hl.bind(mainMod.." + F", hl.dsp.window.float({action = "toggle"}))
---- Move Window To Workspace
for i = 1, 10 do
  local key = i % 10
  hl.bind(mainMod.." + SHIFT + "..key,hl.dsp.window.move({workspace = i}))
end

-- Move Binds
---- Move Window Focus
hl.bind(mainMod.." + H", hl.dsp.focus({direction = "left"})) 
hl.bind(mainMod.." + L", hl.dsp.focus({direction = "right"})) 
hl.bind(mainMod.." + K", hl.dsp.focus({direction = "up"})) 
hl.bind(mainMod.." + J", hl.dsp.focus({direction = "down"})) 
---- Scroll Through Workspaces
hl.bind("ALT + L", hl.dsp.focus({workspace = "e+1"}))
hl.bind("ALT + H", hl.dsp.focus({workspace = "e-1"}))
---- Switch Workspaces
for i = 1, 10 do
  local key = i % 10
  hl.bind(mainMod.." + "..key, hl.dsp.focus({workspace = i}))
end

-- Screenshot Binds
hl.bind("PRINT",hl.dsp.exec_cmd("hyprshot -m active -m window --raw | satty --filename -"))
  --{mainMod, "insert", "exec", "hyprpicker | wl-copy"}, -- Color Picker !!!TEMP!!!

--
  ---- Screenshots
  ----{mainMod, "PRINT", "exec", "hyprshot -m window --raw | satty --filename -"}, -- Screenshot a window 
  --{"","PRINT", "exec", "hyprshot -m active --raw | satty --filename -"}, -- screenshot active window 
  --{mainMod.."SHIFT", "PRINT", "exec", "hyprshot -m region --raw | satty --filename -"}, -- screenshot region
--
--
  ---- Scratchpad
  --{mainMod, "S", "togglespecialworkspace", "magic"},
----})
--
--hl.bindm({
  --{mainMod, "mouse:272", "movewindow"},
  --{mainMod, "mouse:273", "resizewindow"},
--})
--hl.bindel({
  ---- Laptop multimedia keys for volume and brightness
  --{"","XF86AudioRaiseVolume", "exec", "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"},
  ----{"","XF86AudioLowerVolume", "exec", "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"},
  --{"","XF86AudioMute", "exec", "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"},
  --{"","XF86AudioMicMute", "exec", "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"},
  --{"","XF86MonBrightnessUp", "exec", "brightnessctl -e4 -n2 set 5%+"},
  --{"","XF86MonBrightnessDown", "exec", "brightnessctl -e4 -n2 set 5%-"},
--})
