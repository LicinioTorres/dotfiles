-- LOOK AND FEEL

local term_bg = "000A00"
local border_active = "33CC66"
local border_inactive = "00331A"
 
hl.config({
  general = {
    gaps_in = 2,
    gaps_out = 5,
    border_size = 5,
    ["col.active_border"] = "0xff"..border_active,
    ["col.inactive_border"] = "0xff"..border_inactive,
    resize_on_border = false,
    allow_tearing = false,
    layout = "master",
  },
  decoration = {
    rounding = 15, -- window rounding radious
    rounding_power = 2, -- super ellipse rounding formula
    active_opacity = 1.0,
    inactive_opacity = 0.7,
    shadow = {
      enabled = true,
      range = 10,
      render_power = 3,
      color = "rgba(16,18,24,1)"
    },
  },
})
